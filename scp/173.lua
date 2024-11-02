local S = minetest.get_translator(minetest.get_current_modname())

mcl_mobs.register_mob(":scp:scp_173", {
    description = "SCP 173",
    type = "",
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
    armor = { fleshy = 0 },
    --collisionbox = { -0.5, -0.5, -0.5, 0.5, 1.4, 0.5 },
    collisionbox = { -0.35, -0.01, -0.35, 0.35, 1.89, 0.35 },
    visual = "mesh",
    mesh = "3d_armor_stand.obj",
    textures = { "default_wood.png", "mcl_stairs_stone_slab_top.png" },
    pushable = false,
    mob_pushable = false,
    visual_size = { x = 10, y = 10 },
    walk_chance = 100,
    knock_back = false,
    jump = true,
    can_despawn = false,
    fall_speed = -100,
    does_not_prevent_sleep = true,
    drops = {
    },
    view_range = 64,
    fear_height = 0,
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
    stepheight = 2,
    fall_damage = 0,
    suffocation = false,
    player_active_range = 64,
    do_custom = function(self, dtime)
        if self.state == "attack" then
			if self.attack then
				local target = self.attack
				local pos = target:get_pos()
				if pos ~= nil then
				end
            end
		end

        local enderpos = self.object:get_pos()
        local is_watched = false;
        for obj in mcl_util.connected_players(enderpos, 64) do
            local player_pos = obj:get_pos()
            local look_dir_not_normalized = obj:get_look_dir()
            local look_dir = vector.normalize(look_dir_not_normalized)
            local player_eye_height = obj:get_properties().eye_height

            if not player_eye_height then
                minetest.log("error", "Enderman at location: " .. dump(enderpos) .. " has indexed a null player!")
            else
                local look_pos = vector.new(player_pos.x, player_pos.y + player_eye_height, player_pos.z)
                local look_pos_base = look_pos
                local ender_eye_pos = vector.new(enderpos.x, enderpos.y + 1, enderpos.z)
                local eye_distance_from_player = vector.distance(ender_eye_pos, look_pos)
                look_pos = vector.add(look_pos, vector.multiply(look_dir, eye_distance_from_player))

                if minetest.line_of_sight(ender_eye_pos, look_pos_base) and vector.distance(look_pos, ender_eye_pos) <= 3 and math.abs(obj:get_look_horizontal() - math.atan2(enderpos.z - player_pos.z, enderpos.x - player_pos.x)) > math.pi / 2 then
                    is_watched = true
                    break
                end
            end
        end
        if is_watched then
            self.reach = 0
            self.jump = false
            self.walk_chance = 0
            self.walk_velocity = 0
            self.run_velocity = 0
            self:set_velocity(0)
            if self.object then
                self.object:set_acceleration(vector.new(0, self.fall_speed, 0))
            end
            self.type = ""
        else
            self.reach = 3
            self.jump = true
            self.walk_chance = 100
            self.walk_velocity = 25
            self.run_velocity = 25
            self.type = "monster"
        end
    end,
})

mcl_mobs.register_egg(":scp:scp_173", "SCP 173", "#CEB88D", "#AF240D", 0)
