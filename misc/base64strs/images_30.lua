local strs = {
    images = {
        z_arkacia_random_paper = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAA0VJREFUWEftl00obGEYx//T1NgYhZ0oUkwJiSQREitmJKVYkIgS+Uw2hkQ2lIWEEhM7pGzko6x8lYWFhSyYWUyUj/LVYHH0f+rc5g73zjld7rmLe1Zz3vfM+/zO8/7f//McEz65FEVRPhv/0zGTyWQKXOPDAB8wHOD8/FyZm5tDfn4+Li4uUFtbi5GREdhsNpSVlcl9b28vbm5usLGxgf7+fk3J0ZwBAlRUVCAqKgrl5eWyeGxsLHZ2diQ4AxKOFwG/BcA/AxEREXC5XHh8fMTs7CxOT0+xubkpAATMyMj42gwYrgHDAbxer9LY2CgaqKmpAbdgYmICYWFh6OnpQUtLCwoKCpCXlwdu1bdpQF2YQVZWVuD1erG0tCQBCfjw8IDd3d2vBwjMAEUXeAoINTAwQM/4egDDNWA4wGdOqB707OxsJCUlIScnR0RIw6qqqkJHRwcmJydxcHAgwo2Li5O5yspKdHd3y991OWGgFfsDhIaGigXTBf0BCJeSkgKfzye64BpZWVm4vLwUB9UMcH9/r4yOjorzNTQ0IDEx8YfTcSG+ocfj+ZABzjGoateEy83NRVNTk6yhGcBwDRgOoFZDVUBMK30gJCQE8/Pzsh1DQ0OIjIzUVITUhzRvgXoKVAGp5ZgleGxsDAkJCSgpKdEVXPcp8BfQ3t7e382A4Rr4D/BPZeDu7k78nD4fHx//k/Kfnp5wfHwMWnCw6+3tDRaLRf93QWtrqzSkhYWFWF5elsbEYrHIMeQ9C83Z2RnMZvMvGWZmZvDy8sJOSh/A4eEhSktLkZmZCf5mIAbc2tpCeno6urq6YLfbUVdXJ53ywsICVldXMTw8LH5RVFQkc2znp6enea8PgIXk6OgI4eHhuL29lRJMM3I6naiursb4+DhSU1NxdXWFmJgYCTo1NSUB+RHDisnS3dbWhubmZlitVu0AJycn8gYMxsButxvt7e2y34uLi3h9fZWU19fXS/ll5Xx+fkZycrJsGcvy+vq6PM8xWrnT6dQO4HA4ZEH1A4TBWIKZic7OTmxvb/9Wd2xg2VVfX18LOJtZn8+nHWBtbQ1paWmIjo4OJvCg8/v7+yguLmYXrR0g6Ko6H+jr68Pg4OAHgHfcRO4wuLPjggAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    },
    mailbox = {
        mailbox_letterbox = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAHlBMVEVOa50/Vn47UXhHYY6RpcgvQF4oN1EzRmbV3eqltdJLbBGlAAAAYUlEQVR4AUXLsQ2AMAwEwF/BBos6QgzACEhZwJEiNkhPwRAp2Rh/CnjpPine+CIqI5iAfQ2Ycz4I1lohGOAEbjUKfEPCUutF3JSxsf64dYmPiG8BpslNpfxjSXEehbuOnC/ThRT9T/U3PwAAAABJRU5ErkJggg==",
        mailbox_letterbox_bottom = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEUvQF4tPlwzMf3lAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg==",
        mailbox_letterbox_side = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAG1BMVEVOa50/Vn47UXh9lb6ZrMxog7OVqMozRmYvQF6K75IXAAAAUklEQVR4AVSMVwEFIRADY2FyB//rAQkBBfi38nqd7VUfMNwRQD2TAj87vpsYOZMgQ1trIo70nV0CzjmD8OjZC3HH/w/N8w9PRGEodF1FBxi0AwBzbhAC9lRFogAAAABJRU5ErkJggg==",
        mailbox_letterbox_top = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEVOa51NaZrtWhnRAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg==",
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
