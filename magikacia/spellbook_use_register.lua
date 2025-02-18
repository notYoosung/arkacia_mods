--[[
effect_name = "(.+?)"\n(\n.+_name((.*\n*)*?)end\)){2}
register_on_use_pair($1,\n$2\n)\n\n
\n\nmagikacia.register_on_spellbook_use_secondary.+_name, ((.*\n*)*?)end\)\n?\n\n
\nend,\n$1end)\n\n\n
]]

--[[
    defs (table): definitions of user and environment

    return defs
]]
local function register_on_use_pair("effect_name", primary_func, secondary_func)
    if primary_func then
        magikacia.register_on_spellbook_use_primary(effect_name, primary_func)
    end
    if secondary_func then
        magikacia.register_on_spellbook_use_secondary(effect_name, secondary_func)
    end
end





register_on_use_pair("earth",
function(defs)
    for i = 1, 5 do
        local pos = vector.add(vector.offset(defs.use_pos_self, 0, defs.placer_eye_height * 0.7, 0),
            vector.multiply(defs.placer_look_dir, i))
        if pos then
            magikacia.radius_effect_func(pos, 2, placer, function(obj)
                magikacia.deal_spell_damage(obj, 3 * defs.cores_multipliers.damage, "earth_primary", placer)
            end)
        end
        magikacia.spawn_effect_anim({
            pos = pos,
            texture = "effect_earth_primary",
            duration_total = 0.4,
            duration_anim = 0.4,
        })
    end
    defs.use_success = true
    defs.use_at_self = true
    return defs
end,
function(defs)
    return defs
end)

register_on_use_pair("electric",
    function(defs)
        if defs.use_pos_above then
            local electric_primary_success = false
            magikacia.radius_effect_func(defs.use_pos_above, 3.5, placer, function(obj)
                if magikacia.tase(placer, obj) then
                    electric_primary_success = true
                end
            end)
            if electric_primary_success then
                defs.use_success = true
                defs.use_at_place_above = true
            end
            local spd = 3 / 0.25
            magikacia.spawn_effect_anim_spawner({
                time = 0.01,
                pos = defs.use_pos_above,
                amount = 50,
                minsize = 1,
                maxsize = 5,
                minexptime = 0.0,
                maxexptime = 0.25,
                minvel = { x = -spd, y = -spd, z = -spd },
                maxvel = { x = spd, y = spd, z = spd },
                minacc = { x = 0, y = 0, z = 0 },
                maxacc = { x = 0, y = 0, z = 0 },
                texture = "effect_electric_primary",
            })
        end
        return defs
    end,
    function(defs)
        return defs
    end
)



register_on_use_pair("fire",
function(defs)
    if defs.use_pos_above then
        for _, k in ipairs(around_plus_pos_list) do
            magikacia.safe_replace({ x = defs.use_pos_above.x + k[1], y = defs.use_pos_above.y, z = defs.use_pos_above.z + k[2] },
                "magikacia:fire_temp",
                placer)
        end
        magikacia.spawn_effect_anim({
            pos = defs.use_pos_above,
            texture = "effect_fire_primary",
        })
        mcl_potions.fire_resistance_func(placer, nil, 10)
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("ice",
function(defs)
    if defs.use_pos_above then
        magikacia.radius_effect_func(defs.use_pos_above, 3, placer, function(obj)
            mcl_potions.swiftness_func(obj, -1, 3 * defs.cores_multipliers.physical_effect)
            mcl_potions.leaping_func(obj, -1, 3 * defs.cores_multipliers.physical_effect)
        end)
        magikacia.spawn_effect_anim({
            pos = defs.use_pos_above,
            texture = "effect_vortex_blue",
        })
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("telepathic",
function(defs)
    if defs.use_pos_above then
        if defs.is_placer_sneaking then
            if defs.pointed_obj then
                local pself = placer:get_pos()
                if pself then
                    defs.pointed_obj:set_pos(pself)
                end
                placer:set_pos(defs.use_pos_above)
            elseif pointed_thing.type == "node" then
                placer:set_pos({ x = defs.use_pos_above.x, y = defs.use_pos_above.y - 0.5, z = defs.use_pos_above.z })
            else
                placer:set_pos(defs.use_pos_above)
            end
        else
            if pointed_thing.type == "node" then
                placer:set_pos({ x = defs.use_pos_above.x, y = defs.use_pos_above.y - 0.5, z = defs.use_pos_above.z })
            else
                placer:set_pos(defs.use_pos_above)
            end
        end
        magikacia.spawn_effect_anim({
            pos = defs.use_pos_above,
            texture = "effect_vortex_blue",
        })
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("void",
function(defs)
    if defs.use_pos_above then
        magikacia.radius_effect_func(defs.use_pos_above, 2, placer, function(obj)
            magikacia.deal_spell_damage(obj, 20 * defs.cores_multipliers.damage, "void_primary", placer)
        end)
        magikacia.spawn_effect_anim({
            pos = defs.use_pos_above,
            texture = "effect_void_primary",
            duration_total = 0.5,
            duration_anim = 0.5,
        })
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("water",
function(defs)
    if defs.use_pos_above then
        magikacia.radius_effect_func(defs.use_pos_above, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                magikacia.deal_spell_damage(obj, 5 * defs.cores_multipliers.damage, "water_primary", placer)
            end
            mcl_burning.extinguish(obj)
        end, true)

        local nodes, node_counts = minetest.find_nodes_in_area(vector.offset(defs.use_pos_above, -3, -3, -3),
            vector.offset(defs.use_pos_above, 3, 3, 3), "group:fire", false)
        if nodes then
            minetest.bulk_set_node(nodes, { name = "air" })
        end

        magikacia.spawn_effect_anim({
            pos = defs.use_pos_above,
            texture = "effect_water_primary",
            size = 30,
            duration_total = 0.4,
            duration_anim = 0.4,
        })
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("wind",
function(defs)
    if defs.use_pos_above then
        if not defs.is_placer_sneaking then
            magikacia.radius_effect_func(defs.use_pos_above, 8, placer, function(obj)
                local newvel = vector.offset(
                    vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), defs.use_pos_above)), 10 * defs.cores_multipliers.physical_effect), 0, 15, 0)
                obj:add_velocity(newvel)
            end, true)
            magikacia.spawn_effect_anim({
                pos = defs.use_pos_above,
                texture = "effect_wind_primary",
            })
        else
            local function suck(n, victim, original_pos)
                if victim then
                    minetest.after(0.05, function(nsub, obj)
                        if obj then
                            local pobj = obj:get_pos()
                            if pobj then
                                nsub = nsub + 1
                                if nsub < #wind_primary_sneak_pos_list then
                                    obj:move_to(vector.add(original_pos, wind_primary_sneak_pos_list[nsub]))
                                    local v = obj:get_velocity()
                                    if v then
                                        obj:add_velocity({ x = v.x, y = -(v.y or 0) * 2, z = v.z })
                                    end
                                    suck(nsub, obj, original_pos)
                                    --[[magikacia.deal_spell_damage(obj, 1 * cores_multipliers.damage, "wind_primary_sneak", placer)]]
                                end
                            end
                        end
                    end, n, victim)
                end
            end
            magikacia.radius_effect_func(defs.use_pos_above, 3, placer, function(obj)
                local p = obj:get_pos()
                if p then
                    suck(0, obj, p)
                end
            end)
            for ipos, pos in ipairs(wind_primary_sneak_pos_list) do
                minetest.after(ipos * 0.05, function()
                    magikacia.spawn_effect_anim({
                        pos = vector.add(defs.use_pos_above, pos),
                        texture = "effect_wind_primary_sneak",
                        size = 40,
                    })
                end)
            end
            magikacia.spawn_effect_anim({
                pos = defs.use_pos_above,
                texture = "effect_wind_primary_sneak",
                size = 40,
            })
        end
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("disguise",
function(defs)
    if entity_modifier and defs.use_pos_above then
        entity_modifier.disguise_tool_primary(itemstack, placer, pointed_thing)
        magikacia.spawn_effect_anim({
            pos = defs.use_pos_above,
            texture = "effect_vortex_blue",
        })
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("resize",
function(defs)
    if entity_modifier and defs.use_pos_above then
        if defs.pointed_obj then
            local vs = get_visual_size(defs.pointed_obj) * 1 + 0.1 * defs.cores_multipliers.physical_effect
            if vs and (defs.is_gauntlet_admin or vs <= resize_max_size) then
                entity_modifier.resize(
                    defs.pointed_obj,
                    vs,
                    0.1,
                    defs.is_gauntlet_admin and true or resize_max_size
                )
                if defs.use_pos_above then
                    magikacia.spawn_effect_anim({
                        pos = defs.use_pos_above,
                        texture = "effect_resize_primary",
                        size = 15,
                    })
                    defs.use_at_place_above = true
                end
            end
            defs.use_success = true
        else
            local vs = get_visual_size(placer) * 1 + 0.1 * defs.cores_multipliers.physical_effect
            if vs and (defs.is_gauntlet_admin or vs <= resize_max_size) then
                entity_modifier.resize_player(
                    placer,
                    vs,
                    0.1,
                    defs.is_gauntlet_admin and true or resize_max_size
                )
                magikacia.spawn_effect_anim({
                    pos = defs.use_pos_self,
                    texture = "effect_resize_primary",
                    size = 15,
                })
            end
            defs.use_success = true
            defs.use_at_self = true
        end    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("poison",
function(defs)
    if defs.use_pos_above then
        magikacia.radius_effect_func(defs.use_pos_above, 3, placer, function(obj, obj_is_player)
            if obj_is_player then
                mcl_potions.poison_func(obj, 1 * defs.cores_multipliers.damage, 3 * defs.cores_multipliers.physical_effect)
            end
        end)
        magikacia.spawn_linger_particles(defs.use_pos_above, 3, magikacia.textures.effect_poison_particles)
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("healing",
function(defs)
    if defs.use_pos_above then
        magikacia.radius_effect_func(defs.use_pos_above, 3, placer, function(obj)
            mcl_potions.regeneration_func(obj, 1, 3 * defs.cores_multipliers.physical_effect)
            mcl_potions.healing_func(obj, 6 * defs.cores_multipliers.physical_effect)
        end, true)
        magikacia.spawn_effect_anim({
            pos = defs.use_pos_above,
            texture = "effect_vortex_blue",
        })
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("summoning",
function(defs)
    local safe_use_pos = defs.use_pos_above or defs.use_pos_self
    if safe_use_pos then
        local ent = minetest.add_entity(safe_use_pos, ":magikacia:adminite", minetest.serialize({
            owner = defs.placer_name,
            specific_attack = specific_attack_all,
        }))
        magikacia.spawn_effect_anim({
            pos = safe_use_pos,
            texture = "effect_vortex_blue",
        })
        defs.use_success = true
        defs.use_at_place_above = true
    end
return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("shield",
function(defs)
    if defs.use_pos_above then
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("absolute_aolver",
function(defs)
    local pdata = magikacia.players[defs.placer_name]
    pdata.effect_absolute_solver_primary_captured_list = pdata.effect_absolute_solver_primary_captured_list or {}
    if defs.is_placer_sneaking or #pdata.effect_absolute_solver_primary_captured_list > 0 then
        pdata.effect_absolute_solver_primary_captured_list = {}
    elseif defs.pointed_obj and defs.use_pos_above then
        if not magikacia.is_obj_static(defs.pointed_obj) then
            if pdata then
                table.insert(magikacia.players[defs.placer_name].effect_absolute_solver_primary_captured_list, {
                    obj = defs.pointed_obj,
                    dist = vector.distance(vector.offset(defs.use_pos_self, 0, defs.placer_eye_height, 0), defs.use_pos_above),
                })
            end
        end
    end
    defs.use_success = true
    defs.use_at_place_above = true
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("nature",
function(defs)
    if defs.use_pos_above then
        for i = 5, 5 * defs.cores_multipliers.physical_effect, 5 do
            for ii = 0, math.pi * 2 - 0.01, math.pi / 3 do
                local above_posi = {
                    x = math.floor(defs.use_pos_above.x + math.cos(ii) * i + 0.5),
                    y = defs.use_pos_above.y,
                    z = math.floor(defs.use_pos_above.z + math.sin(ii) * i + 0.5),
                }
                local under_posi = { x = above_posi.x, y = above_posi.y - 1, z = above_posi.z }
                magikacia.bone_meal(itemstack, placer, { type = "node", under = under_posi, above = above_posi })
            end
        end
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("bubble",
function(defs)
    local add_vel = vector.multiply(placer:get_look_dir(), 20 * defs.cores_multipliers.physical_effect)
    local _bubble_itemstack
    local bubble_use_pos
    if magikacia_bubbles then
        _bubble_itemstack, bubble_use_pos = magikacia_bubbles.bubble_blower_primary(itemstack, placer, pointed_thing)
    end
    if bubble_use_pos then
        magikacia.radius_effect_func(bubble_use_pos, 3, placer, function(obj, obj_is_player)
            if obj_is_player then
                mcl_potions.poison_func(obj, 1 * defs.cores_multipliers.damage, 2 * defs.cores_multipliers.physical_effect)
            end
            obj:add_velocity(add_vel)
        end)
        defs.use_success = true
        defs.use_at_place_above = true
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("rope",
function(defs)
    mcl_throwing.get_player_throw_function("magikacia:throwable_attack_rope_primary_entity")(ItemStack("magikacia:throwable_attack_rope_primary", 64), placer, pointed_thing)
    defs.use_success = true
    defs.use_at_place_above = true
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("portal",
function(defs)
    if defs.use_pos_under and defs.use_pos_above then
        local out_dir = vector.subtract(defs.use_pos_above, defs.use_pos_under)
        local portal_def = {
            pos = defs.use_pos_above,
            out_dir = out_dir,
        }
        magikacia.effect_portal_add(defs.placer_name, portal_def, "primary")
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("shadow",
function(defs)
    local pdata = magikacia.players[defs.placer_name]
    if not pdata.effect_shadow_primary_captured_list or #pdata.effect_shadow_primary_captured_list == 0 then
        local look_dir = placer:get_look_dir()
        local look_horiz = placer:get_look_horizontal()
        local look_vert = -placer:get_look_vertical()
        local ent_spd = 10
        local spawn_pos = vector.offset(placer:get_pos(), 0, defs.placer_eye_height, 0)
        local frame_duration = 0.2
        local ent = magikacia.spawn_effect_entity_3d({
            pos = spawn_pos,
            itemname = "magikacia:zzz_textures_effect_shadow_primary",
            rotation = { x = look_vert, y = look_horiz, z = 0 },
            size = 1,
            nframes = 4,
            total_anim_time = frame_duration * 4,
            expiration_time = frame_duration * 4,
            base_item = "magikacia:zzz_textures_effect_shadow_primary",
        })
        local ent_vel = look_dir:multiply(ent_spd)
        ent:set_velocity(ent_vel)
        --[[minetest.log("look_horiz:" .. look_horiz)
        minetest.log("look_vert: " .. look_vert)--]]
        local end_pos = vector.add(spawn_pos, vector.multiply(ent_vel, frame_duration * 4))
        minetest.after(frame_duration * 4, function(dtime)
            magikacia.radius_effect_func(end_pos, 1.5, placer, function(obj, obj_is_player)
                if pdata then
                    pdata.effect_shadow_primary_captured_list = pdata.effect_shadow_primary_captured_list or {}
                    table.insert(magikacia.players[defs.placer_name].effect_shadow_primary_captured_list, {
                        obj = obj,
                    })
                    magikacia.players[defs.placer_name].effect_shadow_primary_capture_pos = end_pos
                end
            end)
        end)
        defs.use_success = true
        defs.use_at_self = true
    else
        if defs.use_pos_above then
            magikacia.players[defs.placer_name].effect_shadow_primary_capture_pos = vector.offset(defs.use_pos_above, 0, pointed_thing.type == "node" and -0.5 or 0, 0)
            local effect_shadow_primary_captured_list = pdata.effect_shadow_primary_captured_list
            if effect_shadow_primary_captured_list then
                for _, captured_def in pairs(effect_shadow_primary_captured_list) do
                    local obj = captured_def.obj
                    if obj and obj:is_valid() and obj:get_pos() then
                        obj:move_to(vector.offset(defs.use_pos_above, 0, -0.5, 0))
                    end
                end
            end
            pdata.effect_shadow_primary_captured_list = {}
        end
    end
    return defs
end,
function(defs)
    return defs
end)


register_on_use_pair("protection",
function(defs)
    local safe_use_pos = defs.use_pos_under or defs.use_pos_self
    if safe_use_pos then
        minetest.registered_chatcommands["area_pos1"].func(placer:get_player_name(), safe_use_pos.x .. " " .. safe_use_pos.y .. " " .. safe_use_pos.z)
        defs.use_success = true
        defs.use_at_place_under = true
    end
    return defs
end,
function(defs)
    return defs
end)


