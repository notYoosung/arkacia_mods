local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

require 'io'
dofile(modpath .. "/base64.lua")
dofile(modpath .. "/postergen.lua")
minetest.register_on_mods_loaded(function()
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

	local ignorefiles = { "init", "sg", "_autogroup", "base64", "postergen" }

	for k, v in pairs(scandir(modpath)) do
		if not tostring(v):match("%.lua$") then goto continue end
		for _, ignorefile in ipairs(ignorefiles) do if v == ignorefile .. ".lua" then goto continue end end

		minetest.log(k .. ": " .. tostring(v))
		dofile(modpath .. "/" .. tostring(v))
		::continue::
	end
    -- minetest.after(3, function ()
    --     dofile(modpath .. "/_autogroup.lua")
    -- end)
end)

