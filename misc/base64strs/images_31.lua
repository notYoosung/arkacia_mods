local strs = {
    mailbox = {
        mailbox_mailbox = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAHlBMVEXSUDyqPCikNyW+RjLrloxzJyMsLCyBLCTj4M6+uZt9fGUNAAAAYUlEQVR4AUXLsQ2AMAwEwF/BBos6QgzACEhZwJEiNkhPwRAp2Rh/CnjpPine+CIqI5iAfQ2Ycz4I1lohGOAEbjUKfEPCUutF3JSxsf64dYmPiG8BpslNpfxjSXEehbuOnC/ThRT9T/U3PwAAAABJRU5ErkJggg==",
        mailbox_mailbox_bottom = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEWEIhl+Ihkr4CDKAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg==",
        mailbox_mailbox_free = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAHlBMVEVc0jxAqihApSVQvjKl6407cyMsLCw8giTP49mcvq0puNODAAAAYUlEQVR4AUXLsQ2AMAwEwF/BBos6QgzACEhZwJEiNkhPwRAp2Rh/CnjpPine+CIqI5iAfQ2Ycz4I1lohGOAEbjUKfEPCUutF3JSxsf64dYmPiG8BpslNpfxjSXEehbuOnC/ThRT9T/U3PwAAAABJRU5ErkJggg==",
        mailbox_mailbox_free_bottom = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEU1hRkzfxlPJp4WAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg==",
        mailbox_mailbox_free_side = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAG1BMVEVc0jxAqihApSV4zXGJ2YlqxF6K1og8giQ7cyMyIbFWAAAAUklEQVR4AVSMVwEFIRADY2FyB//rAQkBBfi38nqd7VUfMNwRQD2TAj87vpsYOZMgQ1trIo70nV0CzjmD8OjZC3HH/w/N8w9PRGEodF1FBxi0AwBzbhAC9lRFogAAAABJRU5ErkJggg==",
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
