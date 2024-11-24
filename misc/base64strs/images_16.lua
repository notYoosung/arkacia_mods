local strs = {
    images = {
        glow_squid_glint1 = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJCAYAAADgkQYQAAAAN0lEQVQY02NgIAfsv3bmP7oYEzEaURTNPrDhPzINA4y4rIABRy0TRgZ0k/ZfO/Mf3STqOZwoAAA6ZhpQ21YUIQAAAABJRU5ErkJggg==",
        glow_squid_glint2 = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJAgMAAACd/+6DAAAACVBMVEUAAACBpZaqwrie+tbnAAAAAXRSTlMAQObYZgAAABlJREFUCFtjYACBBghmnMDAoLUKQsPEgCwAR5wD927MfjIAAAAASUVORK5CYII=",
        glow_squid_glint3 = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJAgMAAACd/+6DAAAACVBMVEUAAAAzYWNNeXvNJO5LAAAAAXRSTlMAQObYZgAAABlJREFUCFtjYACBBghmnMDAoLUKQsPEgCwAR5wD927MfjIAAAAASUVORK5CYII=",
        glow_squid_glint4 = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJAgMAAACd/+6DAAAACVBMVEUAAAAgQFQqSFtpkKINAAAAAXRSTlMAQObYZgAAABlJREFUCFtjYACBBghmnMDAoLUKQsPEgCwAR5wD927MfjIAAAAASUVORK5CYII=",
        glyph_2 = "iVBORw0KGgoAAAANSUhEUgAAAAYAAAAGAQMAAADaAn0LAAAABlBMVEUAAADR0eePYWVNAAAAAXRSTlMAQObYZgAAABJJREFUCNdjEGBgYKhhYAHCGgAEvAER2HY56AAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
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
