local S = minetest.get_translator(minetest.get_current_modname())
local mod_target = minetest.get_modpath("mcl_target")
local function check_object_hit(self, pos, dmg)
    for object in minetest.objects_inside_radius(pos, 1.5) do
        local entity = object:get_luaentity()
        if entity and entity.name ~= self.object:get_luaentity().name then
            if object:is_player() and self._thrower ~= object:get_player_name() then
                self.object:remove()
                return true
            elseif (entity.is_mob == true or entity._hittable_by_projectile) and (self._thrower ~= object) then
                local pl = self._thrower and self._thrower.is_player and self._thrower or
                    type(self._thrower) == "string" and minetest.get_player_by_name(self._thrower)
                if pl then
                    object:punch(pl, 1.0,
                        { full_punch_interval = 1.0, damage_groups = dmg, }, nil)
                    return true
                end
            end
        end
    end
    return false
end
local how_to_throw = S("Use the punch key to throw.")
local function register_projectile(name, damage, texture)
    local function snowball_particles(pos, vel)
        local vel = vector.normalize(vector.multiply(vel, -1))
        minetest.add_particlespawner({
            amount = 20,
            time = 0.001,
            minpos = pos,
            maxpos = pos,
            minvel = vector.add(
                { x = -2, y = 3, z = -2 }, vel),
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
            texture =
                texture,
        })
    end
    local ENTITY = {
        initial_properties = { physical = false, textures = { texture }, visual_size = { x = 0.5, y = 0.5 }, collisionbox = { 0, 0, 0, 0, 0, 0 }, pointable = false, },
        timer = 0,
        get_staticdata =
            mcl_throwing.get_staticdata,
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
                return
            end
        end
        if check_object_hit(self, pos, { fleshy = damage }) then
            minetest.sound_play("mcl_throwing_snowball_impact_soft", { pos = pos, max_hear_distance = 16, gain = 0.7 },
                true)
            snowball_particles(pos, vel)
            self.object:remove()
            return
        end
        self._lastpos = { x = pos.x, y = pos.y, z = pos.z }
    end
    minetest.register_entity(":magikacia:throwable_" .. name .. "_entity", ENTITY)
    minetest.register_craftitem(":magikacia:throwable_" .. name,
        {
            description = name .. minetest.colorize("#FF0", "\nDamage: " .. tostring(damage)),
            _tt_help = S("Throwable"),
            _doc_items_longdesc =
                S(name ..
                    "s can be thrown or launched from a dispenser for fun. Hitting something with a it does damage."),
            _doc_items_usagehelp =
                how_to_throw,
            inventory_image = texture,
            stack_max = 65535,
            groups = { weapon_ranged = 1 },
            on_use = mcl_throwing
                .get_player_throw_function("magikacia:throwable_" .. name .. "_entity"),
            _on_dispense = mcl_throwing
                .dispense_function,
        })
    mcl_throwing.register_throwable_object("magikacia:throwable_" .. name, "magikacia:throwable_" .. name .. "_entity", 22)
end
register_projectile("snowball", 1, "mcl_throwing_snowball.png")
register_projectile("brick", 2, "default_clay_brick.png")
register_projectile("fireball", 3, "mcl_fire_fire_charge.png")
