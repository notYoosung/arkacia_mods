local function register_id(clearance_level, texture_id)
    minetest.register_craftitem(":bear:id_card_" .. clearance_level, {description = minetest.colorize("#ff0", "ID Card") .. minetest.colorize("#FF1", "\nClearance Level: " .. tostring(clearance_level)), inventory_image = "mcl_maps_map_texture_" .. tostring(texture_id) .. ".tga"})
end


register_id(0, 116)
register_id(1, 109)
register_id(2, 110)
register_id(3, 112)
register_id(4, 111)
register_id(5, 114)


