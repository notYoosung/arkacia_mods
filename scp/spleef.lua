minetest.register_node(":bear:spleefice",
    { description = "Spleef Ice", tiles = { "mcl_core_ice_packed.png" }, groups = { slippery = 3, dig_immediate = 3 }, _mcl_diggroups = { handy = { speed = 1, level = 1, uses = 0 }, }, sounds =
    mcl_sounds.node_sound_stone_defaults(), is_ground_content = false, _mcl_blast_resistance = 0, _mcl_hardness = 0, drop =
    "", })
local spleeficefunc = function(player)
    local pos = player:get_pos()
    local npos = vector.add(pos, mcl_player.node_offsets.stand)
    local node = minetest.get_node(npos)
    if minetest.get_node(npos).name == "bear:spleefice" then
        minetest.swap_node(npos, { name = "air" })
        minetest.sound_play({ name = "default_ice_dig", gain = 0.5 }, { pos = npos })
    end
end
table.insert(mcl_player.registered_globalsteps_slow, spleeficefunc)
minetest.register_alias("scp:spleefice", "bear:spleefice")
