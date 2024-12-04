local texture_default = "mcl_observers_observer_front.png"
local texture_accept = "mcl_droppers_dropper_front_horizontal.png"
local texture_deny = "mcl_dispensers_dispenser_front_horizontal.png"


local S = minetest.get_translator(minetest.get_current_modname())






























local rules_down = { { x = 0, y = -1, z = 0, spread = true } }
local function register_scanner(clearance_level, texture_off, texture_on)
    local commdef = {
        is_ground_content = false,
        sounds = mcl_sounds.node_sound_stone_defaults(),
        on_rotate = false,
        groups = { pickaxey = 1, material_stone = 1, not_opaque = 1, dig_immediate = 3, _arkacia_id_scanner = clearance_level, },
        _mcl_blast_resistance = 3.5,
        _mcl_hardness = 3.5,
        drop = "mcl_observers:observer_off",
        on_construct = function(pos)
            local timer = minetest.get_node_timer(pos)
            if not timer:is_started() then
                timer:start(mcl_redstone.tick_speed)
            end
        end,
        _mcl_redstone = {},
    }
    local commdef_off = table.merge(commdef, {
        groups = commdef.groups,
        description = "ID Scanner\n" .. minetest.colorize("#ff0", "Clearance Level: " .. tostring(clearance_level)),
        _tt_help = S("Rightclick with ID card to scan"),
        tiles = {
            texture_off, texture_off,
            texture_off, texture_off,
            texture_off, texture_off,
        },
        _mcl_redstone = {
            get_power = function(node, dir)
                return dir.y < 0 and 15 or 0
            end,
        },
        on_construct = function(pos)
            minetest.get_meta(pos):set_string("infotext", "ID Scanner\nClearance Level: " .. clearance_level .. "\nRight click with an Level-" .. clearance_level .. " ID card or higher.")
            local timer = minetest.get_node_timer(pos)
            if not timer:is_started() then
                timer:start(mcl_redstone.tick_speed * 15)
            end
        end,
        on_timer = function(pos)
            return true
        end,
        on_rightclick = function(pos, node, player, itemstack, pointed_thing)
            local itemname = itemstack:get_name()
            if not itemname:match("bear:id_card_") then return end
            local item_clearance = tonumber(itemstack:get_name():sub(14))
            if item_clearance ~= nil and item_clearance >= clearance_level then
                mcl_redstone.swap_node(pos, { name = "bear:id_scanner_" .. clearance_level .. "_on", param2 = node.param2 })
            end
        end,
        drop = "bear:id_scanner_" .. clearance_level .. "_off",
    })
    local commdef_on = table.merge(commdef, {
        _doc_items_create_entry = false,
        groups = commdef.groups,
        tiles = {
            texture_on, texture_on,
            texture_on, texture_on,
            texture_on, texture_on,
        },
        on_construct = function(pos)
            minetest.get_meta(pos):set_string("infotext",
            "ID Scanner\nClearance Level: " .. clearance_level .. "\nID accepted!")
            local timer = minetest.get_node_timer(pos)
            timer:start(mcl_redstone.tick_speed * 15)
        end,
        on_timer = function(pos)
            local node = minetest.get_node(pos)
            mcl_redstone.swap_node(pos, { name = "bear:id_scanner_" .. clearance_level .. "_off", param2 = node.param2 })
            return true
        end,
        drop = "bear:id_scanner_" .. clearance_level .. "_off",
    })

    minetest.register_node(":bear:id_scanner_" .. clearance_level .. "_on", commdef_on)
    minetest.register_node(":bear:id_scanner_" .. clearance_level .. "_off", commdef_off)
end
local ratio = "100"
register_scanner(0, texture_default .. "^[colorize:#808080:" .. ratio, texture_accept .. "^[colorize:#808080:" .. ratio)
register_scanner(1, texture_default .. "^[colorize:#469D6F:" .. ratio, texture_accept .. "^[colorize:#469D6F:" .. ratio)
register_scanner(2, texture_default .. "^[colorize:#3B85B8:" .. ratio, texture_accept .. "^[colorize:#3B85B8:" .. ratio)
register_scanner(3, texture_default .. "^[colorize:#F8D548:" .. ratio, texture_accept .. "^[colorize:#F8D548:" .. ratio)
register_scanner(4, texture_default .. "^[colorize:#ED762F:" .. ratio, texture_accept .. "^[colorize:#ED762F:" .. ratio)
register_scanner(5, texture_default .. "^[colorize:#B42538:" .. ratio, texture_accept .. "^[colorize:#B42538:" .. ratio)


local function register_id(clearance_level, texture_id)
    minetest.register_tool(":bear:id_card_" .. clearance_level,
        { description = minetest.colorize("#ff0", "ID Card") ..
        minetest.colorize("#FF1", "\nClearance Level: " .. tostring(clearance_level)), inventory_image =
        "mcl_maps_map_texture_" .. tostring(texture_id) .. ".tga^[makealpha:8,10,15" })
end


register_id(0, 116)
register_id(1, 109)
register_id(2, 110)
register_id(3, 112)
register_id(4, 111)
register_id(5, 114)
