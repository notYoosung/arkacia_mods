local strs = {
    images = {
        effect_withering = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAfElEQVQ4y6VTsQ3AIAwzEV/Rd9jgmnbrse2EhKhNUPEEmES2o4QjpQcbiABQS/5VfF43DJuIY8eGUZXijH1gUtX9Y6GWjFrytKG0oJQ0yYyLq2kryCn0NmZjNpYsy2DkqQLmtZ2VGlOBsQwYZ8r/ypsbolfsjnFlycLuOr/lUjnBtLCk7gAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        fancy_feather = "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",
        firework_blue = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAGFBMVEU/d+VlkOd+ouq/0fPU3/b3+f38/P7////VRDeMAAAALklEQVQIHWNgwARCSkCgCBRXdgECIyBDJSwtLdUJxEgvLy8jnQHTDjcQbgW67QD3ORVB6S4aVgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        firework_green = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAGFBMVEVY5T9452WO6n7H87/Z9tT4/ff8/vz///80vTgSAAAALklEQVQIHWNgwARCSkCgCBRXdgECIyBDJSwtLdUJxEgvLy8jnQHTDjcQbgW67QD3ORVB6S4aVgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        firework_red = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAGFBMVEXlPz/nZWXqfn7zv7/21NT99/f+/Pz////zwpH6AAAALklEQVQIHWNgwARCSkCgCBRXdgECIyBDJSwtLdUJxEgvLy8jnQHTDjcQbgW67QD3ORVB6S4aVgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
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
