local strs = {
    images = {
        panel_purple = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFZJREFUWEdjjOfb+p9hAAHjqANGQ2BQhoAgswpN8sX7v3cwzMWaC0YdQJPwx2HoaEE0mggHZwiM5oIBD4HRonjAQ2DA08CoAwY8DYw6YDQRjoYAPUMAAJPWaEFjFIRkAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        panel_red = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFVJREFUWEftlMENACAIAyVhG/ffRLch0QHUJ5bHMUDTXK7YcF9NeEYBCJQk0CNSdjHdj9zrCiiQwv8RyiNCwpoEWIGcAK9YTkDuAAXkDlAACSHwk8AG70dfgc6kgfUAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        panel_white = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFNJREFUWEftlLENADAIw8oF/H8kAxe0B9CONAzmgCiyHCwi9hKeUQACIwm4e8suMrPkXldAgRb+j1AeERLOJMAK5AR4xXICcgcoIHeAAkgIgZ8EDq3hnOHGISAtAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        panel_yellow = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFRJREFUWEdjnNPK8J9hAAHjqANGQ2BQhoCCBG2yxYMXmOZizQWjDqBNBGA3dbQgGk2EgzMERnPBgIfAaFE84CEw4Glg1AEDngZGHTCaCEdDgJ4hAAAW4lwhV9M2DQAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        particles_effect = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAKAgMAAAAba5wtAAAACVBMVEUAAACZmZnMzMzIfDz5AAAAAXRSTlMAQObYZgAAAC5JREFUeAFjYFvCwCDAyMDQNMGBoYOlgaHDBYhXNDC4MDgwOK0EyjEwMHBNYAAArCwIL2291pUAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
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
