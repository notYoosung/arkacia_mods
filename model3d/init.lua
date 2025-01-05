local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

require 'io'

local function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = assert(popen('ls -a "' .. directory .. '"'))
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

local dofiles = {
    "models",
}

minetest.register_on_mods_loaded(function()
    for k, v in pairs(dofiles) do
        minetest.log(k .. ": " .. tostring(v))
        dofile(modpath .. "/" .. tostring(v) .. ".lua")
    end
    
end)