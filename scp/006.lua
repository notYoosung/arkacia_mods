--https://betawiki.scpslgame.com/index.php?title=Death_Messages
local S = minetest.get_translator(minetest.get_current_modname())
local WATER_VISC = 1
minetest.register_node(":scp:scp_006_flowing",
    {
        description = S("SCP-006 Flowing"),
        _doc_items_create_entry = false,
        wield_image =
        "(default_water_flowing_animated.png^[colorizehsl:0:0:0)^[verticalframe:64:0",
        drawtype = "flowingliquid",
        tiles = { "(default_water_flowing_animated.png^[colorizehsl:0:0:0)^[verticalframe:64:0" },
        special_tiles = { { image = "default_water_flowing_animated.png^[colorizehsl:0:0:0", backface_culling = false, animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 4.0 } }, { image = "default_water_flowing_animated.png^[colorizehsl:0:0:0", backface_culling = false, animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 4.0 } }, },
        sounds =
            mcl_sounds.node_sound_water_defaults(),
        is_ground_content = false,
        use_texture_alpha = "blend",
        paramtype = "light",
        paramtype2 =
        "flowingliquid",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        drop = "",
        drowning = 4,
        liquidtype =
        "flowing",
        liquid_alternative_flowing = ":scp:scp_006_flowing",
        liquid_alternative_source = ":scp:scp_006_source",
        liquid_viscosity =
            WATER_VISC,
        liquid_range = 7,
        waving = 3,
        post_effect_color = { a = 60, r = 0x03, g = 0x3C, b = 0x5C },
        groups = { disable_jump = 1, water = 3, liquid = 3, puts_out_fire = 1, not_in_creative_inventory = 0, freezes = 1, melt_around = 1, dig_by_piston = 1 },
        _mcl_blast_resistance = 100,
        _mcl_hardness = -1,
    })
minetest.register_node(":scp:scp_006_source",
    {
        description = S("Oil Source"),
        _doc_items_entry_name = S("Oil"),
        _doc_items_hidden = false,
        drawtype = "liquid",
        waving = 3,
        tiles = { { name = "default_water_source_animated.png^[colorizehsl:127:127:127", animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0 } } },
        special_tiles = { { name = "default_water_source_animated.png^[colorizehsl:127:127:127", animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 5.0 }, backface_culling = false, } },
        sounds =
            mcl_sounds.node_sound_water_defaults(),
        is_ground_content = false,
        use_texture_alpha = "blend",
        paramtype = "light",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        drop =
        "",
        drowning = 4,
        liquidtype = "source",
        liquid_alternative_flowing = ":scp:scp_006_flowing",
        liquid_alternative_source =
        ":scp:scp_006_source",
        liquid_viscosity = WATER_VISC,
        liquid_range = 7,
        post_effect_color = { a = 60, r = 0x03, g = 0x3C, b = 0x5C },
        groups = { disable_jump = 1, water = 3, liquid = 3, puts_out_fire = 1, freezes = 1, not_in_creative_inventory = 0, dig_by_piston = 1 },
        _mcl_blast_resistance = 100,
        _mcl_hardness = -1,
    })
minetest.register_alias("scp:scp_006", "scp:scp_006_source")