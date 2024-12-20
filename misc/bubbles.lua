local blank = "blank.png^[png:"
local textures = {
    bubble_block = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAkUlEQVQ4EcWTMQ6AIAxFuZrn4za4OgBuBN3VM+gVMN9YtEwNGh1+SAj/9Reo6luX5jBljXZIJG9s4HLaGy4Fc+xiUyPAGGBb1gShqgTIADBKTPczBwD9YvMxQBqbJ7BB1RgJAu+/ANzfowRvAZymS5Gu9ORngg8BqEzVkRZzpPAdpdHLcxkACNc1xuizFI0/PDvSlb17TsQobgAAAABJRU5ErkJggg==",
}
for k, v in pairs(textures) do
    textures[k] = blank .. v
end

local bubble_colors = {
    "#d3a4f7",
    "#f3c1f0",
    "#d3a4f7",
    "#a2c0f8",
    "#a2f8df",
    "#a2c0f8",
}

local function spawn_bubble_spawner()


end

minetest.register_node(":arkacia:bubble_block", {
    description = "Bubble Block",
    tiles = {"arkacia_bubble_block.png"},
    groups = { dig_immediate = 3, },
    sounds = mcl_sounds.node_sound_slime_defaults(),
    use_texture_alpha = "clip",
})
local function bubble_wand_primary(itemstack, user, pointed_thing)
    spawn_bubble_spawner()
end
local function bubble_wand_secondary(itemstack, user, pointed_thing)
    if pointed_thing then
        local pos
        if pointed_thing.type == "node" then
            pos = pointed_thing.above
        elseif pointed_thing.type == "object" then
            local obj = pointed_thing.ref
            if obj then
                pos = obj:get_pos()
            end
        else
            if user then
                local look_height = user:get_eye_height() or 1.625
                pos = vector.add(vector.offset(user:get_pos(), 0, look_height, 0), vector.multiply(user:get_look_dir(), 3))
            end
        end
        if pos then
            local node = minetest.get_node(pos)
            if node and node.name == "air" then
                minetest.place_node(pos, { name = "arkacia:bubble_block_" .. math.random() })
            end
        end
    end
end
minetest.register_tool(":arkacia:bubble_wand", {
    description = "Bubble Wand",
    inventory_image = "arkacia_bubble_wand.png",
    on_use = bubble_wand_primary,
    on_secondary_use = bubble_wand_secondary,
    on_place = bubble_wand_secondary,
})