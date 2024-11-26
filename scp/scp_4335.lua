--scp_4335
mcl_death_messages.messages.scp_4335 = { plain = "@1's neck was snapped by SCP-4335." }
mcl_damage.types.scp_4335 = { bypasses_armor = true, bypasses_magic = true, bypasses_invulnerability = true, bypasses_totem = false }






minetest.register_entity(":scp:scp_4335_eyes", {
    initial_properties = {
        visual = "mesh",
        mesh = "mobs_mc_spider.b3d",
        visual_size = { x = 1.01 / 3, y = 1.01 / 3 },
        glow = 50,
        textures = {
            "mobs_mc_enderman_eyes.png",
        },
    },
    on_step = function(self)
        if self and self.object then
            if not self.object:get_attach() then
                self.object:remove()
            end
        end
    end,
})

local S = minetest.get_translator("mobs_mc")
local enable_damage = minetest.settings:get_bool("enable_damage")

local telesound = function(pos, is_source)
    local snd
    if is_source then
        snd = "mobs_mc_enderman_teleport_src"
    else
        snd = "mobs_mc_enderman_teleport_dst"
    end
    minetest.sound_play(snd, { pos = pos, max_hear_distance = 16 }, true)
end


local pr = PseudoRandom(os.time() * (-334))



 
 
local create_enderman_textures = function(block_type, itemstring)
    local base = "mobs_mc_enderman.png^mobs_mc_enderman_eyes.png"
    return {
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        base,  
    }
end

 
local select_enderman_animation = function(animation_type)
     
    if animation_type == "block" then
        return {
            stand_start = 200,
            stand_end = 200,
            walk_start = 161,
            walk_end = 200,
            walk_speed = 65,
            run_start = 161,
            run_end = 200,
            run_speed = 50,
            punch_start = 121,
            punch_end = 160,
        }
         
    elseif animation_type == "normal" or animation_type == nil then
        return {
            stand_start = 40,
            stand_end = 80,
            stand_speed = 25,
            walk_start = 0,
            walk_end = 40,
            walk_speed = 65,
            run_start = 0,
            run_end = 40,
            run_speed = 50,
            punch_start = 81,
            punch_end = 120,
        }
    end
end

local psdefs = { {
    amount = 5,
    minpos = vector.new(-0.6, 0, -0.6),
    maxpos = vector.new(0.6, 3, 0.6),
    minvel = vector.new(-0.25, -0.25, -0.25),
    maxvel = vector.new(0.25, 0.25, 0.25),
    minacc = vector.new(-0.5, -0.5, -0.5),
    maxacc = vector.new(0.5, 0.5, 0.5),
    minexptime = 0.2,
    maxexptime = 3,
    minsize = 0.2,
    maxsize = 1.2,
    collisiondetection = true,
    vertical = false,
    time = 0,
    texture = "mcl_portals_particle" .. math.random(1, 5) .. ".png",
} }

mcl_mobs.register_mob(":scp:scp_4335", {
    description = S("SCP-4335"),
    type = "monster",
    spawn_class = "passive",
    passive = true,
    pathfinding = 1,
    hp_min = 40,
    hp_max = 40,
    xp_min = 5,
    xp_max = 5,
    collisionbox = { -0.3, -0.01, -0.3, 0.3, 2.89, 0.3 },
    doll_size_override = { x = 0.8, y = 0.8 },
    visual = "mesh",
    mesh = "mobs_mc_enderman.b3d",
    textures = create_enderman_textures(),
    visual_size = { x = 30, y = 3 },
    makes_footstep_sound = true,
    spawn_in_group = 2,
    on_spawn = function(self)
        local spider_eyes = false
        for n = 1, #self.object:get_children() do
            local obj = self.object:get_children()[n]
            if obj:get_luaentity() and self.object:get_luaentity().name == "scp:scp_4335_eyes" then
                spider_eyes = true
            end
        end
        if not spider_eyes then
            minetest.add_entity(self.object:get_pos(), "scp:scp_4335_eyes"):set_attach(self.object, "head.top",
                vector.new(0, 2.54, -1.99), vector.new(90, 0, 180))
            minetest.add_entity(self.object:get_pos(), "scp:scp_4335_eyes"):set_attach(self.object, "head.top",
                vector.new(1, 2.54, -1.99), vector.new(90, 0, 180))
        end
    end,
    sounds = {
        war_cry = "mobs_sandmonster",
        death = { name = "mobs_mc_enderman_death", gain = 0.7 },
        damage = { name = "mobs_mc_enderman_hurt", gain = 0.5 },
        random = { name = "mobs_mc_enderman_random", gain = 0.5 },
        distance = 16,
    },
    damage = 7,
    reach = 3,
    particlespawners = psdefs,
    animation = select_enderman_animation("normal"),
    can_spawn = function(pos)
        return #minetest.find_nodes_in_area(vector.offset(pos, 0, 1, 0), vector.offset(pos, 0, 3, 0), { "air" }) > 2
    end,
    do_custom = function(self, dtime)
         
        local enderpos = self.object:get_pos()
        local dim = mcl_worlds.pos_to_dimension(enderpos)
        if dim == "overworld" then
            if mcl_weather.rain.raining then
                local damage = true
                local enderpos = self.object:get_pos()
                enderpos.y = enderpos.y + 2.89
                local height = { x = enderpos.x, y = enderpos.y + 512, z = enderpos.z }
                local ray = minetest.raycast(enderpos, height, true)
                 
                for pointed_thing in ray do
                    if pointed_thing.type == "node" then
                        local nn = minetest.get_node(minetest.get_pointed_thing_position(pointed_thing)).name
                        local def = minetest.registered_nodes[nn]
                        if (not def) or def.walkable then
                             
                            damage = false
                            break
                        end
                    end
                end

                if damage == true then
                    self.state = ""
                     
                    self.object:punch(self.object, 1.0, {
                        full_punch_interval = 1.0,
                        damage_groups = { fleshy = self._damage },
                    }, nil)
                     
                    self:teleport(nil)
                end
            end
        end

         
        if self.state == "attack" then
            if self.attack then
                local target = self.attack
                local pos = target:get_pos()
                if pos ~= nil then
                    if vector.distance(self.object:get_pos(), target:get_pos()) > 10 then
                        self:teleport(target)
                    end
                end
            end
        else  
            if dim == 'overworld' then
                local light = minetest.get_node_light(enderpos)
                if light and light > minetest.LIGHT_MAX then
                    self:teleport(nil)
                end
            end
        end
         
         

        enderpos = self.object:get_pos()
        enderpos.y = enderpos.y + 1.5
        for obj in minetest.objects_inside_radius(enderpos, 2) do
            if not minetest.is_player(obj) then
                local lua = obj:get_luaentity()
                if lua then
                    if lua.name == "mcl_bows:arrow_entity" or lua.name == "mcl_throwing:snowball_entity" then
                        self:teleport(nil)
                    end
                end
            end
        end

         
        local enderpos = self.object:get_pos()
        if self.provoked == "broke_contact" then
            self.provoked = "false"
             
             
             
             
            if self.attack ~= nil and enable_damage then
                self.state = 'attack'
            end
             
        end
         
        for obj in mcl_util.connected_players(enderpos, 64) do
             
            local player_pos = obj:get_pos()
             
            local look_dir_not_normalized = obj:get_look_dir()
            local look_dir = vector.normalize(look_dir_not_normalized)
            local player_eye_height = obj:get_properties().eye_height

            if not player_eye_height then
                minetest.log("error", "SCP-4335 at location: " .. dump(enderpos) .. " has indexed a null player!")
            else
                local look_pos = vector.new(player_pos.x, player_pos.y + player_eye_height, player_pos.z)
                local look_pos_base = look_pos
                local ender_eye_pos = vector.new(enderpos.x, enderpos.y + 2.75, enderpos.z)
                local eye_distance_from_player = vector.distance(ender_eye_pos, look_pos)
                look_pos = vector.add(look_pos, vector.multiply(look_dir, eye_distance_from_player))

                if minetest.line_of_sight(ender_eye_pos, look_pos_base) and vector.distance(look_pos, ender_eye_pos) <= 0.4 then
                    self.provoked = "staring"
                    self.attack = minetest.get_player_by_name(obj:get_player_name())
                    break
                else  
                    if self.provoked == "staring" then
                        self.provoked = "broke_contact"
                    end
                end
            end
        end
         
        local enderpos = self.object:get_pos()
        if math.random(1, 140) == 1 then
            for mob in minetest.objects_inside_radius(enderpos, self.view_range) do
                local entity = mob:get_luaentity()
                if entity and entity.name == "mobs_mc:endermite" then
                    self.attack = mob
                    self.state = 'attack'
                end
            end
        end
         
    end,
    do_teleport = function(self, target)
        if target ~= nil then
            local target_pos = target:get_pos()
             
            local nodes = minetest.find_nodes_in_area_under_air(vector.subtract(target_pos, 5), vector.add(target_pos, 5),
                { "mcl_core:andesite_smooth", "mcl_copper:block_oxidized_preserved", "mcl_stairs:slab_andesite_smooth_top", "mcl_copper:block_oxidized_grate_preserved" })
            local telepos
            if nodes ~= nil then
                if #nodes > 0 then
                     
                    for _ = 1, math.min(64, #nodes) do
                        local r = pr:next(1, #nodes)
                        local nodepos = nodes[r]
                        local node_ok = true
                         
                        for u = 1, 3 do
                            local node = minetest.get_node({ x = nodepos.x, y = nodepos.y + u, z = nodepos.z })
                            local ndef = minetest.registered_nodes[node.name]
                            if ndef and ndef.walkable then
                                node_ok = false
                                break
                            end
                        end
                        if node_ok then
                            telepos = { x = nodepos.x, y = nodepos.y + 1, z = nodepos.z }
                        end
                    end
                    if telepos then
                        telesound(self.object:get_pos(), false)
                        self.object:set_pos(telepos)
                        telesound(telepos, true)
                    end
                end
            end
        else
             
            local pos = self.object:get_pos()
             
            for _ = 1, 8 do
                local node_ok = false
                 
                local randomCube = vector.new(pos.x + 8 * (pr:next(0, 16) - 8), pos.y + 8 * (pr:next(0, 16) - 8),
                    pos.z + 8 * (pr:next(0, 16) - 8))
                local nodes = minetest.find_nodes_in_area_under_air(vector.subtract(randomCube, 4),
                    vector.add(randomCube, 4), { "group:solid", "group:cracky", "group:crumbly" })
                if nodes ~= nil then
                    if #nodes > 0 then
                         
                        for _ = 1, math.min(8, #nodes) do
                            local r = pr:next(1, #nodes)
                            local nodepos = nodes[r]
                            node_ok = true
                            for u = 1, 3 do
                                local node = minetest.get_node({ x = nodepos.x, y = nodepos.y + u, z = nodepos.z })
                                local ndef = minetest.registered_nodes[node.name]
                                if ndef and ndef.walkable then
                                    node_ok = false
                                    break
                                end
                            end
                            if node_ok then
                                telesound(self.object:get_pos(), false)
                                local telepos = { x = nodepos.x, y = nodepos.y + 1, z = nodepos.z }
                                self.object:set_pos(telepos)
                                telesound(telepos, true)
                                break
                            end
                        end
                    end
                end
                if node_ok then
                    break
                end
            end
        end
    end,
    do_punch = function(self, hitter, tflp, tool_caps, dir)  
         
        if hitter ~= self.object and hitter ~= nil then
             
             
             
            if pr:next(1, 8) == 8 then  
                self:teleport(hitter)
            end
            self.attack = hitter
            self.state = "attack"
             
        end
    end,
    custom_attack = function(self)
        if self.state == "attack" and self.reach > vector.distance(self.object:get_pos(), self.attack:get_pos()) then
            mcl_util.deal_damage(self.attack, self.damage, { type = "scp_4335" })
        end
    end,
    armor = { fleshy = 100, water_vulnerable = 100 },
    water_damage = 8,
    view_range = 64,
    fear_height = 4,
    attack_type = "dogfight",
    persist_in_peaceful = true,
    can_despawn = false,
    walk_velocity = 50,
    run_velocity = 50,
    drops = { { name = "mcl_core:emerald", chance = 1, min = 10, max = 10 } },
})


 
mcl_mobs.register_egg(":scp:scp_4335", S("SCP-4335"), "#252525", "#151515", 0)



--1004,-13,-1511
