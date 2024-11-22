local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
require 'io'


local file = [[local imgs = {]]


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

local function table_to_str(prepend, t)
    local s = { prepend }
    for k, v in pairsByKeys(t) do
        s[#s + 1] = "    [\"" .. k .. "\"] = \"" .. v .. "\",\n"
    end
    s[#s + 1] = "}\n"
    return table.concat(s)
end

local imgspath = modpath .. "/base64imgs"
local strspath = modpath .. "/base64strs"

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

local function write_base64_str(name, filestr)
    local file = assert(io.open(modpath .. "/base64strs/" .. name .. ".lua", "w"))
    file:write(filestr)
    file:close()
end
local function convert_dir(subdir)
    local dir = scandir(imgspath .. "/" .. subdir)

    for k, v in pairsByKeys(dir) do
        if not tostring(v):match("%.png$") then goto continue end
        
        local handle = assert(io.popen("base64 -i \"" .. imgspath .. "/" .. subdir .. "/" .. v .. "\""))
        local result = handle:read("*a"):trim()
        handle:close()

        file = file .. "\n        " .. v:gsub("%.png$", "") .. " = \"" .. result .. "\","

        ::continue::
    end
end
local dir = scandir(imgspath)
for k, v in pairsByKeys(dir) do
    if tostring(v):match("^%.") then goto continue end

    file = file .. "\n    " .. v .. " = {"
    convert_dir(v)
    file = file .. "\n    },"
    ::continue::

end
file = file .. "\n}"
write_base64_str("images", file)
