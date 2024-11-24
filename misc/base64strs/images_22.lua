local strs = {
    images = {
        nutella_pusheen = "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",
        orb = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAA/BJREFUWEftVktvG1UYPePHzPjtxq/arpyiFsWOCAukKrCIhIRgw4ZfgFh4heim60aEjldsugV1smPHggWCRZFYobBBgAgqY1WVnDROnTgxtuPH+DG+aMaZ8cx4xp4iUIXE3c3c7/vOued73EvhBS/qBePjv0WgUPz4/gST2xTgNitHCCEUqIawy8WfR1VHCuSL2wcAck4Dy2TKuyWXE/ulBPLFbeIkkKUNITVht5Re5L+QgCU4yyK8kgRFGV0JIeg2TiGJohlvJPAcbUfCloAVeCS76kiMVlXOmGHZkrAkYAYPxJLwsD5H4KrReCCie3Yy86GwLzzgXjUHmSOQL273AbCqoS+6AjoQ0vx8gSCuxOJzKZDGY9SqT43H7vfQa9S1fwLPzeFZETAUnV72VDoLD22bTgWo1Wyg02ppoKZ0zKXCQGCteLdJgYqo3uFMTjtp4moGNMMoW1f8NF5ORBCkPRiMJzj8s4Onza4Gen5ag9iXhQTk4mwfH9qqYCBgzr16eppmkEhnlCCbqwm8vZbp3IxFfgky7ouBNKEr552NvcpJ6ptHRxro8WHFRgWyI/ClT9RNWwJsKAImHFXskuksvDQNn9eNj7bWyeZq4lsKMKSqcn5R+GyvfOPxWVvxOTupYSBOVRh2O+g3z1XMvsBz/qUEQlezcLk9il0md11JxXoqig82bx7ciIX3zdUMgPr8x/K7D4WqstXvddGon04VmUhoP9PUMUzJmQI7O/H8kaSVrD7/2dWXlECvXYvh9tb6D2HW27QggC9+evLOV/sHSpUORRH1k2dzdSDLVtZ1gz2B9DVQrumdoypQSEXw4Vbht0zIP6uqGRN7BXSFaE8AgL4IA/EkPMx0+Kg1QLtduPPmK8NbufhDswKNnpj49PvfNx/X52tAGg7QqddUNWxSYCIgW6td4KUZJC+74FYujvc2ctV8MvqrnF7ZrjsaB7/8ufL6148OlQEmt559F0AUeE4bq47aUA4aT6XBsNMBGWFprKUiw7ifPu4OpdCTs3bsqNXTRNF3gPzTMIwo6r7w4N4dyy4oFLcvCBBUNxlfAOzK7H0hqyCrsWi1Gg10LmaTcNBuQtR9m8fx0lGs7wYZ2Of3IxpLwOUyvjek8Qi16rTV1GWeggDGAs959TZWBIYADEZmEgsluNy0AIejy0j2t3oLhHVtuYyAfvDobA8Enrtu9n2uB4nsvEgNq1MrXQEilfnSdKyali2BjffvvTGiR3vLTrtsnwBSmecswWXff/VRSkBaZb40vdFs1lIClzUhX2Ury06rq/5/7lmuB80X735HCN6izE/iSyMK6P7Bc9occULYkQJOAv1dm/8J/AVfG7Mw0zs7zAAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        panel_blue = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFZJREFUWEdjFA7b+Z9hAAHjqANGQ2BQhgCTkDJN8sW/d3cxzMWaC0YdQJPwx2HoaEE0mggHZwiM5oIBD4HRonjAQ2DA08CoAwY8DYw6YDQRjoYAPUMAAIW2aEEHvdjeAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        panel_cyan = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFRJREFUWEdjZJjS959hAAHjqANGQ2BwhoCcFG3yxaNnGOZizwWjDqBNBGA1dbQgGk2EgzQERnPBgIfAaFE84CEw4Glg1AEDngZGHTCaCEdDgI4hAADjclxBxI7FUwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        panel_dark_green = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAFFJREFUWEftlLERADAIAnGYNNl/mwyTDKCtweIdgONeILR1ZbzAAARmElhNtThZt24BBpo+UMkyRIRwKAFaYCfAFNsJ2DOAAXsGMEAIIfCRwAOE3zFBO4VN4wAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
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
