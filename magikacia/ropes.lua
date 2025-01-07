local function rad_to_param2(rad)
    local tau = math.pi * 2
    if rad < tau * 7 / 8 and rad >= tau * 5 / 8 then
        return 2
    elseif rad < tau * 5 / 8 and rad >= tau * 3 / 8 then
        return 5
    elseif rad < tau * 3 / 8 and rad >= tau * 1 / 8 then
        return 3
    else
        return 4
    end
end

local function rotate_climbable(pos, node, _, mode)
    if mode == screwdriver.ROTATE_FACE then
        local r = screwdriver.rotate.wallmounted(pos, node, mode)
        node.param2 = r
        minetest.swap_node(pos, node)
        return true
    end
    return false
end

minetest.register_node(":magikacia:ladder", {
    description = ("Ladder"),
    _doc_items_longdesc = ("A piece of ladder which allows you to climb vertically. Ladders can only be placed on the side of solid blocks and not on glass, leaves, ice, slabs, glowstone, nor sea lanterns."),
    drawtype = "signlike",
    is_ground_content = false,
    tiles = { "default_ladder.png" },
    inventory_image = "default_ladder.png",
    wield_image = "default_ladder.png",
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "wallmounted",
    climbable = true,
    node_box = {
        type = "wallmounted",
        wall_side = { -0.5, -0.5, -0.5, -7 / 16, 0.5, 0.5 },
    },
    selection_box = {
        type = "wallmounted",
        wall_side = { -0.5, -0.5, -0.5, -7 / 16, 0.5, 0.5 },
    },
    groups = { handy = 1, axey = 1, attached_node = 1, deco_block = 1, dig_by_piston = 1, unsticky = 1 },
    sounds = mcl_sounds.node_sound_wood_defaults(),
    node_placement_prediction = "",
    -- Restrict placement of ladders
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then
            -- no interaction possible with entities
            return itemstack
        end

        local under = pointed_thing.under
        local node = minetest.get_node(under)
        local def = minetest.registered_nodes[node.name]
        if not def then
            return itemstack
        end
        local groups = def.groups

        -- Don't allow to place the ladder at particular nodes
        if (groups and (groups.glass or groups.leaves or groups.slab)) or
            node.name == "mcl_core:ladder" or node.name == "mcl_core:ice" or node.name == "mcl_nether:glowstone" or node.name == "mcl_ocean:sea_lantern" then
            return itemstack
        end

        local rc = mcl_util.call_on_rightclick(itemstack, placer, pointed_thing)
        if rc then return rc end
        local above = pointed_thing.above

        -- Ladders may not be placed on ceiling or floor
        if under.y ~= above.y then
            return itemstack
        end
        local idef = itemstack:get_definition()
        local success = minetest.item_place_node(itemstack, placer, pointed_thing)

        if success then
            if idef.sounds and idef.sounds.place then
                minetest.sound_play(idef.sounds.place, { pos = above, gain = 1 }, true)
            end
        end
        return itemstack
    end,

    _mcl_blast_resistance = 0.4,
    _mcl_hardness = 0.4,
    _mcl_burntime = 15,
    on_rotate = rotate_climbable,
})




local function extend_ladder(pos, n, param2)
    if n > 0 then
        local newpos = vector.offset(pos, 0, -1, 0)
        local node = minetest.get_node(pos)
        local can_continue = true
        if node and node.name then
            if node.name ~= "air" then
                local ndef = minetest.registered_nodes[node.name]
                if not (ndef.buildable_to or minetest.is_protected(pos, placer:get_player_name())) then
                    can_continue = false
                end
            end
        end
        if can_continue then
            minetest.place_node({ name = "magikacia:ladder"})
        end
        extend_ladder(newpos, n-1, param2)
    end
end


magikacia.register_projectile({
    name = "ladder",
    damage = 0,
    texture = magikacia.textures.effect_water_secondary,
    typename = "ladder_primary",
    do_custom_hit = function(thrower, object, pos, self, proj_def)
        local param2 = 1
        if self.object then
            local vel = self.object:get_velocity()
            if vel then
                local ang = math.atan2(vel.z, vel.x)
                param2 = rad_to_param2(ang)
            end
        end
        if object and object:is_valid() and not pos then
            pos = object:get_pos()
        end
        if pos then

        end
        
    end,
})