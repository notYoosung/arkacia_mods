local S = minetest.get_translator(minetest.get_current_modname())
local light = minetest.LIGHT_MAX
local ls_off_name = "mesecons_lightstone:lightstone_off"
local ls_on_name = "mesecons_lightstone:lightstone_on"
local colored_lamps = { { "white", S("White Redstone Lamp"), "white" }, { "grey", S("Grey Redstone Lamp"), "dark_grey" }, { "silver", S("Light Grey Redstone Lamp"), "grey" }, { "black", S("Black Redstone Lamp"), "black" }, { "red", S("Red Redstone Lamp"), "red" }, { "yellow", S("Yellow Redstone Lamp"), "yellow" }, { "green", S("Green Redstone Lamp"), "dark_green" }, { "cyan", S("Cyan Redstone Lamp"), "cyan" }, { "blue", S("Blue Redstone Lamp"), "blue" }, { "magenta", S("Magenta Redstone Lamp"), "magenta" }, { "orange", S("Orange Redstone Lamp"), "orange" }, { "purple", S("Purple Redstone Lamp"), "violet" }, { "brown", S("Brown Redstone Lamp"), "brown" }, { "pink", S("Pink Redstone Lamp"), "pink" }, { "lime", S("Lime Redstone Lamp"), "green" }, { "lightblue", S("Light Blue Redstone Lamp"), "lightblue" }, }
for _, row in ipairs(colored_lamps) do
    local name = row[1]
    local desc = row[2]
    local dye = row[3]
    local mask = "^[hsl:0:-100^(jeija_lightstone_gray_on.png^[multiply:" .. (name or "") .. "^[opacity:100)"
    if name == "lightblue" then
        mask = "^[hsl:0:-100^(jeija_lightstone_gray_on.png^[multiply:" ..
            (name or "") .. "^[hsl:0:200^[opacity:100)"
    end
    local name_off = ls_off_name .. "_" .. name
    local name_on = ls_on_name .. "_" .. name
    minetest.register_craft({ type = "shapeless", output = name_off, recipe = { ls_off_name, "mcl_dye:" .. (dye or "") } })



    local commdef = {
        groups = { handy = 1, dig_immediate = 3, opaque = 1, solid = 1, },
        is_ground_content = false,
        description = desc,
        sounds = mcl_sounds.node_sound_glass_defaults(),
        _mcl_blast_resistance = 0.3,
        _mcl_hardness = 0.3,
        _mcl_redstone = {
            connects_to = function(node, dir)
                return true
            end,
            update = function(pos, node)
                if mcl_redstone.get_power(pos) ~= 0 then
                    return { priority = 1, name = name_on }
                else
                    return { delay = 2, name = name_on }
                end
            end,
        },
    }

    minetest.register_node(":" .. name_off, table.merge(commdef, {
        tiles = { "jeija_lightstone_gray_off.png" .. mask },
        _tt_help = S("Glows when powered by redstone power"),
        _doc_items_longdesc = S(
        "Redstone lamps are simple redstone components which glow brightly (light level @1) when they receive redstone power.",
            light),
    }))

    minetest.register_node(":" .. name_on, table.merge(commdef, {
        tiles = { "jeija_lightstone_gray_on.png" .. mask },
        groups = table.merge(commdef.groups, { dig_immediate = 3, not_in_creative_inventory = 1, }),
        drop = name_off,
        light_source = light,
    }))

end
