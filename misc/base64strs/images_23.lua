local strs = {
    images = {
        panel_green = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFRJREFUWEdjzFnH/p9hAAHjqANGQ2BQhoCYIm2yxav7mOZizQWjDqBNBGA3dbQgGk2EgzMERnPBgIfAaFE84CEw4Glg1AEDngZGHTCaCEdDgJ4hAAAL4lwh0sUJZQAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        panel_grey = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFNJREFUWEftlLENADAIw8rOY/z/Cnt7AO1Iw2AOiCLLwSJiL+EZBSAwkoC7t+wiM0vudQUUaOH/COURIeFMAqxAToBXLCcgd4ACcgcogIQQ+EngAI8QX2HI3Y3fAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        panel_lime = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFZJREFUWEdjlN7n+Z9hAAHjqANGQ2BQhgCrKg9N8sXv218wzMWaC0YdQJPwx2HoaEE0mggHZwiM5oIBD4HRonjAQ2DA08CoAwY8DYw6YDQRjoYAPUMAAJCWaEH0mWRyAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        panel_magenta = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFVJREFUWEftlEERACAMw5gOEIwG9IGOIQB4ju6RCej1culsWPciPKMABFISaF5DdjFtHbnXFVAghP8jlEeEhDkJsAI5AV6xnIDcAQrIHaAAEkLgJ4ENwrFoYXcnCeIAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        panel_orange = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFRJREFUWEdjPOjJ8J9hAAHjqANGQ2BQhoA6D22yxc0vmOZizQWjDqBNBGA3dbQgGk2EgzMERnPBgIfAaFE84CEw4Glg1AEDngZGHTCaCEdDgJ4hAAAjyllBAxaVlQAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
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
