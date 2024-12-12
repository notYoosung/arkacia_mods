local modname = "magikacia"
local vector = vector
local minetest = minetest
local magikacia = magikacia

local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local static_objs = {
    "mcl_chests:chest",
    "mcl_itemframes:item",
    "mcl_enchanting:book",
}
function magikacia.is_obj_not_static(obj)
    if not obj then
        return nil
    end
    if obj:is_player() then
        return true
    end
    local le = obj:get_luaentity()
    if not le then
        return nil
    end
    if not le then
        return false
    end
    if le.is_mob then
        return true
    end
    for _, name in ipairs(static_objs) do
        if name == le.name then
            return false
        end
    end
end

function magikacia.safe_replace(pos, node_name, placer)
    if not pos then return end
    local node = minetest.get_node(pos)
    if node and (node.name == "air" or minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].buildable_to == true) and not minetest.is_protected(pos, placer:get_player_name()) then
        minetest.swap_node(pos, { name = node_name })
    end
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
    title = "an electric taser spell",
})
magikacia.register_attack("electric_secondary", {
    title = "an electric bolt spell",
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
    title = "a water burst spell",
})
magikacia.register_attack("water_secondary", {
    title = "a water riptide spell",
})

magikacia.register_attack("wind_primary", {
    title = "a wind burst spell",
})
magikacia.register_attack("wind_secondary", {
    title = "a wind ___ spell",
})

function magikacia.deal_spell_damage(obj, damage, typename, source)
    mcl_util.deal_damage(obj, damage, { type = "magikacia_spell_" .. typename, source = source, direct = source })
end

local runes = {
    "earth",
    "electric",
    "fire",
    "ice",
    "telepathic",
    "void",
    "water",
    "wind",
}



function magikacia.radius_effect_func(pos, radius, placer, func, include_placer)
    for obj, _ in minetest.objects_inside_radius(pos, radius) do
        if obj then
            local obj_is_player = obj:is_player()
            local obj_le = obj:get_luaentity()
            if (obj_le ~= nil and magikacia.is_obj_not_static(obj))
                or (obj_is_player and (include_placer or obj:get_player_name() ~= placer:get_player_name()))
            then
                if func then
                    func(obj, obj_is_player, obj_le)
                end
            end
        end
    end
end

local rng = PcgRandom(32321123312123)

function magikacia.lightning_strike(pos, user)
    if not pos then
        return false
    end
    local do_strike = true
    if mcl_lightning.on_strike_functions then
        for _, func in pairs(mcl_lightning.on_strike_functions) do
            local objects = minetest.get_objects_inside_radius(pos, 3.5)
            local p, stop = pcall(function() return func(pos, pos, objects) end)
        end
    end

    local particle_pos = vector.offset(pos, 0, (mcl_lightning.size / 2) + 0.5, 0)
    local time = 0.2
    local particle_size = mcl_lightning.size * 10
    minetest.add_particlespawner({
        amount = 1,
        time = time,
        minpos = particle_pos,
        maxpos = particle_pos,
        minexptime = time,
        maxexptime = time,
        minsize = particle_size,
        maxsize = particle_size,
        collisiondetection = true,
        vertical = true,
        texture = "lightning_lightning_" .. rng:next(1, 3) .. ".png",
        glow = minetest.LIGHT_MAX,
    })

    minetest.sound_play({ name = "lightning_thunder", gain = 10 }, { pos = pos, max_hear_distance = 500 }, true)

    local objects = minetest.get_objects_inside_radius(pos, 3.5)
    for _, obj in pairs(objects) do
        if obj:is_player() and obj:get_player_name() ~= user:get_player_name() or obj:get_luaentity() then
            local lua = obj:get_luaentity()
            if lua then
                if not lua._on_lightning_strike or (lua._on_lightning_strike and lua._on_lightning_strike(lua, pos, pos, objects) ~= true) then
                    magikacia.deal_spell_damage(obj, 5, "electric_primary", user)
                end
            else
                magikacia.deal_spell_damage(obj, 5, "electric_primary", user)
            end
        end
    end

    for _, npos in pairs(minetest.find_nodes_in_area(vector.offset(pos, -5, -5, -5), vector.offset(pos, 5, 5, 5), { "group:affected_by_lightning" })) do
        local node = minetest.get_node(npos)
        if node then
            local def = minetest.registered_nodes[node.name]
            if def and def._on_lightning_strike then
                pcall(function()
                    def._on_lightning_strike(npos, pos, pos)
                end)
            end
        end
    end


    pos.y = pos.y + 1 / 2
    local node = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })
    if node and minetest.get_item_group(node.name, "liquid") < 1 then
        local posnode = minetest.get_node(pos)
        if posnode and posnode.name == "air" then
            if rng:next(1, 100) <= 3 then
                local sh = minetest.add_entity(pos, "mobs_mc:skeleton_horse")
                if sh then
                    local le = sh:get_luaentity()
                    if le then
                        le.owner = (user and user:is_player() and user:get_player_name()) or nil
                        le.tamed = true
                    end
                end

                local angle, posadd
                angle = math.random(0, math.pi * 2)
                for _ = 1, 3 do
                    posadd = { x = math.cos(angle), y = 0, z = math.sin(angle) }
                    posadd = vector.normalize(posadd)
                    local mob = minetest.add_entity(vector.add(pos, posadd), "mobs_mc:skeleton")
                    if mob then
                        mob:set_yaw(angle - math.pi / 2)
                        local le = mob:get_luaentity()
                        if le then
                            le.owner = (user and user:is_player() and user:get_player_name()) or ""
                        end
                    end
                    angle = angle + (math.pi * 2) / 3
                end
            end
        end
    end
end

local around_plus_pos_list = {
    { 0,  0 },
    { 1,  0 },
    { 0,  1 },
    { -1, 0 },
    { 0,  -1 },
}
function magikacia.spawn_effect_anim(def)
    if not def.pos then return end
    minetest.add_particle({
        pos = def.pos,
        velocity = { x = 0, y = 0, z = 0 },
        acceleration = { x = 0, y = 0, z = 0 },
        expirationtime = def.duration_total or 2,
        size = def.size or 25,
        collisiondetection = false,
        collision_removal = false,
        object_collision = false,
        vertical = false,
        texture = {
            name = magikacia.textures[def.texture] or "blank.png",
        },
        animation = {
            type = "vertical_frames",
            aspect_w = 32,
            aspect_h = 32,
            length = def.duration_anim or 0.25,
        },
        glow = (def.glow ~= nil and def.glow) or 14,
        attached = def.attached or nil
    })
end

local mod_target = minetest.get_modpath("mcl_target")

function magikacia.spawn_linger_particles(pos, d, texture, extradefs)
    extradefs = extradefs or {}
    minetest.add_particlespawner({
        amount = extradefs.amount or (10 * d * d),
        time = extradefs.time or 3,
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

function magikacia.check_object_hit(self, pos, dmg)
    for object in minetest.objects_inside_radius(pos, 2) do
        local entity = object:get_luaentity()
        if entity and entity.name ~= self.object:get_luaentity().name then
            if object:is_player() and self._thrower == object:get_player_name() then
                self.object:remove()
                return true, nil
            elseif (entity.is_mob == true or entity._hittable_by_projectile or object:is_player() and self._thrower ~= object:get_player_name()) then
                local pl = self._thrower and
                    (type(self._thrower) == "string" and minetest.get_player_by_name(self._thrower) or self._thrower)
                magikacia.deal_spell_damage(object, dmg, "projectile", pl)
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
        local did_hit, obj_hit = magikacia.check_object_hit(self, pos, def.damage)
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
                magikacia.safe_replace({ x = pos.x + k[1], y = pos.y, z = pos.z + k[2] },
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

local function round(num, idp)
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end
function magikacia.random_teleport_obj(obj)
    local pos = obj:get_pos()
    for _ = 1, 16 do
        local x, y, z
        x = math.random(round(pos.x) - 16, round(pos.x) + 16)
        y = math.random(math.ceil(pos.y) - 16, math.ceil(pos.y) + 16)
        z = math.random(round(pos.z) - 16, round(pos.z) + 16)
        local node_cache = {}
        local ground_level = false
        for t = 0, 16 do
            local tpos = { x = x, y = y - t, z = z }
            local tnode = minetest.get_node(tpos)
            if tnode then
                if tnode.name == "mcl_core:void" or tnode.name == "ignore" then
                    break
                end
                local tdef = minetest.registered_nodes[tnode.name]
                if tdef then
                    table.insert(node_cache, { pos = tpos, node = tnode })
                    if tdef.walkable then
                        ground_level = true
                        break
                    end
                end
            end
        end
        if ground_level and #node_cache >= 1 then
            local streak = 0
            local last_was_walkable = true
            for c = #node_cache, 1, -1 do
                local tpos = node_cache[c].pos
                local tnode = node_cache[c].node
                if not tnode then
                    goto continue
                end
                local tdef = minetest.registered_nodes[tnode.name]
                if not tdef then
                    goto continue
                end
                if not tdef.walkable and tdef.damage_per_second <= 0 then
                    if (streak == 0 and last_was_walkable) or (streak > 0) then
                        streak = streak + 1
                    end
                else
                    streak = 0
                end
                last_was_walkable = tdef.walkable
                if streak >= 2 then
                    local goal = { x = tpos.x, y = tpos.y - 1.5, z = tpos.z }
                    obj:set_pos(goal)
                    return true
                end
            end
            ::continue::
        end
    end
    return false
end

magikacia.tase = function(user, obj)
    if obj then
        local obj_is_player = obj:is_player()
        if obj_is_player then
            obj:set_look_horizontal(obj:get_look_horizontal() + math.random(-math.pi / 16, math.pi / 16))
            obj:set_look_vertical(obj:get_look_vertical() + math.random(-math.pi / 16, math.pi / 16))
        end
        if (obj_is_player or obj:get_luaentity()) and mcl_util.get_hp(obj) > 1 then
            magikacia.deal_spell_damage(obj, 1, "electric_primary", user)
            return true
        end
    end
end
