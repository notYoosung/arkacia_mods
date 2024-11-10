
minetest.register_node(":scp:playermodel", {
    description = "Player Model",
    drawtype = "mesh",
    mesh = "playermodel.obj",
    inventory_image = "3d_armor_stand_item.png",
    wield_image = "3d_armor_stand_item.png",
    tiles = { "(mcl_skins_base_1_mask.png^[colorize:#EEB592FF:alpha)^mcl_skins_base_1.png^mcl_skins_eye_1.png^(mcl_skins_bottom_1_mask.png^[colorize:#383532FF:alpha)^mcl_skins_bottom_1.png^mcl_skins_footwear_1.png^(mcl_skins_top_1_mask.png^[colorize:#346840FF:alpha)^mcl_skins_top_1.png^(mcl_skins_hair_1_mask.png^[colorize:#715D57FF:alpha)^mcl_skins_hair_1.png^mcl_skins_headwear_2.png" },
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    is_ground_content = false,
    stack_max = 16,
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, 1.4, 0.5 }
    },
    -- TODO: This should be breakable by 2 quick punches
    groups = { handy = 1, deco_block = 1, dig_by_piston = 1, attached_node = 1 },
    _mcl_hardness = 2,
    sounds = mcl_sounds.node_sound_wood_defaults(),
    on_construct = function(pos)
        spawn_stand_entity(pos)
    end,
    on_destruct = function(pos)
        drop_inventory(pos)
    end,
    on_rotate = function(pos, node, _, mode)
        if mode == screwdriver.ROTATE_FACE then
            node.param2 = (node.param2 + 1) % 4
            minetest.swap_node(pos, node)
            get_stand_entity(pos, node):update_rotation(node)
            return true
        end
        return false
    end,
})
