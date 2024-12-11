local deepslate_runed_list = {
    "deepslate_runed_earth",
    "deepslate_runed_fire",
    "deepslate_runed_ice",
    "deepslate_runed_lightning",
    "deepslate_runed_poison",
    "deepslate_runed_telepathic",
    "deepslate_runed_void",
    "deepslate_runed_water",
    "deepslate_runed_wind",
}
for _, v in ipairs(deepslate_runed_list) do
    local name = v:gsub("deepslate_runed_", "")

    local texture_top = "mcl_deepslate_top.png"
    local texture_side = magikacia.textures[v]

    minetest.register_node(":magikacia:deepslate_runed_" .. name, {
        description = "Runed Deepslate: " .. string.upper(name),
        tiles = { texture_top, texture_top, texture_side, texture_side, texture_side, texture_side },
        is_ground_content = false,
        sounds = mcl_sounds.node_sound_stone_defaults(),
        paramtype2 = "facedir",
        groups = {
            building_block = 1,
            supports_mushrooms = 1,
            dig_immediate = 3,
        },
        on_place = mcl_util.rotate_axis,
        on_rotate = screwdriver.rotate_3way,
    })
end












local function check_placement_allowed(node, wdir)
    
    
    
    
    
    
    
    

    
    
    local def = minetest.registered_nodes[node.name]
    if not def then
        return false
        
    elseif wdir == 0 then
        return false
    elseif not def.buildable_to then
        if node.name ~= "mcl_core:ice" and node.name ~= "mcl_nether:soul_sand" and node.name ~= "mcl_mobspawners:spawner" and node.name ~= "mcl_core:barrier" and node.name ~= "mcl_end:chorus_flower" and node.name ~= "mcl_end:chorus_flower_dead" and (not def.groups.glass) and
            ((not def.groups.solid) or (not def.groups.opaque)) then
            
            if node.name == "mcl_end:dragon_egg" or node.name == "mcl_portals:end_portal_frame_eye" or def.groups.fence == 1 or def.groups.wall or def.groups.slab_top == 1 or def.groups.anvil or def.groups.pane or (def.groups.stair == 1 and minetest.facedir_to_dir(node.param2).y ~= 0) then
                if wdir ~= 1 then
                    return false
                end
            else
                return false
            end
        elseif minetest.get_item_group(node.name, "piston") >= 1 then
            return false
        end
    end
    return true
end

function magikacia.register_torch(def)
    local itemstring = ":magikacia:" .. def.name
    local itemstring_wall = itemstring .. "_wall"

    def.light = def.light or 14
    def.mesh_floor = def.mesh_floor or "mcl_torches_torch_floor.obj"
    def.mesh_wall = def.mesh_wall or "mcl_torches_torch_wall.obj"
    def.flame_type = def.flame_type or 1

    local groups = def.groups or {}

    groups.attached_node = 1
    groups.torch = 1
    groups.torch_particles = def.particles and 1
    groups.dig_by_water = 1
    groups.destroy_by_lava_flow = 1
    groups.dig_by_piston = 1
    groups.unsticky = 1
    groups.flame_type = def.flame_type or 1
    groups.attaches_to_top = 1
    groups.attaches_to_side = 1
    groups.offhand_item = 1
    groups.offhand_placeable = 1

    local floordef = {
        description = def.description,
        _doc_items_longdesc = def.doc_items_longdesc,
        _doc_items_usagehelp = def.doc_items_usagehelp,
        _doc_items_hidden = def.doc_items_hidden,
        _doc_items_create_entry = def._doc_items_create_entry,
        drawtype = "mesh",
        mesh = def.mesh_floor,
        inventory_image = def.icon,
        wield_image = def.icon,
        tiles = def.tiles,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        is_ground_content = false,
        walkable = false,
        light_source = def.light,
        groups = groups,
        drop = def.drop or itemstring,
        use_texture_alpha = "clip",
        selection_box = {
            type = "wallmounted",
            wall_bottom = { -2 / 16, -0.5, -2 / 16, 2 / 16, 1 / 16, 2 / 16 },
        },
        sounds = def.sounds,
        node_placement_prediction = "",
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type ~= "node" then
                return itemstack
            end

            local under = pointed_thing.under
            local node = minetest.get_node(under)
            local def = minetest.registered_nodes[node.name]
            if not def then return itemstack end

            if placer and placer:is_player() and not placer:get_player_control().sneak then
                local rc = mcl_util.call_on_rightclick(itemstack, placer, pointed_thing)
                if rc ~= nil then return rc end
            end

            local above = pointed_thing.above
            local wdir = minetest.dir_to_wallmounted({ x = under.x - above.x, y = under.y - above.y, z = under.z -
            above.z })

            if type(def.placement_prevented) == "function" then
                if
                    def.placement_prevented({
                        itemstack = itemstack,
                        placer = placer,
                        pointed_thing = pointed_thing,
                    })
                then
                    return itemstack
                end
            elseif check_placement_allowed(node, wdir) == false then
                return itemstack
            end

            local itemstring = itemstack:get_name()
            local fakestack = ItemStack(itemstack)
            local idef = fakestack:get_definition()
            local retval

            if wdir == 1 then
                retval = fakestack:set_name(itemstring)
            else
                retval = fakestack:set_name(itemstring_wall)
            end
            if not retval then
                return itemstack
            end

            local success
            itemstack, success = minetest.item_place(fakestack, placer, pointed_thing, wdir)
            itemstack:set_name(itemstring)

            if success and idef.sounds and idef.sounds.place then
                minetest.sound_play(idef.sounds.place, { pos = under, gain = 1 }, true)
            end
            return itemstack
        end,
        on_rotate = false,
    }
    minetest.register_node(":" .. itemstring, floordef)

    local groups_wall = table.copy(groups)
    groups_wall.torch = 2
    groups_wall.not_in_creative_inventory = 1

    local walldef = {
        drawtype = "mesh",
        mesh = def.mesh_wall,
        tiles = def.tiles,
        paramtype = "light",
        paramtype2 = "wallmounted",
        sunlight_propagates = true,
        is_ground_content = false,
        walkable = false,
        light_source = def.light,
        groups = groups_wall,
        drop = def.drop or itemstring,
        use_texture_alpha = "clip",
        _mcl_baseitem = itemstring,
        selection_box = {
            type = "wallmounted",
            wall_side = { -0.5, -0.3, -0.1, -0.2, 0.325, 0.1 },
        },
        sounds = def.sounds,
        on_rotate = false,
    }
    minetest.register_node(":" .. itemstring_wall, walldef)

    if minetest.get_modpath("doc") then
        doc.add_entry_alias("nodes", itemstring, "nodes", itemstring_wall)
    end
end

magikacia.register_torch({
    name = "ancient_torch",
    description = ("Ancient Torch"),
    icon = magikacia.textures.ancient_torch,
    tiles = { magikacia.textures.ancient_torch },
    light = 14,
    groups = { dig_immediate = 3, },
    sounds = mcl_sounds.node_sound_wood_defaults(),
})




local allowed_non_solid_nodes_floor = {
    "mcl_core:ice",
    "mcl_nether:soul_sand",
    "mcl_mobspawners:spawner",
    "mcl_core:barrier",
    "mcl_end:chorus_flower",
    "mcl_end:chorus_flower_dead",
    "mcl_end:end_rod",
    "mcl_end:dragon_egg",
    "mcl_portals:end_portal_frame_eye",
    "mcl_lanterns:chain"
}

local allowed_non_solid_groups_floor = { "anvil", "wall", "glass", "fence", "fence_gate", "pane", "slab_top" }

local allowed_non_solid_nodes_ceiling = {
    "mcl_core:ice",
    "mcl_nether:soul_sand",
    "mcl_mobspawners:spawner",
    "mcl_core:barrier",
    "mcl_end:chorus_flower",
    "mcl_end:chorus_flower_dead",
    "mcl_end:end_rod",
    "mcl_core:grass_path",
    "mcl_lanterns:chain"
}

local allowed_non_solid_groups_ceiling = { "anvil", "wall", "glass", "fence", "fence_gate", "soil", "pane",
    "end_portal_frame" }

local function check_placement(node, wdir)
    local nn = node.name
    local def = minetest.registered_nodes[nn]

    if not def then
        return false
    else
        if wdir == 0 then
            if def.groups.solid or def.groups.opaque then
                return true
            else
                for _, i in ipairs(allowed_non_solid_nodes_ceiling) do
                    if nn == i then
                        return true
                    end
                end
                for _, j in ipairs(allowed_non_solid_groups_ceiling) do
                    if def.groups[j] then
                        return true
                    end
                end
                return false
            end
        else 
            if def.groups.solid or def.groups.opaque then
                return true
            else
                for _, i in ipairs(allowed_non_solid_nodes_floor) do
                    if nn == i then
                        return true
                    end
                end
                for _, j in ipairs(allowed_non_solid_groups_floor) do
                    if def.groups[j] then
                        return true
                    end
                end
                return false
            end
        end
    end
end

function magikacia.register_lantern(name, def)
    local itemstring_floor = "magikacia:" .. name .. "_floor"
    local itemstring_ceiling = "magikacia:" .. name .. "_ceiling"

    local sounds = mcl_sounds.node_sound_metal_defaults()

    local groups = def.groups or {}
    groups.pickaxey = def.pickaxey or 1
    groups.attached_node = 1
    groups.deco_block = 1
    groups.lantern = 1
    groups.attaches_to_top = 1
    groups.attaches_to_base = 1
    groups.dig_immediate = 3

    minetest.register_node(":" .. itemstring_floor, {
        description = def.description,
        _doc_items_longdesc = def.longdesc,
        drawtype = "mesh",
        mesh = "mcl_lanterns_lantern_floor.obj",
        inventory_image = def.texture_inv,
        wield_image = def.texture_inv,
        tiles = {
            {
                name = def.texture,
                animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3 }
            }
        },
        use_texture_alpha = "clip",
        paramtype = "light",
        paramtype2 = "wallmounted",
        place_param2 = 1,
        node_placement_prediction = "",
        sunlight_propagates = true,
        light_source = def.light_level,
        groups = groups,
        selection_box = {
            type = "fixed",
            fixed = {
                { -0.1875, -0.5,    -0.1875, 0.1875, -0.0625, 0.1875 },
                { -0.125,  -0.0625, -0.125,  0.125,  0.0625,  0.125 },
                { -0.0625, -0.5,    -0.0625, 0.0625, 0.1875,  0.0625 },
            },
        },
        collision_box = {
            type = "fixed",
            fixed = {
                { -0.1875, -0.5,    -0.1875, 0.1875, -0.0625, 0.1875 },
                { -0.125,  -0.0625, -0.125,  0.125,  0.0625,  0.125 },
                { -0.0625, -0.5,    -0.0625, 0.0625, 0.1875,  0.0625 },
            },
        },
        sounds = sounds,
        on_place = function(itemstack, placer, pointed_thing)
            local new_stack = mcl_util.call_on_rightclick(itemstack, placer, pointed_thing)
            if new_stack then
                return new_stack
            end

            local under = pointed_thing.under
            local above = pointed_thing.above
            local node = minetest.get_node(under)
            local def = minetest.registered_nodes[node.name]

            local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
            local fakestack = itemstack

            if type(def.placement_prevented) == "function" then
                if
                    def.placement_prevented({
                        itemstack = itemstack,
                        placer = placer,
                        pointed_thing = pointed_thing,
                    })
                then
                    return itemstack
                end
            elseif check_placement(node, wdir) == false then
                return itemstack
            end

            if wdir == 0 then
                fakestack:set_name(itemstring_ceiling)
            elseif wdir == 1 then
                fakestack:set_name(itemstring_floor)
            end

            local success
            itemstack, success = minetest.item_place(fakestack, placer, pointed_thing, wdir)
            itemstack:set_name(itemstring_floor)

            if success then
                minetest.sound_play(sounds.place, { pos = under, gain = 1 }, true)
            end

            return itemstack
        end,
        on_rotate = false,
        _mcl_hardness = 3.5,
        _mcl_blast_resistance = 3.5,
    })

    minetest.register_node(":" .. itemstring_ceiling, {
        description = def.description,
        _doc_items_create_entry = false,
        drawtype = "mesh",
        mesh = "mcl_lanterns_lantern_ceiling.obj",
        tiles = {
            {
                name = def.texture,
                animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3 }
            }
        },
        use_texture_alpha = "clip",
        paramtype = "light",
        paramtype2 = "wallmounted",
        place_param2 = 0,
        node_placement_prediction = "",
        sunlight_propagates = true,
        light_source = def.light_level,
        groups = { pickaxey = 1, attached_node = 1, deco_block = 1, lantern = 1, not_in_creative_inventory = 1, dig_immediate = 3 },
        drop = itemstring_floor,
        selection_box = {
            type = "fixed",
            fixed = {
                { -0.1875, 0,      -0.1875, 0.1875, 0.4375, 0.1875 },
                { -0.125,  -0.125, -0.125,  0.125,  0,      0.125 },
                { -0.0625, -0.5,   -0.0625, 0.0625, -0.125, 0.0625 },
            },
        },
        collision_box = {
            type = "fixed",
            fixed = {
                { -0.1875, 0,      -0.1875, 0.1875, 0.4375, 0.1875 },
                { -0.125,  -0.125, -0.125,  0.125,  0,      0.125 },
                { -0.0625, -0.5,   -0.0625, 0.0625, -0.125, 0.0625 },
            },
        },
        sounds = sounds,
        on_rotate = false,
        _mcl_hardness = 3.5,
        _mcl_blast_resistance = 3.5,
    })
end

magikacia.register_lantern("ancient_lantern", {
    description = ("Ancient Lantern"),
    longdesc = ("Lanterns are light sources which can be placed on the top or the bottom of most blocks."),
    texture = magikacia.textures.ancient_lantern,
    texture_inv = magikacia.textures.ancient_lantern_inv,
    light_level = 14,
})



minetest.register_node(":magikacia:ancient_light", {
    description = ("Ancient Light"),
    paramtype2 = "facedir",
    is_ground_content = false,
    light_source = minetest.LIGHT_MAX,
    tiles = { { name = magikacia.textures.ancient_light, animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.25 } } },
    groups = { handy = 1, building_block = 1, material_glass = 1, dig_immediate = 3 },
    sounds = mcl_sounds.node_sound_glass_defaults(),
    _mcl_blast_resistance = 0.3,
    _mcl_hardness = 0.3,
})


minetest.register_node(":magikacia:magikacia_leaves_jungle", {
    description = "Magikacia Jungle Leaves",
    tiles = { { name = magikacia.textures.magikacia_leaves_jungle }, },
    groups = { dig_immediate = 3, },
    sounds = mcl_sounds.node_sound_leaves_defaults(),
    light_source = 3,
})

minetest.register_node(":arkacia:leaves_maple", {
    description = "Maple Leaves",
    tiles = { { name = magikacia.textures.leaves_maple }, },
    groups = { dig_immediate = 3, },
    sounds = mcl_sounds.node_sound_leaves_defaults(),
})


