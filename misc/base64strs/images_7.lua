local strs = {
    images = {
        bearandme = "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",
        bee = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAANNJREFUWEdjZBhgwDjA9jMMHweUn//+H1dodhpy4vQo1UJgwByAbLGBKAfDhdc/GEA0CIDYIEDTEEB3ALLFMAdRywGgOIZHGXqQwyzDlg6o5QCQ2XBH4Ap6WLAjO4RmDkCPa2ItRVZHVC74/yUAI4tFuG1ACe0VuwLgfGS5lcfwlzVDwwGguE9OTmaYO3cuw/8vEJ/SNQSgiY8B5Ig5E98OnAPA2WAgQ2DAHDCaC2AhwMizYWDTACwB0j0bDngaoGW7kaiieNQBoyEwGgKjITCsQwAAL2yhIa61LugAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        bee_nest_top = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAD1BMVEWpiFvAk1XVrFvkyGvz2n/Y4whNAAAAa0lEQVQIHQXBARXCMBAD0CQG1jwEbGUOwL8FJLQOelcBcPwv2242RHc/ui+BZDegPOP3GZsiyG4eKrSnW20ZHAOAWKmThAoNG2iKXd9MQG64ewGqypiJFHKNwFGC7tfbB4RYMyKpWiPGmvkHAQIwhq1YLNUAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        bell_side = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACfklEQVQ4y2WTy24cVRRF17n3VlWXq7vdfiSYGGwkHgEx4DFgBhL5ASIxROIDMsnHIPgAhohB5khhwBxFikARURIH8Ygh0M+qrqr7OAw6NgLv8d5LW1vnyI3r116zjh4Q4BQYxMDBJzdHPxwdO2JoOHms6avP+wPrmAJJDIQerEPMhx9fefLBR1cWAGJ4MwYGYmiOjh1oApSXjkqyAU0MSAyIJox1uM++vh2FZ7p351Pdv/Qz63qf6fRHqtFbZHkBgHNLQhgy2X5C3wWePj3k9be/lBvXr4k5A5TDpLP5IV7H7D/3BsgY9ATVQEolvc9YLC8hJpGk6QC+uHVb3RmgyGtBK3rviMnRdBHTvUjdGJyL7Gw3rOodYoS9nXvFWe68QQiOcnAXwbBYQFUaolaEMCPPV6zbKSAoQtsNz2KcN8jsfdruHXq/oixzoMeaOaPR8yCW+bJlPBSsSXh/Hvu3QV1fxZgGK0vW613WraOvC9TXaOoZV9kzu2IIFwFb5U+AJVKi4knJYfMKCZ7gpwD0/g8AxOpFAMBy+TvGHCEYxFgIPYYBeba/MagHcnLX6AXAyS8F03lB0oj3U1KKxPY3aP5GYyAlT5a3iMx49HhwccRq+B7OeoqugfyAtn2Eq14gGYczW6gF5GUWK9ga7gp891/A3sNv8CFRdyVddAjQdB1Z2eG1xKiQWzBG2HLteQO5e+fmHJD2rwejcndF718hc6ekdBk3+5Ou9BTrDJ1cxuucLD8AAqp5BHB+8WvVz743ZQF+eUw2rlA9BPzmQtfZZj9RnJ0gRJrTb0mhsNnw1c0p55N3kwo2H++RdPPXyv/U1Ug+RFXZnkyp/ftoJP0DwU4lZKF1rlsAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        bobber = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAVFBMVEUAAABBNStRQDVUUU9dSTxnUkRxWkd8X0yEfneHjpuTjoiWEiy3qJK4sqW5az3Iv6rJx8HOyLvTKjjl4trl5OD///9UUU+TjoiWEizOyLvTKjjl4tr8R0atAAAAFnRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIcgM1gAAAHNJREFUGFd1z+0OgzAIBVAqzmrrnK1Cv97/Pce6JmqM9xecAAlA1yxA1lrvPbQ0iDHmnJ/AObfdIKVUSnkCjUhXMEjAPA79CebAHzV0B2BgWPef/AGNALN6dRW0MbLCIYBIBbkB0kpU3yYITt/SVKu3rlm+aacNL8+GG90AAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
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