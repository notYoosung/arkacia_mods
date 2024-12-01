local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
minetest.register_node(":arkacia:poster_arkacia_news_1_0_3x3_5", {
    description = "Arkacia 1.0 News - New Spawn - Middle Middle",
    drawtype = "nodebox",
    tiles = {
        { name = texture },
        { name = texture },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
    },
    use_texture_alpha = "clip",
    node_box = fbox,
    collision_box = fbox,
    groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3, not_in_creative_inventory = 1, },
    selection_box = fbox,
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    node_placement_prediction = "",
    inventory_image = texture,
})
