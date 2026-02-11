require("full-border"):setup()

-- home shortcut in status line
function Status:name()
	local h = self._current.hovered
	if not h then
		return ui.Span("")
	end

	local home = os.getenv("HOME")
	local function format_path(p)
		p = tostring(p)
		if home and p:sub(1, #home) == home then
			return "~" .. p:sub(#home + 1)
		end
		return p
	end

	local path = format_path(h.url)
	if h.link_to then
		local target = " -> " .. format_path(h.link_to)
		return ui.Line {
			ui.Span(" " .. path),
			th.mgr.symlink_target and ui.Span(target):style(th.mgr.symlink_target) or ui.Span(target),
		}
	else
		return ui.Span(" " .. path)
	end
end

-- add user:group in status line
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)),
		" ",
	}
end, 500, Status.RIGHT)
