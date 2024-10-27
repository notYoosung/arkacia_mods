local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "' .. directory .. '"')
    if pfile then
        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
    end
    return t
end

minetest.chat_send_all(tostring(pairs(scandir(modpath))))
