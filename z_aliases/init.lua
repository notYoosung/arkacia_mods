local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
dofile(modpath .. "/mcl_aliases.lua")


-- minetest.register_on_mods_loaded(function()
--     for k, v in pairs(minetest.registered_items) do
--         minetest.log(tostring(string.match(v.description or "", "[^\n]+")) .. "," .. tostring(k))
--     end
--     for k, v in pairs(minetest.registered_entities) do
--         minetest.log(tostring(string.match(v.description or "", "[^\n]+")) .. "," .. tostring(k))
--     end
-- end)
