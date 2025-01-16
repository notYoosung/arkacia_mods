local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

holoschem = holoschem or {}

holoschem.modname = modname
holoschem.modpath = modpath


local files = {
    "render",
    "checkplace",
    "chatcommands",
}


if not mcl_util.holoschem_init then
    minetest.register_on_mods_loaded(function()
        for _, filename in ipairs(files) do
            dofile(modpath .. "/" .. filename .. ".lua")
        end
    end)
end



mcl_util.holoschem_init = true
