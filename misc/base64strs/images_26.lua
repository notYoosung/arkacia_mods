local strs = {
    images = {
        portals_particle4 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAANklEQVQ4y2OcxHCSARnkMZij8CcxnPyPJs+IzGdioBAMvAGM6AKE/IwuPxzCgFQ/j6aDYZkOAAXiFdGNmSguAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        portals_particle5 = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAQklEQVQ4y2OcxHCSARnkMZij8PdyX0XhO3/VRuEzMVAIBt4ARnSBvdxX/6P5GUUNepgNhzAg5OfRdIA1TP4PszAAACHqGBSRI9fmAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        portfolio = "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",
        potion_overlay = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAVElEQVR4AWOgBITGpTEMSgNGDfj//z/DihUr/p86der/o0ePwDSQD8akGADSDMa/f/+GGUS8AUDFMM1wA4CGkmYAEEM1I7xBThiQbwAUowTiME1IADfWnDlmZpLwAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        prev_icon = "iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAMAAAD04JH5AAAAnFBMVEUAAAD///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+TINBkAAAAM3RSTlMAAwYHCQsZGx4gISIkJTQ1Njc5Oz1OVVlaW1xdXmJsb4uMjZykpaipqq3V1trc3eHl+P2vr4GeAAABqklEQVR4Xu3ZW1OCUBiFYQ7SCelopUZpRVGWUfD//1vQpHLYh6u9vqZZ7/We4QEX3Oh5jDHGGGOMMcbYPyoYjXzbGZeF8cXxnu2Qw/xk/nB3YjvlrjC5zd8fL23HnOUn6WtRvlzZzrkqPEzzz7ISA4Tj6+yjrMQA9fN/Xn9VYoD6+WdFc30hgJ9M8+b5SwF29y8D2OxPCrDdnxCg/fwlAK39iQB69w8H9O8fDRjcPxjQef8EAOH4Jlt37x8KUF4fCOh+f/AAxf6gANX+kAD1748D6K+PAWj2BwPo9ocCaPcHAhh+fwjAcn3nANP+EIDgYK7fHwIQnd+/afcHAUyWK+MDcA0I4plxgs4Blo8AAGD+DCIAthfRPcDyKQIAzAIEwLhECKBe4vSpUAswAM8/SnP1uwAC6N8FFEC7RBhAt0QcQLNEIEC9RCRAuUQoQLVELECxRDBguEQ0YLBEOKC/RDygt0QBQFcgAegIRABtgQygJRAC7ARSgK1ADLARyAF+BYKAH8FK8M/rRjBbLs5sp1wWxpPTfdshpwVRFNjOMMYYY4wxxhhj7O/1DV0y5uKHV/gyAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
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
