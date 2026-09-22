-- AeroSpace owns the F10/F12 window-switching shortcuts.
dofile(hs.configdir .. "/eudic.lua")

-- Auto reload configuration when Lua files are updated
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
