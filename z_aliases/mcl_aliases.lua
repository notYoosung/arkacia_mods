minetest.register_on_mods_loaded(function()
    for k, v in pairs(minetest.registered_nodes) do
        -- print(k)
        if k:match("^mcl_") then
            local a = k:match("mcl_.*:(.*)")
            -- if not minetest.registered_aliases[a] then
                minetest.register_alias("mcl:" .. k:match("mcl_.*:(.*)"), k)
                minetest.register_alias(a, k)
            -- end
        end
    end
    minetest.register_alias("mcl:grass", "mcl_core:dirt_with_grass")
end)
--lamp stairs