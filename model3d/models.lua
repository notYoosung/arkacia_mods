

mcl_util.

minetest.register_entity(":model3d:model_entity", {
    initial_properties = {
        visual = "mesh",
        mesh = "model3d_cube.obj",
        textures = { "blank.png^[colorize:#a4a4a4:255" },
        static_save = true,
    },
    on_activate = function(self, staticdata)
        if staticdata ~= "" then
            local data = minetest.deserialize(staticdata)
            for k, v in data do
                self[k] = v
            end
        end
    end,
    on_step = function(self, dtime)
    end,
    on_rightclick = function(self, clicker)
    end,
})

local tool_model_spawner_secondary_formspec = table.concat({
    
}, "")
local function tool_model_spawner_primary(itemstack, player, pointed_thing)
    local meta = itemstack:get_meta()
    minetest.show_formspec(player:get_player_name(), "model3d:tool_model_spawner", table.concat({
        "formspec_version[4]",
        "size[8,8.5]",
        "position[0.5,0.5]",
        "label[0,0;Model Spawner]",
        "field[0,1;8,1;mesh;Mesh;]", mesh,
        "button[0,2;8,1;save;Save]",
        "list[current_player;main;0,4;8,4;]",
    }, ""))
end

local function tool_model_spawner_secondary(itemstack, player, pointed_thing)
    local meta = itemstack:get_meta()
    local mesh = meta:get_string("model3d:mesh")
    local pos
    if pointed_thing.type == "node" then
        pos = pointed_thing.above
    elseif pointed_thing.type == "object" and pointed_thing.ref then
        pos = pointed_thing.ref:get_pos()
    end
    if pos then
        local ent = minetest.add_entity(pos, "model3d:model_entity", minetest.serialize({
            mesh = mesh or "model3d_cube.obj",
            
        }))
    end

end


minetest.register_item(":model3d:tool_model_spawner", {
    description = "Model Spawner",
    inventory_image = "model3d_model_spawner.png",
    wield_image = "model3d_model_spawner.png",
    on_use = tool_model_spawner_primary,
    on_secondary_use = tool_model_spawner_secondary,
    on_place = tool_model_spawner_secondary,
})
