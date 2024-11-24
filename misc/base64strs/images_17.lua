local strs = {
    images = {
        glyph_3 = "iVBORw0KGgoAAAANSUhEUgAAAAYAAAAGAQMAAADaAn0LAAAABlBMVEUAAADR0eePYWVNAAAAAXRSTlMAQObYZgAAABJJREFUCNdj0GDgYNAAQgUGDQAEdADJhsfK+gAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        glyph_8 = "iVBORw0KGgoAAAANSUhEUgAAAAYAAAAGAQMAAADaAn0LAAAABlBMVEUAAADR0eePYWVNAAAAAXRSTlMAQObYZgAAABFJREFUCNdjEGAAQQsGBgYLAAMMAKEswcjYAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        hammer = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAeElEQVQ4y2NgIABCAv3/M5ALQJo/fvjwnyxDYJpBeOOqVWBDYj1t/pOsGd2Q9CAX4g0BacJmCFVcQnRYgJxMtiEgzYVR7v8DHUwxDCEYOyB/wjRjCxOSNJOULkCaQJodTbX/k5wyCWnGC0CaQYFGf82wQCNbM6UAAHmVzXwLhJD8AAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        heart = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJCAMAAADXT/YiAAAAOVBMVEUAAAAQEBF1JiBjJyE6UyYyRiNSHCBGHB6WZCSHVhIsLC0dHCGoNy9WeTdxJCrUpzUjIybES0SHLSVTRnR3AAAAAXRSTlMAQObYZgAAADJJREFUCFtFxrENwDAAwzDBXrXE/x/bIUXLifBLQlqIGk2J56j7lpKpLoVsN9C9gbbAA1MEAe/k9+tHAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        heart_poison = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJBAMAAAASvxsjAAAAG1BMVEUAAAA6UyZDYStWeTdojUf/AIr/X+//ju//z+9kqdXoAAAAAXRSTlMAQObYZgAAADFJREFUCB1jYAADjna2NAaGZuNiwwCGZhdjIzAJZBcZGysGMLArGYkClRUpJgBJkEIA858ItTLsOK0AAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
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
