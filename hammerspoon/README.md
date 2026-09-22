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
