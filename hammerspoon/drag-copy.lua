-- End an unfinished left-button drag before delivering Command+C or Command+X.
-- Three-finger dragging can keep the drag open briefly after fingers lift.

if _G.dragCopyFix then _G.dragCopyFix.stop() end

local M = { dragging = false, copies = 0, cuts = 0 }
_G.dragCopyFix = M

local event = hs.eventtap.event
local types = event.types

local function observe(e)
    local kind = e:getType()
    if kind == types.leftMouseDown or kind == types.leftMouseUp then
        M.dragging = false
        return false
    end
    if kind == types.leftMouseDragged then
        M.dragging = true
        return false
    end

    if not M.dragging then return false end
    local key = e:getKeyCode()
    if key ~= hs.keycodes.map.c and key ~= hs.keycodes.map.x then return false end
    local flags = e:getFlags()
    if not flags.cmd or flags.ctrl or flags.alt or flags.shift or flags.fn then
        return false
    end

    M.dragging = false
    if key == hs.keycodes.map.c then
        M.copies = M.copies + 1
    else
        M.cuts = M.cuts + 1
    end
    -- Replace this key-down with mouse-up then the original key-down, in order.
    -- Keeping the original key-up avoids synthesizing another complete shortcut.
    return true, {
        event.newMouseEvent(types.leftMouseUp, hs.mouse.absolutePosition(), {}),
        e:copy(),
    }
end

M.tap = hs.eventtap.new({
    types.leftMouseDown,
    types.leftMouseDragged,
    types.leftMouseUp,
    types.keyDown,
}, observe)

function M.start()
    M.dragging = false
    M.tap:start()
    return M.tap:isEnabled()
end

function M.stop()
    M.tap:stop()
    M.dragging = false
end

M.start()
return M
