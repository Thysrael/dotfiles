#!/bin/bash
set -eu

[[ -n "${AEROSPACE_FOCUSED_WORKSPACE:-}" ]] || exit 0
command -v aerospace >/dev/null
command -v macism >/dev/null

# Let macOS finish activating the destination window before checking its source.
sleep 0.2
[[ "$(aerospace list-workspaces --focused)" == "$AEROSPACE_FOCUSED_WORKSPACE" ]] || exit 0
window_id=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null) || exit 0
[[ -n "$window_id" ]] || exit 0
[[ "$(macism)" == 'com.apple.keylayout.ABC' ]] || exit 0

# Password fields may require the system keyboard; leave secure input alone.
if ! /usr/bin/python3 -c '
import ctypes
import sys

carbon = ctypes.CDLL("/System/Library/Frameworks/Carbon.framework/Carbon")
carbon.IsSecureEventInputEnabled.restype = ctypes.c_bool
sys.exit(1 if carbon.IsSecureEventInputEnabled() else 0)
'; then
    exit 0
fi

# Discard a stale callback if the user has already moved to another window.
[[ "$(aerospace list-workspaces --focused)" == "$AEROSPACE_FOCUSED_WORKSPACE" ]] || exit 0
[[ "$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null)" == "$window_id" ]] || exit 0
[[ "$(macism)" == 'com.apple.keylayout.ABC' ]] || exit 0

# Keep macism's focus workaround enabled for reliable CJK activation on macOS 26.
exec macism im.rime.inputmethod.Squirrel.Hans 150
