--(mcl_skins_base_1_mask.png^[colorize:#EEB592FF:alpha)^mcl_skins_base_1.png^mcl_skins_eye_1.png^(mcl_skins_bottom_1_mask.png^[colorize:#383532FF:alpha)^mcl_skins_bottom_1.png^mcl_skins_footwear_1.png^(mcl_skins_top_1_mask.png^[colorize:#346840FF:alpha)^mcl_skins_top_1.png^(mcl_skins_hair_1_mask.png^[colorize:#715D57FF:alpha)^mcl_skins_hair_1.png^mcl_skins_headwear_2.png
local S = minetest.get_translator(minetest.get_current_modname())
local light = minetest.LIGHT_MAX
local function generate_action_on(color)
    local n = "mesecons_lightstone:lightstone_on"
    if color then n = (n or "") .. "_" .. (color or "") end
    return function(pos, node) minetest.swap_node(pos, { name = n, param2 = node.param2 }) end
end
local function generate_action_off(color)
    local n = "mesecons_lightstone:lightstone_off"
    if color then n = (n or "") .. "_" .. (color or "") end
    return function(pos, node) minetest.swap_node(pos, { name = n, param2 = node.param2 }) end
end
local ls_off_name = "mesecons_lightstone:lightstone_off"
local ls_off_def = {
    tiles = { "jeija_lightstone_gray_off.png" },
    groups = { handy = 1, dig_immediate = 3, pickaxey = 1, oddly_breakable_by_hand = 1, mesecon_effector_off = 1, mesecon = 2 },
    is_ground_content = false,
    description =
        S("Redstone Lamp"),
    _tt_help = S("Glows when powered by redstone power"),
    _doc_items_longdesc = S(
        "Redstone lamps are simple redstone components which glow brightly (light level @1) when they receive redstone power.",
        light),
    sounds = mcl_sounds.node_sound_glass_defaults(),
    mesecons = { effector = { action_on = generate_action_on(), rules = mesecon.rules.alldirs, } },
    _mcl_blast_resistance = 0.3,
    _mcl_hardness = 0.3,
}
local ls_on_name = "mesecons_lightstone:lightstone_on"
local ls_on_def = {
    tiles = { "jeija_lightstone_gray_on.png" },
    groups = { handy = 1, dig_immediate = 3, pickaxey = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1, mesecon = 2, opaque = 1 },
    drop =
    "node mesecons_lightstone:lightstone_off",
    is_ground_content = false,
    paramtype = "light",
    light_source = light,
    sounds =
        mcl_sounds.node_sound_glass_defaults(),
    mesecons = { effector = { action_off = generate_action_off(), rules = mesecon.rules.alldirs, } },
    _mcl_blast_resistance = 0.3,
    _mcl_hardness = 0.3,
}
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
    local name_off = (ls_off_name or "") .. "_" .. (name or "")
    local def_off = table.copy(ls_off_def)
    def_off.description = desc
    def_off._doc_items_longdesc = nil
    def_off._doc_items_create_entry = false
    def_off.mesecons.effector.action_on = generate_action_on(name)
    def_off.tiles[1] = (def_off.tiles[1] or "") .. (mask or "")
    local def_on = table.copy(ls_on_def)
    def_on.drop = name_off
    def_on.tiles[1] = (def_on.tiles[1] or "") .. (mask or "")
    def_on.mesecons.effector.action_off = generate_action_off(name)
    minetest.register_node(":" .. (name_off or ""), def_off)
    minetest.register_node(":" .. (ls_on_name or "") .. "_" .. (name or ""), def_on)
    minetest.register_craft({ type = "shapeless", output = name_off, recipe = { ls_off_name, "mcl_dye:" .. (dye or "") } })
end
