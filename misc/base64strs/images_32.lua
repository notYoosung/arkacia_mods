local strs = {
    mailbox = {
        mailbox_mailbox_free_top = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEVc0jxbyT21WvskAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg==",
        mailbox_mailbox_side = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAG1BMVEXSUDyqPCikNyXNi3HZpYnEd17WooiBLCRzJyNBugL+AAAAUklEQVR4AVSMVwEFIRADY2FyB//rAQkBBfi38nqd7VUfMNwRQD2TAj87vpsYOZMgQ1trIo70nV0CzjmD8OjZC3HH/w/N8w9PRGEodF1FBxi0AwBzbhAC9lRFogAAAABJRU5ErkJggg==",
        mailbox_mailbox_top = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEXSUDzJUD0E0jCzAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg==",
        mailbox_unrent = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAANUlEQVR4AWP4//8/RRiJM2rAhckMz2CYZAMQmhGYZAPIwSgGkGoQxS4gKQwgfASbyrEwmpQB3VLVC0w9SnEAAAAASUVORK5CYII=",
    },
    thanksgiving = {
        item_apple = "iVBORw0KGgoAAAANSUhEUgAAAA8AAAARCAYAAAACCvahAAAAAXNSR0IArs4c6QAAAcRJREFUOE+lk79uE0EQh7/du/MfFCkguQDJgJSCjgp0iZQigpaCIiGh4gmQeIE0SLQgUfMUPAFCFPAAFCgFcbAFyGdj584+7PPtDbp1uMQcEZaYYnc12m9+M7Oziv8wtSy7v3VDnr09WLi/FPw3MBf9J3weeC78ilVZXREiD44uCzc7dR5E3ZLQguNltSaNimb79iYHHz/xJgxsSzYuNiDTfE8i7h8PCqY45OCjTR81jDG9GDEzutlPRISKaC5VLjAyhtf9Dk+mE8vZJQcfrvt44THpIMYVbaHfptRcIzSGrplyGEfshcO518K+j3z+QlV5GKWKTuZBtNYWHqYpvSwpw7u+j3vYtqpGOxaWLLOQdhy7/5jN6MuM1njCXhScKu+u30JaHSqZi1JOAdratMbR2sJBltAex+xE/ZNiTlLfvnKNuslrVSU4E6GdxHybjLkXDk8blkd/cX1NdnSNulLoNMNgbKpVA2NtGCRTRq5HKxzZlEtD8tytyJ3GVRQZ8ypBC2QKUlfxLvhaPFMJfux40jRwt7nG++CoeKqNRpMPvQ6RuOwno/KQnP1dT70Vqdc860o1OJ5LLYoWVJf6GGeD/nn+BXua0RKEY53UAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
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
