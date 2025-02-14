local effect_name



effect_name = "earth"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
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
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "electric"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
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
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "fire"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
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
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "ice"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
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
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "telepathic"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
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
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "void"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
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
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "water"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
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
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "wind"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "disguise"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "resize"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "poison"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "healing"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "summoning"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "shield"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "absolute_aolver"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "nature"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "bubble"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "rope"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


effect_name = "portal"

magikacia.register_on_spellbook_use_primary(effect_name, function(defs)
    return defs
end)

magikacia.register_on_spellbook_use_secondary(effect_name, function(defs)
    return defs
end)


