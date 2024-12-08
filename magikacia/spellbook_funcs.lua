function magikacia.spawn_linger_particles(pos, d, texture, extradefs)
    extradefs = extradefs or {}
    minetest.add_particlespawner({
        amount = extradefs.amount or (10 * d),
        time = extradefs.time or 0.5,
        minpos = { x = pos.x - d, y = pos.y - 0.5, z = pos.z - d },
        maxpos = { x = pos.x + d, y = pos.y + 0.5, z = pos.z + d },
        minvel = { x = -0.5, y = 0, z = -0.5 },
        maxvel = { x = 0.5, y = 0.5, z = 0.5 },
        minacc = { x = -0.2, y = 0, z = -0.2 },
        maxacc = { x = 0.2, y = .05, z = 0.2 },
        minexptime = 0.5,
        maxexptime = 1,
        minsize = 2,
        maxsize = 4,
        collisiondetection = false,
        vertical = false,
        texture = texture,
    })
end

function magikacia.register_attack(name, def)
    local typename = "magikacia_spell_" .. name
    mcl_death_messages.messages[typename] = {
        plain = "@1 was killed by " .. def.title,
        assist = "@1 was killed by " .. def.title .. " whilst trying to escape @2",
        killer = "@1 was killed by @2 using " .. def.title,
        item = "@1 was killed by @2 using " .. def.title .. " with " .. minetest.colorize(mcl_colors.AQUA, "@3"),
    }
    mcl_damage.types[typename] = { bypasses_armor = false, bypasses_magic = false, bypasses_invulnerability = false, bypasses_totem = false }
end

magikacia.register_attack("earth_primary", {
    title = "an earth drill spell",
})
magikacia.register_attack("earth_secondary", {
    title = "an earth smash spell",
})

magikacia.register_attack("electric_primary", {
    title = "an electric bolt spell",
})
magikacia.register_attack("electric_secondary", {
    title = "an electric ___ spell",
})

magikacia.register_attack("fire_primary", {
    title = "a fire summoning spell",
})
magikacia.register_attack("_secondary", {
    title = "a fireball spell",
})

magikacia.register_attack("ice_primary", {
    title = "an ice ___ spell",
})
magikacia.register_attack("ice_secondary", {
    title = "an ice ball spell",
})

magikacia.register_attack("telepathic_primary", {
    title = "an telepathic ___ spell",
})
magikacia.register_attack("telepathic_secondary", {
    title = "an telepathic ___ spell",
})

magikacia.register_attack("void_primary", {
    title = "a void blast spell",
})
magikacia.register_attack("void_secondary", {
    title = "a void vortex spell",
})

magikacia.register_attack("water_primary", {
    title = "an water burst spell",
})
magikacia.register_attack("water_secondary", {
    title = "an water riptide spell",
})

magikacia.register_attack("wind_primary", {
    title = "an wind burst spell",
})
magikacia.register_attack("wind_secondary", {
    title = "an wind ___ spell",
})






local function check_object_hit(self, pos, dmg)
    for object in minetest.objects_inside_radius(pos, 2) do
        local entity = object:get_luaentity()
        if entity and entity.name ~= self.object:get_luaentity().name then
            if object:is_player() and self._thrower == object:get_player_name() then
                self.object:remove()
                return true, nil
            elseif (entity.is_mob == true or entity._hittable_by_projectile or object:is_player() and self._thrower ~= object:get_player_name()) then
                local pl = self._thrower and
                    (type(self._thrower) == "string" and minetest.get_player_by_name(self._thrower) or self._thrower)
                deal_spell_damage(object, dmg, "projectile", pl)
                return true, object
            end
        end
    end
    return false, nil
end
local how_to_throw = S("Use the punch key to throw.")
function magikacia.register_projectile(def)
    local function snowball_particles(pos, vel)
        local vel = vector.normalize(vector.multiply(vel, -1))
        minetest.add_particlespawner({
            amount = 20,
            time = 0.001,
            minpos = pos,
            maxpos = pos,
            minvel = vector.add({ x = -2, y = 3, z = -2 }, vel),
            maxvel = vector.add({ x = 2, y = 5, z = 2 }, vel),
            minacc = { x = 0, y = -9.81, z = 0 },
            maxacc = { x = 0, y = -9.81, z = 0 },
            minexptime = 1,
            maxexptime = 3,
            minsize = 0.7,
            maxsize = 0.7,
            collisiondetection = true,
            collision_removal = true,
            object_collision = false,
            texture = def.texture,
        })
    end
    local ENTITY = {
        initial_properties = { physical = false, textures = { def.texture }, visual_size = { x = 2.5, y = 2.5 }, collisionbox = { 0, 0, 0, 0, 0, 0 }, pointable = false, },
        timer = 0,
        get_staticdata = mcl_throwing.get_staticdata,
        on_activate = mcl_throwing.on_activate,
        _thrower = nil,
        _lastpos = {},
    }
    ENTITY.on_step = function(self, dtime)
        self.timer = self.timer + dtime
        local pos = self.object:get_pos()
        local vel = self.object:get_velocity()
        local node = minetest.get_node(pos)
        local def = minetest.registered_nodes[node.name]
        if self._lastpos.x ~= nil then
            if (def and def.walkable) or not def then
                minetest.sound_play("mcl_throwing_snowball_impact_hard",
                    { pos = pos, max_hear_distance = 16, gain = 0.7 }, true)
                snowball_particles(self._lastpos, vel)
                self.object:remove()
                if mod_target and node.name == "mcl_target:target_off" then mcl_target.hit(vector.round(pos), 0.4) end
                if def.do_custom_hit ~= nil then
                    def.do_custom_hit(
                        minetest.get_player_by_name(tostring(self._thrower)) or self._thrower or self.object,
                        nil, pos)
                end
                return
            end
        end
        local did_hit, obj_hit = check_object_hit(self, pos, def.damage)
        if did_hit then
            if def.do_custom_hit ~= nil then
                def.do_custom_hit(minetest.get_player_by_name(tostring(self._thrower)) or self._thrower or self.object,
                    obj_hit)
            end
            minetest.sound_play("mcl_throwing_snowball_impact_soft", { pos = pos, max_hear_distance = 16, gain = 0.7 },
                true)
            snowball_particles(pos, vel)
            self.object:remove()
            return
        end
        self._lastpos = { x = pos.x, y = pos.y, z = pos.z }
    end
    minetest.register_entity(":magikacia:throwable_" .. def.name .. "_entity", ENTITY)
    minetest.register_craftitem(":magikacia:throwable_" .. def.name,
        {
            description = def.name .. minetest.colorize("#FF0", "\nDamage: " .. tostring(def.damage)),
            _tt_help = S("Throwable"),
            _doc_items_longdesc =
                S(def.name ..
                    "s can be thrown or launched from a dispenser for fun. Hitting something with a it does damage."),
            _doc_items_usagehelp =
                how_to_throw,
            inventory_image = def.texture,
            stack_max = 65535,
            groups = { weapon_ranged = 1 },
            on_use = mcl_throwing
                .get_player_throw_function("magikacia:throwable_" .. def.name .. "_entity"),
            _on_dispense = mcl_throwing
                .dispense_function,
        })
    mcl_throwing.register_throwable_object("magikacia:throwable_" .. def.name,
        "magikacia:throwable_" .. def.name .. "_entity",
        22)
end

magikacia.register_projectile({
    name = "attack_ice_secondary",
    damage = 10,
    texture = magikacia.textures.effect_ice_secondary,
})
magikacia.register_projectile({
    name = "attack_fire_secondary",
    damage = 10,
    texture = "mcl_fire_fire_charge.png",
    do_custom_hit = function(thrower, object, pos)
        if object then
            mcl_burning.set_on_fire(object, 5)
            if not pos then
                pos = object:get_pos()
            end
        end
        if pos then
            for _, k in ipairs(around_plus_pos_list) do
                safe_replace({ x = pos.x + k[1], y = pos.y, z = pos.z + k[2] },
                    "magikacia:fire_temp",
                    thrower)
            end
        end
    end
})




function mcl_bone_meal.add_bone_meal_particle(pos, def)
    if not def then
        def = {}
    end
    minetest.add_particlespawner({
        amount = def.amount or 10,
        time = def.time or 0.1,
        minpos = def.minpos or vector.subtract(pos, 0.5),
        maxpos = def.maxpos or vector.add(pos, 0.5),
        minvel = def.minvel or vector.new(-0.01, 0.01, -0.01),
        maxvel = def.maxvel or vector.new(0.01, 0.01, 0.01),
        minacc = def.minacc or vector.new(0, 0, 0),
        maxacc = def.maxacc or vector.new(0, 0, 0),
        minexptime = def.minexptime or 1,
        maxexptime = def.maxexptime or 4,
        minsize = def.minsize or 0.7,
        maxsize = def.maxsize or 2.4,
        texture = "mcl_particles_bonemeal.png^[colorize:#00EE00:125",
        glow = def.glow or 1,
    })
end

function magikacia.bone_meal(itemstack, user, pointed_thing)
    local pname = user and user:get_player_name()
    local unode = minetest.get_node(pointed_thing.under)
    local anode = minetest.get_node(pointed_thing.above)
    local udef = minetest.registered_nodes[unode.name]
    local adef = minetest.registered_nodes[anode.name]
    if udef and udef._on_bone_meal then
        if pname and minetest.is_protected(pointed_thing.under, pname) then
            minetest.record_protection_violation(pointed_thing.under, pname)
            return
        end
        if udef._on_bone_meal(itemstack, user, pointed_thing, pointed_thing.under, unode) ~= false then
            mcl_bone_meal.add_bone_meal_particle(pointed_thing.under)
            mcl_bone_meal.add_bone_meal_particle(pointed_thing.above)
        end
    elseif adef and adef._on_bone_meal then
        if minetest.is_protected(pointed_thing.above, pname) then
            minetest.record_protection_violation(pointed_thing.above, pname)
            return
        end
        if adef._on_bone_meal(itemstack, user, pointed_thing, pointed_thing.above, anode) ~= false then
            mcl_bone_meal.add_bone_meal_particle(pointed_thing.above)
        end
    end
    return
end
