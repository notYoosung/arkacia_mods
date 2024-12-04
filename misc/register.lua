for name, ndef in pairs(minetest.registered_nodes) do
    if minetest.get_item_group(name, "opaque") ~= 0 and minetest.get_item_group(name, "solid") ~= 0 then
        mcl_redstone._solid_opaque_tab[name] = true
    end
end
