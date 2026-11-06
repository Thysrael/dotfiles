-- AeroSpace owns the F10/F12 window-switching shortcuts.
dofile(hs.configdir .. "/eudic.lua")

-- Allow the hs CLI to inspect and toggle the drag-copy workaround.
require("hs.ipc")
dofile(hs.configdir .. "/drag-copy.lua")

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
