local S = minetest.get_translator(minetest.get_current_modname())
local function valid_object_iterator(objects)
	local i = 0
	local function next_valid_object()
		i = i + 1
		local obj = objects[i]
		if obj == nil then return end
		if obj:get_pos() then return obj end
		return next_valid_object()
	end
	return next_valid_object
end

function mcl_util.connected_players(center, radius)
	local pls = minetest.get_connected_players()
	if not center then return valid_object_iterator(pls) end
	local rpls = {}
	for _, pl in pairs(pls) do if pl:get_pos() and vector.distance(center, pl:get_pos()) <= radius then table.insert(rpls, pl) end end
	return valid_object_iterator(rpls)
end

mcl_death_messages.messages.scp_173 = { plain = "@1's neck was snapped by SCP-173." }
mcl_damage.types.scp_173 = { bypasses_armor = true, bypasses_magic = false, bypasses_invulnerability = false, bypasses_totem = false }

mcl_mobs.register_mob(":scp:scp_173", {
    description = "SCP 173",
    type = "monster",
    spawn_class = "hostile",
    persist_in_peaceful = true,
    attack_type = "dogfight",
    damage = 100,
    reach = 3,
    passive = false,
    hp_min = 1,
    hp_max = 1,
    xp_min = 0,
    xp_max = 0,
    pathfinding = 1,
    armor = { fleshy = 0 },
    collisionbox = { -0.5, -0.5, -0.5, 0.5, 1.4, 0.5 },
    visual = "mesh",
    mesh = "3d_armor_stand.obj",
    textures = { "default_wood.png", "blank.png" },
    pushable = false,
    mob_pushable = false,
    visual_size = { x = 10, y = 10 },
    walk_chance = 100,
    knock_back = false,
    jump = true,
    can_despawn = false,
    does_not_prevent_sleep = true,
    drops = {
    },
    view_range = 64,
    fear_height = 30,
    walk_velocity = 25,
    run_velocity = 25,
    _mcl_fishing_hookable = true,
    _mcl_fishing_reelable = false,
    _arrow_resistant = true,
    lava_damage = 0,
    fire_damage = 0,
    light_damage = 0,
    water_damage = 0,
    _mcl_freeze_damage = 0,
    fire_resistant = true,
    stepheight = 1.5,
    fall_damage = 0,
    suffocation = false,
    player_active_range = 64,
    makes_footstep_sound = true,
    on_activate = function(self, staticdata, dtime)
        self.object:set_properties({
            collide_with_objects = true,
            physical = true,
        })
    end,
	custom_attack = function(self)
		if self.state == "attack" and self.reach > vector.distance(self.object:get_pos(), self.attack:get_pos()) then
			mcl_util.deal_damage(self.attack, self.damage, {type = "scp_173"})
		end
	end,
    do_custom = function(self, dtime)
        local enderpos = self.object:get_pos()
        local is_watched = false
        for obj in mcl_util.connected_players(enderpos, 64) do
            local player_pos = obj:get_pos()
            local player_eye_height = obj:get_properties().eye_height

            if not player_eye_height then
                minetest.log("error", "Enderman at location: " .. dump(enderpos) .. " has indexed a null player!")
            else
                local look_pos_base = vector.new(player_pos.x, player_pos.y + player_eye_height, player_pos.z)
                local ender_eye_pos = vector.new(enderpos.x, enderpos.y + 1.5, enderpos.z)
                if minetest.line_of_sight(ender_eye_pos, look_pos_base) then
                    local horiz_dir = vector.normalize({x=enderpos.x-player_pos.x, y=0, z=enderpos.z-player_pos.z})
                    local horiz_look = vector.new(math.cos(obj:get_look_horizontal()), 0, math.sin(obj:get_look_horizontal()))
                    local horiz_cross = vector.cross(horiz_dir, horiz_look).y
                    if horiz_cross > 0.5 or ((enderpos.x - player_pos.x) * (enderpos.x - player_pos.x) + (enderpos.z - player_pos.z) * (enderpos.z - player_pos.z)) < 0.5 * 0.5 then
                        is_watched = true
                        break
                    end
                end
            end
        end
        if is_watched then
            self.damage = 0
            self.reach = 0
            self.jump = false
            self.walk_chance = 0
            self.walk_velocity = 0
            self.run_velocity = 0
            self:set_velocity(0)
            if self.object then
                self.object:set_acceleration(vector.new(0, self.fall_speed, 0))
            end
        else
            self.damage = 100
            self.reach = 2
            self.jump = true
            self.walk_chance = 100
            self.walk_velocity = 10
            self.run_velocity = 10
        end
    end,
})

mcl_mobs.register_egg(":scp:scp_173", "SCP 173", "#CEB88D", "#AF240D", 0)
