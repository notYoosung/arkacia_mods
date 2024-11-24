local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
require 'io'

--check if already has id card and taser
local prepend = [[local strs = {
]]
local append = [[}

for kStr, kVal in pairs(strs) do
    local fbox = {type = "fixed", fixed = {-8/16, -1/2, -8/16, 8/16, -7.5/16, 8/16}}
    for i,v in pairs(kVal) do
        local def = {
            use_texture_alpha = "clip",
            groups = {oddly_breakable_by_hand=1, z_item=1, dig_immediate=3},
            node_placement_prediction = "",
        }
        local itemname = i
        local register_func = minetest.register_node
        local image_def = {
            description = "Image Poster: " .. kStr .. "_" .. itemname,
            drawtype = "nodebox",
            selection_box = fbox,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            node_box = fbox,
            collision_box = fbox,
            tiles = {
                {name = "blank.png^[png:" .. v},
                {name = "blank.png^[png:" .. v},
                {name = "blank.png"},
                {name = "blank.png"},
                {name = "blank.png"},
                {name = "blank.png"},
            },
        }
        if i:gmatch("^item_") then
            itemname = i:gsub("^item_", "")
            register_func = minetest.register_craftitem
            table.update(def, {
                description = "Image Item: " .. kStr .. "_" .. itemname,
                inventory_image = "blank.png^[png:" .. v,
            })
        elseif i:gmatch("^node_") then
            itemname = i:gsub("^node_", "")
            register_func = minetest.register_node
            table.update(def, {
                description = "Image Block: " .. kStr .. "_" .. itemname,
                tiles = {
                    {name = "blank.png^[png:" .. v},
                }
            })
        elseif i:gmatch("^image_") then
            itemname = i:gsub("^image_", "")
            register_func = minetest.register_node
            table.update(def, image_def)
        else
            register_func = minetest.register_node
            table.update(def, image_def)
        end
        register_func(":arkacia:images_" .. kStr .. "_" .. itemname, def)

    end
end
]]

local strs = {

}



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

local function table_to_str(t)
    local s = { prepend  }
    for k, v in pairsByKeys(t) do
        s[#s + 1] = "    " .. k .. " = {\n"
        for k2, v2 in pairsByKeys(v) do
            s[#s + 1] = "        " .. k2 .. " = \"" .. v2 .. "\",\n"
        end
        s[#s + 1] = "    },\n"
    end
    s[#s + 1] = append
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
    -- minetest.register_on_mods_loaded(function()
        dofile(modpath .. "/base64strs/" .. name .. ".lua")
    -- end)
end


local function convert_dir(subdir)
    local dir = scandir(imgspath .. "/" .. subdir)

    for k, v in pairsByKeys(dir) do
        if not tostring(v):match("%.png$") then goto continue end
        
        local handle = assert(io.popen("base64 -i \"" .. imgspath .. "/" .. subdir .. "/" .. v .. "\""))
        local result = handle:read("*a"):trim()
        handle:close()

        strs[subdir][v:gsub("%.png$", "")] = result

        ::continue::
    end
end
local dir = scandir(imgspath)
for k, v in pairsByKeys(dir) do
    if tostring(v):match("^%.") then goto continue end
    
    strs[v] = {}
    convert_dir(v)
    
    ::continue::
end
local n_files = 1
local count = 1
local cache = {}
for kStrs, subdir in pairsByKeys(strs) do
    cache[kStrs] = {}
    for k, v in pairsByKeys(subdir) do
        cache[kStrs][k] = v
        if count == 5 then
            write_base64_str("images_" .. n_files, table_to_str(cache))
            cache = {
                [kStrs] = {}
            }
            n_files = n_files + 1
            count = 0
        end
        count = count + 1
    end
end







