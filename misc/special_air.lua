local S = minetest.get_translator(minetest.get_current_modname())
local WATER_VISC = 1
local air_def = {
    _doc_items_create_entry = false,
    is_ground_content = false,
    use_texture_alpha = "clip",
    paramtype = "light",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    drop = "",
    drowning = 0,
    wield_image = "air.png",
    tiles = { "blank.png" },
    _mcl_blast_resistance = 100,
    _mcl_hardness = -1,
}

-- Glow Air
local glow_air = table.copy(air_def)
glow_air.groups = table.merge(glow_air.groups or {}, {
    description = "Enchanted Air",
})
minetest.register_node(":arkacia:enchanted_air", glow_air)


-- E Glow Air
local enchanted_glow_air = table.copy(air_def)
enchanted_glow_air.groups = table.merge(enchanted_glow_air.groups or {}, {
    description = "Glowing Enchanted Air",
})
minetest.register_node(":arkacia:enchanted_air_glow", enchanted_glow_air)


local water_air = table.merge(air_def, {
    description = "Water Air",
    liquidtype = "source",
    liquid_alternative_flowing = ":scp:scp_006_flowing",
    liquid_alternative_source = ":scp:scp_006_source",
    liquid_viscosity = WATER_VISC,
    liquid_range = 0,
    waving = 0,
    light_source = 10,
})
water_air.groups = table.merge(water_air.groups or {}, {
    water = 3, liquid = 3,
})
minetest.register_node(":arkacia:water_air", water_air)





mcl_util._aether_activated = mcl_util._aether_activated or false
local duration = 10
if not mcl_util._aether_activated then
    mcl_player.register_globalstep_slow(function(player)
        if mcl_player.players[player].nodes.head == "arkacia:enchanted_glow_air" or mcl_player.players[player].nodes.feet == "arkacia:enchanted_glow_air" then
            mcl_potions.swiftness_func(player, 3, duration)
            mcl_potions.leaping_func(player, 2, duration)
        end
    end)
    mcl_util._aether_activated = true
end

