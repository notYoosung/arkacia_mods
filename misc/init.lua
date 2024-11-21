local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

require 'io'

minetest.register_on_mods_loaded(function()
	-- https://stackoverflow.com/a/70096863
	local function pairsByKeys(t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0
		local iter = function()
			i = i + 1
			if a[i] == nil then
				return nil
			else
				return a[i], t[a[i]]
			end
		end
		return iter
	end

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

	local ignorefiles = {"init", "sg", "_autogroup"}

	for k, v in pairsByKeys(scandir(modpath)) do
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

