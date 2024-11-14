local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

require 'io'

minetest.register_on_mods_loaded(function() 


    function scandir(directory)
        local i, t, popen = 0, {}, io.popen
        local pfile = popen('ls -a "' .. directory .. '"')
        for filename in pfile:lines() do
            i = i + 1
            t[i] = filename
        end
        pfile:close()
        return t
    end

    local ignorefiles = { "init", "sg", "_autogroup" }

    for k, v in pairs(scandir(modpath)) do
        if not tostring(v):match("%.lua$") then
            goto continue
        end
        for _, ignorefile in ipairs(ignorefiles) do
            if v == ignorefile .. ".lua" then goto continue end
        end

        minetest.log(k .. ": " .. tostring(v))
        dofile(modpath .. "/" .. tostring(v))
        ::continue::
    end


    
    
    dofile(modpath .. "/_autogroup.lua")
    
end)

minetest.registered_nodes["mcl_core:ice"].use_texture_alpha = "opaque"