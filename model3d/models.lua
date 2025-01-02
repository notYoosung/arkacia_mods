minetest.register_entity(":model3d:model_entity", {
    initial_properties = {
        visual = "mesh",
        mesh = "model3d_model.obj",
        textures = { "model3d_model.png" },
        static_save = true,
    },
    on_activate = function(self, staticdata)
    end,
    on_step = function(self, dtime)
    end,
    on_rightclick = function(self, clicker)
    end,
})

local function tool_model_spawner_primary(itemstack, player, pointed_thing)
end
local function tool_model_spawner_secondary(itemstack, player, pointed_thing)
end
minetest.register_item(":model3d:tool_model_spawner", {
    description = "Model Spawner",
    inventory_image = "model3d_model_spawner.png",
    wield_image = "model3d_model_spawner.png",
    on_use = tool_model_spawner_primary,
    on_secondary_use = tool_model_spawner_secondary,
    on_place = tool_model_spawner_secondary,
})