local kittyPrevApp = nil
hs.hotkey.bind({}, "F12", function()
    local APP_NAME = "kitty"
    local app = hs.application.get(APP_NAME)

    if app and app:isFrontmost() then
        -- Save height ratio before hiding
        local win = app:mainWindow()
        if win then
            local winFrame = win:frame()
            local screenFrame = win:screen():frame()
            local ratio = winFrame.h / screenFrame.h
            hs.settings.set("kitty_dropdown_ratio", ratio)
        end

        if kittyPrevApp and kittyPrevApp:isRunning() then
            kittyPrevApp:activate()
        end
        app:hide()
        kittyPrevApp = nil
    else
        kittyPrevApp = hs.application.frontmostApplication()
        hs.application.launchOrFocus(APP_NAME)

        -- Use a timer to ensure we capture the window after it focuses/launches
        hs.timer.doAfter(0.1, function()
            local app = hs.application.get(APP_NAME)
            if app then
                local win = app:mainWindow()
                if win then
                    local screen = hs.mouse.getCurrentScreen()
                    local frame = screen:frame()

                    -- Get saved ratio or default to 40%
                    local ratio = hs.settings.get("kitty_dropdown_ratio") or 0.4
                    -- Constrain ratio to reasonable limits
                    ratio = math.max(0.1, math.min(1.0, ratio))

                    local height = frame.h * ratio

                    win:setFrame({
                        x = frame.x,
                        y = frame.y,
                        w = frame.w,
                        h = height
                    }, 0)
                end
            end
        end)
    end
end)

local wechatPrevApp = nil
hs.hotkey.bind({}, "F10", function()
    local APP_NAME = "WeChat"
    local app = hs.application.get(APP_NAME)

    if app and app:isFrontmost() then
        if wechatPrevApp and wechatPrevApp:isRunning() then
            wechatPrevApp:activate()
        end
        app:hide()
        wechatPrevApp = nil
    else
        wechatPrevApp = hs.application.frontmostApplication()
        hs.application.launchOrFocus(APP_NAME)
    end
end)

-- Auto reload configuration when init.lua is updated
function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(hs.configdir, reloadConfig):start()

hs.alert.show("Hammerspoon config loaded")