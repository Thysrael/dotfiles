local M = {}

local function is_space(key)
    return key:repr() == "space"
end

local function is_uppercase_letter(key)
    local repr = key:repr()
    return repr:match("^[A-Z]$") ~= nil
        or repr:match("^Shift%+[A-Za-z]$") ~= nil
end

local function reset(env)
    env.inline_ascii = false
    env.last_key_was_space = false
    env.engine.context:set_option("inline_ascii_mode", false)
end

function M.init(env)
    reset(env)
end

function M.func(key, env)
    if key:release() then
        return 2
    end

    local engine = env.engine
    local context = engine.context

    if env.inline_ascii and not context:get_option("ascii_mode") then
        reset(env)
    end

    if env.inline_ascii then
        if is_space(key) then
            if env.last_key_was_space then
                -- The second consecutive space is an exit gesture, not text input.
                context:set_option("ascii_mode", false)
                reset(env)
            else
                engine:commit_text(" ")
                env.last_key_was_space = true
            end
            return 1
        end

        env.last_key_was_space = false
        return 2
    end

    if
        is_uppercase_letter(key)
        and not context:get_option("ascii_mode")
        and not context:is_composing()
        and not context:has_menu()
    then
        context:set_option("ascii_mode", true)
        context:set_option("inline_ascii_mode", true)
        env.inline_ascii = true
        env.last_key_was_space = false
        return 2
    end

    if
        is_space(key)
        and not context:get_option("ascii_mode")
        and not context:is_composing()
        and not context:has_menu()
    then
        engine:commit_text(" ")
        context:set_option("ascii_mode", true)
        context:set_option("inline_ascii_mode", true)
        env.inline_ascii = true
        env.last_key_was_space = true
        return 1
    end

    return 2
end

return M
