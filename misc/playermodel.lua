minetest.register_node(":scp:playermodel", {
    description = "Player Model",
    drawtype = "mesh",
    mesh = "mcl_armor_character.b3d",
    inventory_image = "3d_armor_stand_item.png",
    wield_image = "3d_armor_stand_item.png",
    tiles = {
        "(mcl_skins_base_1_mask.png^[colorize:#EEB592FF:alpha)^mcl_skins_base_1.png^mcl_skins_footwear_2.png^mcl_skins_eye_3.png^(mcl_skins_bottom_2_mask.png^[colorize:#46403DFF:alpha)^mcl_skins_bottom_2.png^(mcl_skins_top_3_mask.png^[colorize:#151515FF:alpha)^mcl_skins_top_3.png^(mcl_skins_hair_5_mask.png^[colorize:#010001FF:alpha)^mcl_skins_hair_5.png",
        "(mcl_armor_boots_netherite.png^[colorize:purple:50^(rib_boots.png^[colorize:#1c306b:150))",
        "blank.png"
    },
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    is_ground_content = false,
    stack_max = 16,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, 1.4, 0.5 }
    },
    groups = { handy = 1, deco_block = 1, attached_node = 1, dig_immediate = 3 },
    _mcl_hardness = 2,
    sounds = mcl_sounds.node_sound_wood_defaults(),
    on_construct = function(pos)
    end,
    on_destruct = function(pos)
    end,
    on_rotate = function(pos, node, _, mode)
        if mode == screwdriver.ROTATE_FACE then
            node.param2 = (node.param2 + 1) % 4
            minetest.swap_node(pos, node)
            return true
        end
        return false
    end,
})




local function spawn_stand_entity(pos, node)
    local luaentity = minetest.add_entity(pos, "mcl_armor_stand:armor_entity"):get_luaentity()
    if luaentity then
        luaentity:update_rotation(node or minetest.get_node(pos))
        return luaentity
    end
end
minetest.register_entity("mcl_armor_stand:armor_entity", {
    initial_properties = {
        physical = true,
        visual = "mesh",
        mesh = "3d_armor_entity.obj",
        visual_size = { x = 1, y = 1 },
        collisionbox = { -0.1, -0.4, -0.1, 0.1, 1.3, 0.1 },
        pointable = false,
        textures = { "blank.png" },
        timer = 0,
        static_save = true,
    },
    _mcl_fishing_hookable = true,
    _mcl_fishing_reelable = true,
    on_activate = function(self)
        self.data_to_save = minetest.deserialize(staticdata) or {}
        self.object:set_properties({ mass = 2, friction = 0.0, })
        self.object:set_velocity(vector.multiply(vector.random_direction(), max_speed))
        mcl_armor.update(self.object)
    end,
    on_step = function(self)
        if minetest.get_node(self.node_pos).name ~= "mcl_armor_stand:armor_stand" then
            self.object:remove()
        end
    end,
    update_armor = function(self, info)
        self.object:set_properties({ textures = { info.texture } })
    end,
    update_rotation = function(self, node)
        self.object:set_yaw(minetest.dir_to_yaw(minetest.facedir_to_dir(node.param2)))
    end,
    get_staticdata = function(self)
        return minetest.serialize(self.data_to_save)
    end,
})

--[[
/lua minetest.chat_send_player("@n", mcl_player.players[minetest.get_player_by_name("@n")].model)
/lua minetest.chat_send_player("@n", mcl_player.players[minetest.get_player_by_name("@n")].textures[1])
/lua core.get_meta(vector.new(992,-13,-1577)):set_string("commands",  mcl_player.players[minetest.get_player_by_name("@n")].model .." \n" .. mcl_player.players[minetest.get_player_by_name("@n")].textures[1])
--]]












minetest.register_node(":scp:playermodel_mtf_epsilon_11", {     description = "Player Model - MTF Epsilon-11\n\"NINE TAILED FOX\"",     drawtype = "mesh",     mesh = "mcl_armor_character.b3d",     inventory_image = "3d_armor_stand_item.png",     wield_image = "3d_armor_stand_item.png",     tiles = {         "blank.png^[png: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",         "blank.png",         "blank.png"     },     paramtype = "light",     paramtype2 = "facedir",     walkable = false,     is_ground_content = false,     stack_max = 16,     use_texture_alpha = "clip",     selection_box = {         type = "fixed",         fixed = { -0.5, -0.5, -0.5, 0.5, 1.4, 0.5 }     },     groups = { handy = 1, deco_block = 1, attached_node = 1, dig_immediate = 3 },     _mcl_hardness = 2,     sounds = mcl_sounds.node_sound_wood_defaults(),     on_construct = function(pos)     end,     on_destruct = function(pos)     end,     on_rotate = function(pos, node, _, mode)         if mode == screwdriver.ROTATE_FACE then             node.param2 = (node.param2 + 1) % 4             minetest.swap_node(pos, node)             return true         end         return false     end, })
