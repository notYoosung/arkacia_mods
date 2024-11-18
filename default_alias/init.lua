local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)


local mcl_materials = dofile(modpath .. "/materials/mcl.lua")
local mt_materials = dofile(modpath .. "/materials/minetest.lua")

for k, v in pairs(mt_materials) do
    minetest.register_alias(v, mcl_materials[k])
end
