local S = minetest.get_translator(minetest.get_current_modname())
local WATER_VISC = 1
local air_def = {
    _doc_items_create_entry = false,
    is_ground_content = false,
    drawtype = "airlike",
    use_texture_alpha = "clip",
    paramtype = "light",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    drop = "",
    drowning = 0,
    tiles = { "blank.png" },
    _mcl_blast_resistance = 100,
    _mcl_hardness = -1,
    sunlight_propagates = true,
    post_effect_color = { a = 30, r = 0xff, g = 0xff, b = 0xaa },
    groups = {},
}


local glow_air = table.merge(air_def, {
    description = "Enchanted Air",
})
glow_air.groups = table.merge(glow_air.groups, {
    _arkacia_enchanted_air = 1,
})
minetest.register_node(":arkacia:enchanted_air", glow_air)


local enchanted_glow_air = table.merge(air_def, {
    description = "Glowing Enchanted Air",
    light_source = 10
})
enchanted_glow_air.groups = table.merge(enchanted_glow_air.groups, {
    _arkacia_enchanted_air = 1,
})
minetest.register_node(":arkacia:enchanted_air_glowing", enchanted_glow_air)


local water_air = table.merge(air_def, {
    description = "Water Air",
    liquidtype = "source",
    liquid_alternative_flowing = "arkacia:water_air",
    liquid_alternative_source = "arkacia:water_air",
    liquid_viscosity = WATER_VISC,
    liquid_range = 0,
    waving = 0,
    light_source = 3,
})
water_air.groups = table.merge(water_air.groups, {
    water = 3, liquid = 3, _arkacia_enchanted_air = 1,
})
minetest.register_node(":arkacia:water_air", water_air)





mcl_util._aether_activated = mcl_util._aether_activated or false
local duration = 1
if not mcl_util._aether_activated then
    minetest.log("mcl_util._aether_activated")
    mcl_player.register_globalstep_slow(function(player)
        if minetest.get_item_group(mcl_player.players[player].nodes.head, "_arkacia_enchanted_air") == 1 or minetest.get_item_group(mcl_player.players[player].nodes.feet, "_arkacia_enchanted_air") == 1 then
            mcl_potions.swiftness_func(player, 3, duration)
            mcl_potions.leaping_func(player, 3, duration)
        end
    end)
    mcl_util._aether_activated = true
end

