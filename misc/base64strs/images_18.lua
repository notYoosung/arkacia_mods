local strs = {
    images = {
        heart_regen_wither = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJCAYAAADgkQYQAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpUUqDlYQcchQneyiIrppFYpQIdQKrTqYXPoFTRqSFBdHwbXg4Mdi1cHFWVcHV0EQ/ABxdXFSdJES/5cUWsR4cNyPd/ced+8AoVFhmtU1C2i6baaTCTGbWxVDrwgjhAEEMSMzy5iTpBR8x9c9Any9i/Ms/3N/jl41bzEgIBLPMsO0iTeIpzZtg/M+cZSVZJX4nHjMpAsSP3Jd8fiNc9FlgWdGzUx6njhKLBY7WOlgVjI14knimKrplC9kPVY5b3HWKjXWuid/YSSvryxzneYwkljEEiSIUFBDGRXYiNOqk2IhTfsJH/+Q65fIpZCrDEaOBVShQXb94H/wu1urMDHuJUUSQPeL43yMAKFdoFl3nO9jx2meAMFn4Epv+6sNYPqT9Hpbix0BfdvAxXVbU/aAyx1g8MmQTdmVgjSFQgF4P6NvygH9t0DPmtdbax+nD0CGukrdAAeHwGiRstd93h3u7O3fM63+fgCKyHKwoIp7/gAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB+cIBxUnCkrPyAIAAACfSURBVBjTjY8xCsJAEEXfyJY2WyaKeg8P4xEEC8ErWGxra+rgESRlsMoNJAm4W+YGjoVuDAriVPNn/h/ewB8lAFp1CkABsrGiq5cGJLNitOrUnQ99Sl2n7v7UZXlB2auJy+kkBcDd3oE0SQAY/WLxIQBgKKCp2y/DcCaRY33dATBfzGjqFh8C+WmJsBUZAkejD4F8fEQyK/2l3vjxeuwfMFk/jleeovAAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        heart_regenerate = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJBAMAAAASvxsjAAAAHlBMVEUAAAB1JiCHLSWoNy/ES0T/AIr/X+//ju//z+//9u+Hi66rAAAAAXRSTlMAQObYZgAAADNJREFUCB1jYAADjna2NAaGZuNiwwCG5inGRkDSxRjILjI2VgxgYFcyEgUqK1JMAJIghQD+PwkFliTcewAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        heart_wither = "iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJCAYAAADgkQYQAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TpUUqDlYQcchQneyiIrppFYpQIdQKrTqYXPoFTRqSFBdHwbXg4Mdi1cHFWVcHV0EQ/ABxdXFSdJES/5cUWsR4cNyPd/ced+8AoVFhmtU1C2i6baaTCTGbWxVDrwgjhAEEMSMzy5iTpBR8x9c9Any9i/Ms/3N/jl41bzEgIBLPMsO0iTeIpzZtg/M+cZSVZJX4nHjMpAsSP3Jd8fiNc9FlgWdGzUx6njhKLBY7WOlgVjI14knimKrplC9kPVY5b3HWKjXWuid/YSSvryxzneYwkljEEiSIUFBDGRXYiNOqk2IhTfsJH/+Q65fIpZCrDEaOBVShQXb94H/wu1urMDHuJUUSQPeL43yMAKFdoFl3nO9jx2meAMFn4Epv+6sNYPqT9Hpbix0BfdvAxXVbU/aAyx1g8MmQTdmVgjSFQgF4P6NvygH9t0DPmtdbax+nD0CGukrdAAeHwGiRstd93h3u7O3fM63+fgCKyHKwoIp7/gAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB+cIBxUmALMBEF0AAACRSURBVBjTjY5BCoMwEEVfxEsYpe0dik1ziiziMdtFTyFVvIMGMcdIVxMChdJZDX/e//Phj1EAg3dJhMfzpQbvUgg7ANO8qHrwLllrSmOy1mCtYRzfAKmSS9dqulZTGnTTAFD96nLECEANsK3hCyi1XFyiz5cT2xo4YiSEnWlelBL61l/T3fT5jQA5qQRlFwDgA8+eN+dpE2ziAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
        heavy_core = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAV1BMVEUAAAASEhITEhMTExQTFBUUExUWFRYXFxcXGBoYFxcYGBkZGRkaGRsaGhocHB4cHCAcHR8eHiIfHRwfHyIgISUjJCglIiAmKCwtKihUSkVgVUttYFJ6bVloMPZsAAAAAXRSTlMAQObYZgAAAE9JREFUGBnNwckBgCAMBMBFAfFWlAhJ+q9TP+nBGfxJVTmLUoXhzH6STDAqLcbGAlPS6t2xLTBPmnt3pQAj3MahicJk4v3mLDBUtQvChM8LP6sEnrakblIAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
        horn = "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",
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
