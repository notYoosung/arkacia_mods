local strs = {
    images = {
        particles_nether_portal = "iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHAQMAAAD+nMWQAAAABlBMVEUAAADPAM80T7eTAAAAAnRSTlMA4NaZL0AAAAAWSURBVHicY2BhiGDQYwhhWMcgwaABAAvKAc0uZpf7AAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        particles_nether_portal_t = "iVBORw0KGgoAAAANSUhEUgAAAAcAAAAHAQMAAAD+nMWQAAAABlBMVEUAAACfAN9FRIlHAAAAAnRSTlMAkmiSP1AAAAAUSURBVHicY1BhiGDQYwhhWAektQAOLAIvRRPfNAAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        photo = "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",
        pink_petals = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAD1BMVEUAAADlgZ3tl6/2ssX7ytiqDkT3AAAAAXRSTlMAQObYZgAAAExJREFUCB0FwQENwkAMAMBLVwVg4FkQ8NkqoCz1r4k7sgFZZMPIeYD8Fccmarh2LINbvABOAMeGfFw7m+/0LYt6N4YZQBSxAJ8FOPkDYXkIJrvBpW4AAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        portals_particle3 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAANklEQVQ4y2OcxHCSARnkMZgzkAKYGCgEA28AI7rAJIaT/9HChBFNftiFARF+xis/EtPBMMwLAIZ8D3hw79m4AAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
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
