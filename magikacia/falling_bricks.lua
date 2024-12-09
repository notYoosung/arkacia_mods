minetest.register_node(":magikacia:deepslate_bricks_falling", {
    description = "Falling Deepslate Bricks",
    tiles = { "mcl_deepslate_bricks.png" },
    groups = { handy = 1, shovely = 1, falling_node = 1, dig_immediate = 3, },
    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 0.5,
    _mcl_hardness = 0.5,
    drop = "",
})
