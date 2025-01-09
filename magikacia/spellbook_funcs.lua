local modname = "magikacia"
--[[local vector = vector
local minetest = minetest
local magikacia = magikacia]]

local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local static_objs = {
    "mcl_chests:chest",
    "mcl_itemframes:item",
    "mcl_enchanting:book",
    "magikacia:effect_entity_sprite",
    "magikacia:effect_entity_3d",
}
function magikacia.is_obj_static(obj)
    if not obj then
        return true
    end
    if not obj:is_valid() then
        return true
    end
    if obj:is_player() and obj:get_pos() then
        return false
    end
    local le = obj:get_luaentity()
    if not le then
        return true
    end
    if le.is_mob then
        return false
    end
    for _, name in ipairs(static_objs) do
        if name == le.name then
            return true
        end
    end
    if obj:get_pos() then
        return false
    else
        return true
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
magikacia.register_attack("wind_primary_sneak", {
    title = "a wind cyclone spell",
})
magikacia.register_attack("wind_secondary", {
    title = "a wind ___ spell",
})

magikacia.register_attack("absolute_solver_primary", {
    title = "the Absolute Solver",
})
magikacia.register_attack("absolute_solver_secondary", {
    title = "[NULL]",
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
            if (obj_le ~= nil and not magikacia.is_obj_static(obj))
                or (obj_is_player and (include_placer or (placer == nil and true or obj:get_player_name() ~= placer:get_player_name())))
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

    minetest.sound_play({ name = "lightning_thunder", gain = 1 }, { pos = pos, max_hear_distance = 64 }, true)

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
    local pdef = {
        amount = def.amount or 1,
        pos = def.pos,
        velocity = def.velocity or { x = 0, y = 0, z = 0 },
        acceleration = def.acceleration or { x = 0, y = 0, z = 0 },
        expirationtime = def.duration_total or 2,
        size = def.size or 25,
        collisiondetection = false,
        collision_removal = false,
        object_collision = false,
        vertical = false,
        texture = {
            name = magikacia.textures[def.texture] or def.texture or "blank.png",
        },
        animation = {
            type = "vertical_frames",
            aspect_w = 32,
            aspect_h = 32,
            length = def.duration_anim or 0.25,
        },
        glow = (def.glow ~= nil and def.glow) or 14,
        attached = def.attached or nil
    }
    minetest.add_particle(pdef)
end

function magikacia.spawn_effect_anim_spawner(def)
    minetest.add_particlespawner({
        amount = def.amount or 50,
        time = def.time or 1,
        minpos = def.minpos or def.pos,
        maxpos = def.maxpos or def.pos,
        minvel = def.minvel or { x = 0, y = 5, z = 0 },
        maxvel = def.maxvel or { x = 0, y = 10, z = 0 },
        minacc = def.minacc or { x = 0, y = -13, z = 0 },
        maxacc = def.maxacc or { x = 0, y = -13, z = 0 },
        minexptime = def.minexptime or 0.1,
        maxexptime = def.maxexptime or 1,
        minsize = def.minsize or 1,
        maxsize = def.maxsize or 3,
        collisiondetection = def.collisiondetection or false,
        attached = def.attached or nil,
        vertical = def.vertical or false,
        node = def.node or nil,
        texture = magikacia.textures[def.texture] or "blank.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 32,
            aspect_h = 32,
            length = def.duration_anim or 0.25,
        },
    })
end

local mod_target = minetest.get_modpath("mcl_target")

function magikacia.spawn_linger_particles(pos, d, texture, extradefs)
    extradefs = extradefs or {}
    minetest.add_particlespawner({
        amount = extradefs.amount or (10 * d * d * d),
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
            elseif (entity.is_mob == true or entity._hittable_by_projectile or object:is_player()) then
                local pl = self._thrower and
                    (type(self._thrower) == "string" and minetest.get_player_by_name(self._thrower) or self._thrower)
                magikacia.deal_spell_damage(object, dmg or 10, self.typename or "projectile", pl)
                return true, object
            end
        end
    end
    return false, nil
end

local how_to_throw = S("Use the punch key to throw.")
function magikacia.register_projectile(proj_def)
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
            texture = proj_def.texture,
        })
    end
    local ENTITY = {
        initial_properties = { physical = false, textures = { proj_def.texture }, visual_size = { x = 2.5, y = 2.5 }, collisionbox = { 0, 0, 0, 0, 0, 0 }, pointable = false, },
        timer = 0,
        get_staticdata = mcl_throwing.get_staticdata,
        on_activate = mcl_throwing.on_activate,
        _thrower = nil,
        _lastpos = {},
    }
    ENTITY.on_step = function(self, dtime)
        self.timer = self.timer + dtime
        if self.timer > 60 * 2 then
            self.object:remove()
            return
        end
        local pos = self.object:get_pos()
        local vel = self.object:get_velocity()
        local node = minetest.get_node(pos)
        local ndef = minetest.registered_nodes[node.name]
        local thrower = minetest.get_player_by_name(tostring(self._thrower)) or self._thrower or self.object
        if self._lastpos.x ~= nil then
            if (ndef and ndef.walkable) or not ndef then
                minetest.sound_play("mcl_throwing_snowball_impact_hard",
                    { pos = pos, max_hear_distance = 16, gain = 0.7 }, true)
                snowball_particles(self._lastpos, vel)
                if mod_target and node.name == "mcl_target:target_off" then mcl_target.hit(vector.round(pos), 0.4) end
                if proj_def.do_custom_hit ~= nil then
                    proj_def.do_custom_hit(thrower, nil, pos, self, proj_def)
                end
                self.object:remove()
                return
            end
        end
        self.typename = ndef.typename
        local did_hit, obj_hit = magikacia.check_object_hit(self, pos, ndef.damage)
        if did_hit then
            if proj_def.do_custom_hit ~= nil then
                proj_def.do_custom_hit(thrower, obj_hit, pos, self, proj_def)
            end
            minetest.sound_play("mcl_throwing_snowball_impact_soft", { pos = pos, max_hear_distance = 16, gain = 0.7 }, true)
            snowball_particles(pos, vel)
            self.object:remove()
            return
        end
        self._lastpos = { x = pos.x, y = pos.y, z = pos.z }
    end
    minetest.register_entity(":magikacia:throwable_" .. proj_def.name .. "_entity", ENTITY)
    minetest.register_craftitem(":magikacia:throwable_" .. proj_def.name,
        {
            description = proj_def.name .. minetest.colorize("#FF0", "\nDamage: " .. tostring(proj_def.damage)),
            _tt_help = S("Throwable"),
            _doc_items_longdesc =
                S(proj_def.name ..
                    "s can be thrown or launched from a dispenser for fun. Hitting something with a it does damage."),
            _doc_items_usagehelp =
                how_to_throw,
            inventory_image = proj_def.texture,
            stack_max = 65535,
            groups = { weapon_ranged = 1 },
            on_use = mcl_throwing
                .get_player_throw_function("magikacia:throwable_" .. proj_def.name .. "_entity"),
            _on_dispense = mcl_throwing
                .dispense_function,
        })
    mcl_throwing.register_throwable_object("magikacia:throwable_" .. proj_def.name,
        "magikacia:throwable_" .. proj_def.name .. "_entity",
        22)
end

magikacia.register_projectile({
    name = "attack_ice_secondary",
    damage = 10,
    texture = magikacia.textures.effect_ice_secondary,
    typename = "ice_secondary",
})
magikacia.register_projectile({
    name = "attack_water_secondary",
    damage = 10,
    texture = magikacia.textures.effect_water_secondary,
    typename = "water_secondary",
    do_custom_hit = function(thrower, object, pos)
        if object then
            mcl_burning.extinguish(object)
        end
        if pos then
            for _, k in ipairs(around_plus_pos_list) do
                local p = { x = pos.x + k[1], y = pos.y, z = pos.z + k[2] }
                local n = minetest.get_node(p)
                if n and n.name and minetest.get_item_group(n.name, "fire") then
                    minetest.swap_node(p, { name = "air" })
                end
            end
        end
    end,
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
            magikacia.safe_replace(pos,
                "magikacia:fire_temp",
                thrower)
        end
    end,
})
magikacia.register_projectile({
    name = "attack_wind_secondary",
    damage = 10,
    texture = magikacia.textures.effect_ice_secondary,
    typename = "wind_secondary",
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
        if (obj_is_player or not magikacia.is_obj_static(obj)) then
            magikacia.deal_spell_damage(obj, 2, "electric_primary", user)
            return true
        end
    end
end




minetest.register_entity(":magikacia:effect_entity_sprite", {
    initial_properties = {
        visual = "sprite",
        wield_item = "",
        visual_size = { x = 1, y = 1 },
        physical = false,
        pointable = false,
        textures = { "blank.png" },
        static_save = false,
    },
    on_activate = function(self, staticdata, dtime_s)
        local data = minetest.deserialize(staticdata)
        if data then
            local defs = data._magikacia_effect_entity_3d_defs
            if defs ~= nil then
                if defs.nframes ~= nil then
                    defs.nframes = tonumber(defs.nframes)
                    defs.total_anim_time = tonumber(defs.total_anim_time)
                end
                data._magikacia_effect_entity_3d_defs = defs
            end
            for k, v in pairs(data) do
                self[k] = v
            end
        end
    end,
    on_step = function(self, dtime)
        local ent_def = self._magikacia_effect_entity_3d_defs or {}
        if ent_def.can_despawn ~= false then
            self.timer = (self.timer or 0) + dtime
            if self.timer > (ent_def.expiration_time or 5) then
                self.object:remove()
                return
            end
        end
        local attached_to_player_name = self.attached_to_player_name
        if attached_to_player_name then
            local attached_player = minetest.get_player_by_name(attached_to_player_name)
            if not attached_player then
                self.object:remove()
                return
            end


            
        end
    end,
})



minetest.register_entity(":magikacia:effect_entity_3d", {
    initial_properties = {
        visual = "mesh",
        mesh = "mcl_skins_head.obj"
        visual_size = { x = 1, y = 1, z = 0.1 },
        physical = false,
        pointable = false,
        textures = { "blank.png" },
        static_save = false,
    },
    on_activate = function(self, staticdata, dtime_s)
        local data = minetest.deserialize(staticdata)
        if data then
            local defs = data._magikacia_effect_entity_3d_defs
            if defs ~= nil then
                if defs.nframes ~= nil then
                    defs.nframes = tonumber(defs.nframes)
                    defs.total_anim_time = tonumber(defs.total_anim_time)
                end
                self._magikacia_effect_entity_3d_defs = defs
            end
        end
    end,
    on_step = function(self, dtime)
        local ent_def = self._magikacia_effect_entity_3d_defs
        self.timer = (self.timer or 0) + dtime
        if self.timer > (ent_def.expiration_time or 5) then
            self.object:remove()
            return
        end
        local obj = self.object
        --[[local props = obj:get_properties()]]
        if ent_def then
            if ent_def.nframes ~= nil then
                local nframe = math.floor(ent_def.nframes * math.fmod(self.timer, ent_def.total_anim_time) / ent_def.total_anim_time) + 1
                obj:set_properties({
                    wield_item = ent_def.base_item .. "_" .. nframe
                })
            end
        end
        --[[local rot = obj:get_rotation()
        obj:set_rotation({ x = rot.x, y = rot.y, z = math.round((self.timer * math.pi * 4) / (math.pi / 4)) * (math.pi / 4) })]]
    end,
})
local base_props = {
    visual = "wielditem",
    visual_size = { x = 0.3, y = 0.3 },
    physical = false,
    pointable = false,
    textures = { "blank.png" },
}



magikacia.tpl_entity = {
    initial_properties = base_props,
    _mcl_fishing_hookable = true,
    _mcl_fishing_reelable = false,
    _mcl_pistons_unmovable = true,
}
function magikacia.tpl_entity:set_def(def)
    self.object:set_pos(def.pos)
    self.object:set_rotation(vector.dir_to_rotation(def.dir))

    self.object:set_properties(table.merge(base_props, {
        wield_item = self._item,
        visual_size = { x = def.size, y = def.size },
    }, def.object_properties or {}))
end

function magikacia.spawn_effect_entity_sprite(def)
    local ent = minetest.add_entity(def.pos, "magikacia:effect_entity_sprite", minetest.serialize({ _magikacia_effect_entity_3d_defs = def, }))
    ent:set_properties(table.merge(base_props, {
        textures = { def.texture },
        visual_size = { x = def.size, y = def.size },
        attached_to_player_name = def.attached_to_player_name
    }, def.object_properties or {}))
    if def.attached_to_player_name then
        local player = minetest.get_player_by_name(def.attached_to_player_name)
        if player then
            ent:set_attach(player, "", { x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 }, true)
        end
    end
    --[[ent:set_rotation(def.rotation)]]
    return ent
end

function magikacia.spawn_effect_entity_3d(def)
    --[[
    def = {
        texture = "",
        size = 1,
        attached_to_player_name = "",
        object_properties = {},
        rotation = vector.new(0, 0, 0),
        attach = {
            player_name = "",
            obj = obj,
            pos = vector.new(0, 0, 0),
            rot = vector.new(0, 0, 0),
            visible = true,
        },
    }
    ]]
    if def.attach == nil then
        def.attach = {}
    end
    local ent = minetest.add_entity(def.pos, "magikacia:effect_entity_3d", minetest.serialize({ _magikacia_effect_entity_3d_defs = def, }))
        textures = { def.texture },
        visual_size = { x = def.size, y = def.size, z = 0.1 },
        attached_to_player_name = def.attach.player_name or ""
    }, def.object_properties or {}))
    ent:set_rotation(def.rotation)
    if def.attach.name then
        local player = minetest.get_player_by_name(def.attach.name)
        if player and player:get_pos() then
            ent:set_attach(player, "", def.attach.pos or vector.zero(), def.attach.rot or vector.zero(), def.attach.visible or true)--[[{ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 }, true)]]
        end
    elseif def.attach.obj then
        local obj = def.attach.obj
        if obj:is_valid() and obj:get_pos() then
            ent:set_attach(obj, "", def.attach.pos or vector.zero(), def.attach.rot or vector.zero(), def.attach.visible or true)--[[{ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 }, true)]]
        end
    end
    return ent
end

--[[
    minetest.register_craftitem(":magikacia:temp_texture", {
        description = "Temp Texture",
        inventory_image = "blank.png^[png:",
    })
]]


minetest.register_tool(":magikaica:entity_tool", {
    description = "Entity Tool",
    on_use = function(itemstack, user, pointed_thing)
        local look_dir = user:get_look_dir()
        local look_horiz = user:get_look_horizontal()
        local look_vert = user:get_look_vertical()
        local ent = magikacia.spawn_effect_entity_3d({
            pos = user:get_pos(),
            itemname = "magikacia:zzz_textures_effect_absolute_solver_primary",
            rotation = { x = look_vert, y = look_horiz, z = 0 },
            size = 1,
        })
        ent:set_velocity(look_dir:multiply(50))
    end
})
--[[
ok so left click will spawn a hand that will go in a straight line through the air and after like 0.4 seconds of it going through the air then it will turn to the second frame, after 0.4 more seconds it will go to the third frame, then after 0.4 more seconds it will go to the fourth frame and if theres a player like really nearby (check that its not the user lol) then it will grab them but if theres not then it will dissappear
when a player is grabbed by the hand they cant move bc theyr stuck XD then if the user uses left click again on a different spot it will go towards there quickly and the player will follow and then it will drop them (go to the 3rd animation frame then dissapear the hand) and this can be good for fall dmg
]]




magikacia.register_damage_modifier("rune_shield_secondary", function(obj, damage, reason)
    if obj and obj:is_player() then
        local obj_meta = obj:get_meta()
        local hp = obj:get_hp()
        if obj_meta and obj_meta:get_int("magikacia:rune_shield_active") == 1 then
            minetest.log("shield active; damage: " .. damage)
            -- if damage > 0 then
                minetest.log("shield block")
                obj_meta:set_int("magikacia:rune_shield_active", 0)
                minetest.sound_play("mcl_block", { object = obj, max_hear_distance = 16, gain = 1, pitch = 0.5 }, true)
                return 0
            -- end
        end
        local inv = obj:get_inventory()
        if inv then
            if reason.type == "out_of_world" then
                local ppos = obj:get_pos(); local _, is_in_deadly_void = mcl_worlds.is_in_void(ppos); if not is_in_deadly_void then return end
                for k, v in pairs(inv:get_list("main")) do
                    if minetest.get_item_group(v:get_name(), "spellbook") and (magikacia.has_in_spellbook_inv_main and magikacia.has_in_spellbook_inv_main(v, obj, "magikacia:rune_void")) then
                        if hp + damage <= 20 then
                            return -damage
                        else
                            return 20 - (hp + damage)
                        end
                    end
                end
            end
        end
    end
end)



local effect_shield_entities = {}
local effect_void_primary_held_entities = {}
function magikacia.get_or_create_void_primary_held_entity(attached_ent)
    if attached_ent and attached_ent:is_player() then
        local pname = attached_ent:get_player_name()
        local ent = effect_void_primary_held_entities[pname]
        if ent and ent.object then
            return ent
        else
            local newent = minetest.add_entity("magikacia:effect_entity_sprite", {
                attached_to = attached_ent,
                texture = magikacia.effect_void_primary .. "^[verticalframe:4:4",
                size = 1,
                expiration_time = 5,
            })
            effect_void_primary_held_entities[pname] = newent
        end

    end
end


magikacia.effect_portal_pairs = {}
function magikacia.effect_portal_add(id, defs, type)
    local paired_type = type == "primary" and "secondary" or "primary"
    if magikacia.effect_portal_pairs[id] == nil then
        magikacia.effect_portal_pairs[id] = {}
    end
    local vel_change = nil
    local paired_portal = magikacia.effect_portal_pairs[id][paired_type]
    local out_dir = defs.out_dir
    if paired_portal then
        local paired_portal_out_dir = paired_portal.out_dir
        vel_change = vector.new(
            out_dir.x / paired_portal_out_dir.x,
            out_dir.y / paired_portal_out_dir.y,
            out_dir.z / paired_portal_out_dir.z
        )
    end
    if vel_change == nil then
        vel_change = vector.new(1, 1, 1)
    end
    magikacia.effect_portal_pairs[id][paired_type].vel_change = vel_change
    defs.vel_change = vel_change,
    local ent = magikacia.effect_portal_pairs[id][paired_type].effect_entity
    if ent == nil or (ent and not (ent:is_valid() and ent:get_pos())) then
        if ent then
            ent:remove()
        end
        local rot = vector.new(
            out_dir.x > 0 and 90 or 270,
            out_dir.x > 0 and 90 or 270,
            out_dir.x > 0 and 90 or 270,
        )
        local new_ent = magikacia.spawn_effect_entity_3d({
            texture = magikacia.textures.effect_portal_primary,
            size = 1,
            object_properties = {},
            rotation = vector.new(0, 0, 0),
        })
        magikacia.effect_portal_pairs[id][paired_type].effect_entity = new_ent
    else
        if ent:get_pos() then
            ent:set_pos(defs.pos)
        end
    end
    magikacia.effect_portal_pairs[id][type] = defs
end
function magikacia.effect_portal_remove(id, type)
    if magikacia.effect_portal_pairs[id] then
        magikacia.effect_portal_pairs[id][type] = nil
        local pair = magikacia.effect_portal_pairs[id]
        if pair.entity then
            pair.entity:remove()
        end
        if pair.primary == nil and pair.secondary == nil then
            magikacia.effect_portal_pairs[id] = nil
        end
    end
end
local effect_portal_last_teleport_out = {}
local effect_portal_last_teleport_out_reset_timer = 0
local effect_portal_last_teleport_out_reset_interval = 3

local effect_portal_teleport_time = 0
local effect_portal_teleport_interval = 0.1
local effect_portal_anim_duration = effect_portal_teleport_time * 2


magikacia.register_globalstep("effect_portal_teleport", function(dtime)
    effect_portal_last_teleport_out_reset_timer = effect_portal_last_teleport_out_reset_timer + dtime
    
    if effect_portal_last_teleport_out_reset_timer > effect_portal_last_teleport_out_reset_interval then
        effect_portal_last_teleport_out_reset_timer = 0
        effect_portal_last_teleport_out = {}
    end

    effect_portal_teleport_time = effect_portal_teleport_time + dtime
    if effect_portal_teleport_time < effect_portal_teleport_interval then
        return
    end


    local teleported_objects_log = {}
    for k, portal_pair in pairs(magikacia.effect_portal_pairs) do
        local portal_primary = portal_pair.primary
        local portal_secondary = portal_pair.secondary

        if portal_primary and portal_secondary then
            magikacia.radius_effect_func(portal_primary.pos, 1, nil, function(obj)
                local last_teleport_out = effect_portal_last_teleport_out[obj]
                minetest.log("last_teleport_out primary: " .. tostring(last_teleport_out))
                if last_teleport_out ~= "secondary" and not teleported_objects_log[obj] then
                    teleported_objects_log[obj] = true
                    local vc = portal_secondary.vel_change
                    if vc then
                        local v = obj:get_velocity()
                        obj:set_velocity(vector.new(
                            v.x * vc.x,
                            v.y * vc.y,
                            v.z * vc.z
                        ))
                    end
                    obj:set_pos(portal_secondary.pos)
                    effect_portal_last_teleport_out[obj] = "primary"
                end
            end)
            magikacia.radius_effect_func(portal_secondary.pos, 1, nil, function(obj)
                local last_teleport_out = effect_portal_last_teleport_out[obj]
                minetest.log("last_teleport_out secondary: " .. tostring(last_teleport_out))
                if last_teleport_out ~= "primary" and not teleported_objects_log[obj] then
                    teleported_objects_log[obj] = true
                    local vc = portal_primary.vel_change
                    if vc then
                        local v = obj:get_velocity()
                        obj:set_velocity(vector.new(
                            v.x * vc.x,
                            v.y * vc.y,
                            v.z * vc.z
                        ))
                    end
                    obj:set_pos(portal_primary.pos)
                    effect_portal_last_teleport_out[obj] = "secondary"
                end
            end)
        end
        if portal_primary then
            --[[magikacia.spawn_effect_entity_3d]]
            magikacia.spawn_effect_anim({
                pos = portal_primary.pos,
                texture = magikacia.textures.effect_portal_primary .. "^[transformR90",
                duration_total = effect_portal_anim_duration,
                duration_anim = effect_portal_anim_duration,
            })
        end
        if portal_secondary then
            magikacia.spawn_effect_anim({
                pos = portal_secondary.pos,
                texture = magikacia.textures.effect_portal_secondary .. "^[transformR90",
                duration_total = effect_portal_anim_duration,
                duration_anim = effect_portal_anim_duration,
            })
        end
    end



    effect_portal_teleport_time = effect_portal_teleport_time - effect_portal_teleport_interval
end)


magikacia.register_on_leaveplayer("effect_portal_clear", function(player)
    local pname = player:get_player_name()
    if pname then
        effect_portal_last_teleport_out[player] = nil
        magikacia.effect_portal_pairs[pname] = nil
    end
end)

