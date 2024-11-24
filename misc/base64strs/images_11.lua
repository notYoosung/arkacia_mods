local strs = {
    images = {
        dragonfly = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAN5JREFUWEftlEEKwjAQRX8I3kR063UE957As4hbETxEL9GdVLyJhMoIIyE0OBNJijBdT/Nf/v8Th5k/N7M+DOD/HTiFcYx71AM4eie+mHgwV9YYgMQ3APatAVi4CcByu/pY/rjeHTsQQ1SNIAagWA6XASzOMVWNIAbwC4/wDG9dAmkCwCKpExRHyauq+mlq5brdGuxECcTPAFS4tJgaJ9QAuZUrhVAD0O1yK0cQFMdwvonPFQ+SMHXg28qxE9I+qAHSfKd2niCqAGjKJZ1VOSA9VDNnAOaAOWAOmAPmwAsxzmMht+i76QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        droplet_bottle = "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAIklEQVR4AWMYRODMmTPhIExIUSoQN0BxKgUKMRWnDqLQAAAGxyG9Lmmh6AAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        earth_ruby = "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",
        effect_bad_omen = "iVBORw0KGgoAAAANSUhEUgAAABIAAAASAgMAAAAroGbEAAAACVBMVEUAAAA8OzuDbFapM62SAAAAAXRSTlMAQObYZgAAAEFJREFUCFtjYAAD0dDQUAcGqVWrVoHIqWAyFEJGIcilYPbUMBAZNg1IroyaBSSXZoFUTgXrDQOTURBzQCTEZDAAAIpeH0DOMih7AAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        effect_fire_proof = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEU8OzueTU2dMxGxAAAALklEQVQIHWNgYGCo/8dQ/46hfhVD/SKG+iaGvCaGhDYwOseQ8A+ECoEKwIiBAQCRKxFFrPnQuQAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    },
}

for kStr, kVal in pairs(strs) do
    local fbox = {type = "fixed", fixed = {-8/16, -1/2, -8/16, 8/16, -7.5/16, 8/16}}
    for i,v in pairs(kVal) do
        local def = {
            use_texture_alpha = "clip",
            groups = {oddly_breakable_by_hand=1, z_item=1, dig_immediate=3},
            node_placement_prediction = "",
        }
        local itemname = i
        local register_func = minetest.register_node
        local image_def = {
            description = "Image Poster: " .. kStr .. "_" .. itemname,
            drawtype = "nodebox",
            selection_box = fbox,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            node_box = fbox,
            collision_box = fbox,
            tiles = {
                {name = "blank.png^[png:" .. v},
                {name = "blank.png^[png:" .. v},
                {name = "blank.png"},
                {name = "blank.png"},
                {name = "blank.png"},
                {name = "blank.png"},
            },
        }
        if i:gmatch("^item_") then
            itemname = i:gsub("^item_", "")
            register_func = minetest.register_craftitem
            table.update(def, {
                description = "Image Item: " .. kStr .. "_" .. itemname,
                inventory_image = "blank.png^[png:" .. v,
            })
        elseif i:gmatch("^node_") then
            itemname = i:gsub("^node_", "")
            register_func = minetest.register_node
            table.update(def, {
                description = "Image Block: " .. kStr .. "_" .. itemname,
                tiles = {
                    {name = "blank.png^[png:" .. v},
                }
            })
        elseif i:gmatch("^image_") then
            itemname = i:gsub("^image_", "")
            register_func = minetest.register_node
            table.update(def, image_def)
        else
            register_func = minetest.register_node
            table.update(def, image_def)
        end
        register_func(":arkacia:images_" .. kStr .. "_" .. itemname, def)

    end
end
