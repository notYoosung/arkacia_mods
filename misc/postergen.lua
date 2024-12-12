local filelist = {}
for n_poster = 0, 15 do
    minetest.log((math.fmod(n_poster, 4) + 1))
    filelist[#filelist + 1] = "'/Users/ble/Downloads/assets for arkacia/PineTools.com_files 2/row-" .. (math.fmod(n_poster, 4) + 1) .. "-column-" .. math.floor(n_poster / 4) + 1 .. ".png'"
end


require 'io'


local function get_filestr(texture, n)
    return [[local texture = "blank.png^[png:]] .. texture .. [["
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - ]] .. n .. [[",
    drawtype = "nodebox",
    tiles = {
        { name = texture },
        { name = texture },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
    },
    use_texture_alpha = "clip",
    node_box = fbox,
    collision_box = fbox,
    groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3, not_in_creative_inventory = 1, },
    selection_box = fbox,
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    node_placement_prediction = "",
    inventory_image = texture,
}
if ]] .. n .. [[ == 1 then
    local function rad_to_param2(rad)
        local tau = math.pi * 2
        if rad < tau * 7 / 8 and rad >= tau * 5 / 8 then
            return 2
        elseif rad < tau * 5 / 8 and rad >= tau * 3 / 8 then
            return 5
        elseif rad < tau * 3 / 8 and rad >= tau * 1 / 8 then
            return 3
        else
            return 4
        end
    end
    table.update(def, {
        description = "Arkacia 1.0 News - New Spawn (4x4) - Top Left",
        groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3, not_in_creative_inventory = 0, },
        on_place = function(itemstack, placer, pointed_thing)
            local under = pointed_thing.under
            local player_name = placer and placer:get_player_name() or ""

            local rc = mcl_util.call_on_rightclick(itemstack, placer, pointed_thing)
            if rc then return rc end

            local pos
            local undername = minetest.get_node(under).name
            if minetest.registered_items[undername] and minetest.registered_items[undername].buildable_to then
                pos = under
            else
                pos = pointed_thing.above
            end


            local dir = placer and placer:is_player() and placer:get_look_dir() and
                rad_to_param2(placer:get_look_horizontal()) or 0

            local pos_list = {}
            local pln = 1
            for a = 0, 3 do
                for b = 0, 3 do
                    pos_list[pln] = {x=a, y=b}
                    pln = pln + 1
                end
            end
            for i, p in pairs(pos_list) do
                local botpos = vector.add(pos,
                    vector.rotate_around_axis(vector.new(p.x, -p.y, 0), vector.new(0, 1, 0),
                        math.round(placer:get_look_horizontal() / (math.pi / 2)) * (math.pi / 2)))

                if minetest.is_protected(botpos, player_name) and
                    not minetest.check_player_privs(player_name, "protection_bypass") then
                    minetest.record_protection_violation(botpos, player_name)
                    goto continue
                end

                local botdef = minetest.registered_nodes[minetest.get_node(botpos).name]
                if not botdef or not botdef.buildable_to then
                    goto continue
                end

                minetest.set_node(botpos, { name = "arkacia:poster_arkacia_news_1_0_4x4_" .. i, param2 = dir })
                ::continue::
            end

            if not minetest.is_creative_enabled(player_name) then
                itemstack:take_item()
            end
            return itemstack
        end,
    })
end
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_]] .. n .. [[", def)]]
end


local function write_file(filestr, n)
    local file = assert(io.open(minetest.get_modpath("misc") .. "/poster_4x4/" .. n .. ".lua", "w"))
    file:write(filestr)
    file:close()
end



for i, v in ipairs(filelist) do
    local t = ""
    local pfile = assert(io.popen('base64 -i ' .. v))
    t = pfile:read("*a"):trim()
    pfile:close()
    write_file(get_filestr(t, i), i)
end







local modpath = minetest.get_modpath("misc")

local skinspath = modpath .. "/poster_4x4"

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

local ignorefiles = {}

local dir = scandir(skinspath)
minetest.register_on_mods_loaded(function()    
    for k, v in pairs(dir) do
        if not tostring(v):match("%.lua$") then goto continue end
        for _, ignorefile in ipairs(ignorefiles) do if v == ignorefile .. ".lua" then goto continue end end
        
        minetest.log(k .. ": " .. tostring(v))
        dofile(skinspath .. "/" .. tostring(v))
        ::continue::
    end
end)

