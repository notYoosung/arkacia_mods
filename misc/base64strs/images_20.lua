local strs = {
    images = {
        leaf = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAuZJREFUWEftlE9LVFEYxp/33Dt3xhnNf32CFhHYIqa8CpEj0cagoAnaRBBYVwnCZX2BNi2FAq8SuGlpm9oEpaMIek2DwHDRJ5B0UmfuzOi9540zNja18cw4JUFnee857/N7n+e8h3DMi45ZH/8+gH3jTKf3am2jXieP7EAy3ZUHEAd4a2Xqc1utIEcFoGS6S1ZEV6ZWa65X84HfO0ymu/YAmAB4ZWpV/G0HkEyfXQY4qYSPxYG+we5nuaz/QAHQyZi17C4rR7TXkSJIDdlvwBjIbfhgMLV0JoLMmGeBwLoEdQOk7nU/Z8KwEipslyADSc2dcfWwbM24nvY01A/gdBfBpLpFMVeioBRCAajWZ11Pu672xmpL+x17jYHTKnb1Pb/pgxllALWEFCPTEwujOjHUDHBxuPeWKeUkgJi/XUS4F0K1TYLQ3LEPAGAv43rWHwFIOfZXf6vYoTJnMAzTUPlDmALx1tiBZkYzhpocSA3Zk/ls4Q6HkoQhEG9rQlAKUNgpIdEehzB+lmPg9qzrvTzMhdoAHHsj2A07TMs4qJvL+uUIquwv/5OMp3Pj3qOGAVwa7n1CYfiYiH55bnc28jAMATMWgRVTL7LikblZ90PLYeLlx0tnk9rT79hfJPMpIjo4o+ZfXcLyFyIk2pt+AMCfdb2ETm1tgJTTUwA4Wg2tXkBSuUvVNR/EQBxcmxlfed0wgP6759pkxFonQqRStHr2c5s+lDH7DnA+4y4164hrR3B58IIdCFqo2J/P+pAhI5qIwmoyEewGZWOMiNg1BK5Ojy29ayjAFed86y6LrAJQ3apbH01YMKMGV6Akh6UImdffu4tvdcW1HUjdt0dBeKgOFLaLaDoRAzMr8ZCZBYG+Zca9zlqEK3u1LmGf0+MTeP+Kl2dcSkFiE8wfg9C6Of9ifqcecW0H+pzukFCe/4BB6yytgbmJuU/1ilaf03NgqDdNzKmMuzjSCNGaARot+h/gvwPVDnwHdiwVMAfEqBAAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        lingering_bottle = "iVBORw0KGgoAAAANSUhEUgAAABAAAAASBAMAAACgFUNZAAAAG1BMVEUAAABmZpmZMwCZZjOZmczMzP//pf//zP////88nR5FAAAAAXRSTlMAQObYZgAAADlJREFUCFtjYCARKBlDNLCpOAuAGakMDI5gRgBQEMJoZ2ABMxwaYAwGDlawiAsDgyuYwRIa4kCczQB7EAUxraVvTgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        locked_map = "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",
        moon_phase_1 = "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",
        moon_phase_2 = "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",
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
