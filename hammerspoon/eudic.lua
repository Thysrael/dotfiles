-- Four-finger tap: briefly hold Control + Option for Eudic word lookup.

if _G.eudicFourTap then _G.eudicFourTap.stop() end

local M = {
    holdSeconds = 0.35,
    maxTapSeconds = 0.35,
    maxMovement = 0.025, -- Fraction of trackpad width/height.
    cooldown = 0.65,
    sessions = {},
    lastTap = -math.huge,
}
_G.eudicFourTap = M

local event = hs.eventtap.event
local function now() return hs.timer.absoluteTime() / 1e9 end

local function releaseKeys()
    if M.releaseTimer then M.releaseTimer:stop(); M.releaseTimer = nil end
    if M.holding then
        event.newKeyEvent(hs.keycodes.map.alt, false):post()
        event.newKeyEvent(hs.keycodes.map.ctrl, false):post()
        M.holding = false
    end
end

function M.trigger()
    if M.holding then return end
    -- Avoid starting a synthetic chord on top of the user's held modifiers.
    local flags = hs.eventtap.checkKeyboardModifiers()
    if flags.ctrl or flags.alt or flags.cmd or flags.shift or flags.fn then
        return
    end
    if not hs.accessibilityState() then return end
    M.holding = true
    -- The two-argument API emits modifier/flagsChanged events.
    M.releaseTimer = hs.timer.doAfter(M.holdSeconds, releaseKeys)
    event.newKeyEvent(hs.keycodes.map.ctrl, true):post()
    event.newKeyEvent(hs.keycodes.map.alt, true):post()
end

local function observe(e)
    local touches = e:getTouches()
    if not touches or #touches == 0 then return false end

    local t = now()
    local devices = {}
    for _, touch in ipairs(touches) do
        if touch.type == "indirect" then
            local id = touch.device or "trackpad"
            devices[id] = devices[id] or {}
            table.insert(devices[id], touch)
        end
    end

    for device, frame in pairs(devices) do
        local s = M.sessions[device]
        if s and t - s.updated > 0.8 then s = nil end
        if not s then
            s = { started = t, active = {}, origins = {}, count = 0, peak = 0 }
            M.sessions[device] = s
        end
        s.updated = t

        for _, touch in ipairs(frame) do
            local id = touch.identity
            local p = touch.normalizedPosition
            if touch.phase == "cancelled" then s.invalid = true end
            if id then
                if touch.touching and not touch.resting then
                    if not s.origins[id] then
                        if p then s.origins[id] = { x = p.x, y = p.y } end
                        s.count = s.count + 1
                    end
                    s.active[id] = true
                else
                    s.active[id] = nil
                end
                local origin = s.origins[id]
                if p and origin then
                    local dx, dy = p.x - origin.x, p.y - origin.y
                    if dx * dx + dy * dy > M.maxMovement ^ 2 then
                        s.invalid = true
                    end
                end
            end
        end

        local active = 0
        for _ in pairs(s.active) do active = active + 1 end
        s.peak = math.max(s.peak, active)
        if active == 0 then
            M.sessions[device] = nil
            if not s.invalid and s.peak == 4 and s.count == 4
                and t - s.started <= M.maxTapSeconds
                and t - M.lastTap >= M.cooldown then
                M.lastTap = t
                M.trigger()
            end
        end
    end
    return false -- Observe only; preserve native gestures.
end

M.tap = hs.eventtap.new({ event.types.gesture }, observe):start()

-- Also release synthetic keys when Hammerspoon exits or reloads its config.
local previousShutdown = hs.shutdownCallback
local shutdown = function()
    releaseKeys()
    if previousShutdown then previousShutdown() end
end
hs.shutdownCallback = shutdown

function M.stop()
    if M.tap then M.tap:stop() end
    releaseKeys()
    if hs.shutdownCallback == shutdown then hs.shutdownCallback = previousShutdown end
    if _G.eudicFourTap == M then _G.eudicFourTap = nil end
end

return M
