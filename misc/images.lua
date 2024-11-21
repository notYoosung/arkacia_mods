local img_list = {
    lemon_lime = "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"

}

local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }

for k, v in pairs(img_list) do
    local texture = "blank.png^[png:" .. v
    minetest.register_node( ":arkacia:images_" .. k, {
        description = "Image: " .. k,
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
        groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3 },
        selection_box = fbox,

        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        node_placement_prediction = "",

        inventory_image = texture,
    })
end
