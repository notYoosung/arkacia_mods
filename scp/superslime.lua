local S = minetest.get_translator(minetest.get_current_modname())
minetest.register_node(":bear:superbouncyslimeblock",
    {
        description = S("Super Bouncy Slime Block"),
        _doc_items_longdesc = S(
            "Super bouncy slime blocks are very very bouncy and prevent fall damage."),
        drawtype = "nodebox",
        paramtype = "light",
        is_ground_content = false,
        node_box = { type = "fixed", fixed = { { -0.25, -0.25, -0.25, 0.25, 0.25, 0.25 }, { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }, } },
        selection_box = { type = "regular", },
        tiles = { "mcl_core_slime.png" },
        use_texture_alpha = "blend",
        groups = { dig_immediate = 3, bouncy = 200, fall_damage_add_percent = -100, deco_block = 1 },
        sounds = { dug = { name = "slimenodes_dug", gain = 0.6 }, place = { name = "slimenodes_place", gain = 0.6 }, footstep = { name = "slimenodes_step", gain = 0.3 }, },
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
    })
minetest.register_alias("scp:superbouncyslimeblock", "bear:superbouncyslimeblock")
minetest.register_node(":bear:bouncyblock",
    {
        description = S("Perfectly Bouncy Block"),
        _doc_items_longdesc = S(
            "Perfectly bouncy slime blocks bounce you the same height and prevent fall damage."),
        drawtype = "nodebox",
        paramtype =
        "light",
        is_ground_content = false,
        node_box = { type = "fixed", fixed = { { -0.25, -0.25, -0.25, 0.25, 0.25, 0.25 }, { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }, } },
        selection_box = { type = "regular", },
        tiles = { "mcl_colorblocks_glazed_terracotta_magenta.png" },
        use_texture_alpha =
        "blend",
        groups = { dig_immediate = 3, bouncy = 100, fall_damage_add_percent = -100, deco_block = 1 },
        sounds = { dug = { name = "slimenodes_dug", gain = 0.6 }, place = { name = "slimenodes_place", gain = 0.6 }, footstep = { name = "slimenodes_step", gain = 0.3 }, },
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
    })
minetest.register_alias("scp:perfectlybouncyblock", "bear:bouncyblock")
