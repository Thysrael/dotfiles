# Hammerspoon

Install [Hammerspoon](https://www.hammerspoon.org/), then deploy from the repository root:

```sh
make hammerspoon
```

This links this directory to `~/.config/hammerspoon`. It assumes Hammerspoon's
`MJConfigFile` preference already points to `~/.config/hammerspoon/init.lua`, as
configured on this Mac. The Makefile does not change application preferences.
Reload the configuration after deployment. Grant Accessibility permission in
System Settings → Privacy & Security → Accessibility.

F10 (messaging) and F12 (Kitty) are handled by AeroSpace. Hammerspoon does not
register these shortcuts, avoiding competing window-switching behavior.

## Copy or cut immediately after dragging

`init.lua` loads the experimental `drag-copy.lua` workaround. If Command+C or Command+X arrives
after a left-button drag but before its mouse-up, it sends mouse-up at the current
pointer position followed by the original key-down. This aims to finish the
three-finger drag grace period before the application handles Copy or Cut. It adds
no fixed delay and does not send a second shortcut.

This uses mouse events, so it also ends a physical mouse drag when you press
Command+C or Command+X during that drag. Ordinary copies/cuts and shortcuts with additional
modifiers pass through unchanged. Actual three-finger behavior still needs to be
checked in WPS and PowerPoint.

Use the `hs` CLI to turn it off/on for comparison:

```sh
hs -c 'dragCopyFix.stop()'
hs -c 'return dragCopyFix.start()'
hs -c 'return hs.inspect({enabled = dragCopyFix.tap:isEnabled(), copies = dragCopyFix.copies, cuts = dragCopyFix.cuts})'
```

`copies` and `cuts` count intercepted copies and cuts since configuration reload. Reload enables the
workaround again; remove its `dofile` line from `init.lua` to disable it persistently.
The configuration loads `hs.ipc` for these CLI commands, which are also usable in
the Hammerspoon Console without the `hs -c` wrapper.

## Eudic four-finger tap

`init.lua` loads `eudic.lua`. It recognizes a short, stationary four-finger tap
and sends only Control + Option, held for 350 ms before release. Configure Eudic's
automatic word lookup to require those two modifiers.

Move the pointer over an English word and tap with four fingers to look it up.

Adjust `holdSeconds`, `maxTapSeconds`, and `maxMovement` in `eudic.lua` as needed.
The existing config watcher reloads Lua changes. To disable the feature, remove
the `dofile(hs.configdir .. "/eudic.lua")` line from `init.lua`.

This implementation uses Hammerspoon's built-in gesture event API. Touch delivery
can depend on macOS and the foreground application. Gesture recognition and
Eudic's response still require live testing, particularly on macOS 27.
