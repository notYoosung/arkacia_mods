local strs = {
    images = {
        firework_white = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAGFBMVEXJycnT09Pa2trs7Ozy8vL9/f3+/v7///9X9KlRAAAALklEQVQIHWNgwARCSkCgCBRXdgECIyBDJSwtLdUJxEgvLy8jnQHTDjcQbgW67QD3ORVB6S4aVgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        firework_yellow = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAGFBMVEXlwz/nzWXq1H7z6L/279T9/Pf+/vz////aHNAmAAAALklEQVQIHWNgwARCSkCgCBRXdgECIyBDJSwtLdUJxEgvLy8jnQHTDjcQbgW67QD3ORVB6S4aVgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        flame = "iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOBAMAAADtZjDiAAAAFVBMVEUAAACLi4vRbie3Owv8zHnlnkeRHw6XmibFAAAAAXRSTlMAQObYZgAAAFVJREFUeAFjAAJGBggQEgBTjCYCYIawiqIhiGvk4qwIpl2DAkG0SmiII1g6KNRZAKgrVFk1GEwbqwaB6CBjUyUgLaxkZmQGpBmTzZITQeYJCgoKMAAA9EMK7eIk2wQAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        frame = "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYBAMAAAASWSDLAAAAGFBMVEUtIiDUpzXqwWK6jCqWZCSHVhKkeCKEfnct2WaAAAAACHRSTlP/////////AN6DvVkAAAB2SURBVHgBfdDBCQIxEIXhl0kFSQf7KlDSQA7Rcw7mPoLYgu07QnQzIPvfPgLDI3AFkmkr58ztBCltXMattetdIYqZVAR9zaSb/yI4VEj/ItqBHeoRHfYDh9Af3LYKWV/cnLAONc/EkJmZSklkR3w+Pl8wrI61N+OmUKhO2k6OAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        garbage = "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",
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
