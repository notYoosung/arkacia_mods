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


local glow_air = table.copy(air_def)
glow_air.groups = table.merge(glow_air.groups or {}, {

})
minetest.register_node(":arkacia:glow_air", glow_air)


local powered_glow_air = table.copy(air_def)
powered_glow_air.groups = table.merge(powered_glow_air.groups or {}, {

})
minetest.register_node(":arkacia:powered_glow_air", powered_glow_air)


local glow_air = table.copy(air_def)
glow_air.groups = table.merge(glow_air.groups or {}, {

})
minetest.register_node(":arkacia:glow_air", glow_air)


local water_air = table.merge(air_def, {
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

local function register_air()
    minetest.register_node(":arkacia:air_light",
        {
            description = "Aether",
        })
    end
minetest.register_alias("scp:scp_006", "scp:scp_006_source")




mcl_util._aether_activated = mcl_util._aether_activated or false
local duration = 10
if not mcl_util.scp_006_activated then
    mcl_player.register_globalstep_slow(function(player)
        if mcl_player.players[player].nodes.head == "arkacia:powered_glow_air" or mcl_player.players[player].nodes.feet == "arkacia:powered_glow_air" then
            mcl_potions.swiftness_func(player, 3, duration)
            mcl_potions.leaping_func(player, 2, duration)
        end
    end)
    mcl_util._aether_activated = true
end

