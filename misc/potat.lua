--MCmobs v0.4
--maikerumine
--made for MC like Survival game
--License for code WTFPL and otherwise stated in readmes

local S = minetest.get_translator("mobs_mc")

local potat_texture = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAA7DAAAOwwHHb6hkAAABQElEQVQ4EWP8DwQMFAAmCvSCtQ68ASyEvLA5VQhFie/sdyh8RmyBiKxJyoiZQVRDl+HXk8sMv/78Z7h77B8DsiEYBoA060cZMPDyQhz3j4mR4eXFswzi+sYM76+eY/j26z/DwxMIQ1ACEaTZJt2EQcgmmOGPihAYg9wL0gwCbDK6YPrQkY9gGkTADQBplrdgAmviZA1mEBKYwMDJbQtX+PXjb4YP9y4x3D/5Dy6GYgCII6tvhCL5/ethMB9d88O3bHB18DAo1WRmKDseysB07z3DPyVBsILv518xnFh4jkHDlgVu89IN3xlWvfoONwAlGp+v3cMgoKTHwA00hOnff7CTYZpBGkEAWTOID3cBiANyhak5L4MIL8SJn3/+YcClEaQeBFAMAAmADEH2I7qNIDXIAMMAZEli2PBoJEYxNjUApDCNvAPbZf8AAAAASUVORK5CYII="

--###################
--################### PARROT
--###################
local shoulders = {
    left = vector.new(-3.75, 10.5, 0),
    right = vector.new(3.75, 10.5, 0)
}

local function table_get_rand(tbl)
    local keys = {}
    for k in pairs(tbl) do
        table.insert(keys, k)
    end
    return tbl[keys[math.random(#keys)]]
end

local function get_random_mob_sound()
    local t = table.copy(minetest.registered_entities)
    table.shuffle(t)
    for _, e in pairs(t) do
        if e.is_mob and e.sounds and #e.sounds > 0 then
            return table_get_rand(e.sounds)
        end
    end
    return minetest.registered_entities["arkacia:potat"].sounds.random
end

local function imitate_mob_sound(self, mob)
    local snd = mob.sounds.random
    if not snd or mob.name == "arkacia:potat" or math.random(20) == 1 then
        snd = get_random_mob_sound()
    end
    return minetest.sound_play(snd, {
        pos = self.object:get_pos(),
        gain = 1.0,
        pitch = 2.5,
        max_hear_distance = self.sounds and self.sounds.distance or 32
    }, true)
end

local function check_mobimitate(self, dtime)
    if not self:check_timer("mobimitate", 30) then return end

    for o in minetest.objects_inside_radius(self.object:get_pos(), 20) do
        local l = o:get_luaentity()
        if l and l.is_mob and l.name ~= "arkacia:potat" then
            imitate_mob_sound(self, l)
            return
        end
    end
end

--find a free shoulder or return nil
local function get_shoulder(player)
    local sh = "left"
    for _, o in pairs(player:get_children()) do
        local l = o:get_luaentity()
        if l and l.name == "arkacia:potat" then
            local _, _, a = l.object:get_attach()
            for _, s in pairs(shoulders) do
                if a and vector.equals(a, s) then
                    if sh == "left" then
                        sh = "right"
                    else
                        return
                    end
                end
            end
        end
    end
    return shoulders[sh]
end

local function perch(self, player)
    if self.tamed and player:get_player_name() == self.owner and not self.object:get_attach() then
        local shoulder = get_shoulder(player)
        if not shoulder then return true end
        self.object:set_attach(player, "", shoulder, vector.new(0, 0, 0), true)
        self:set_animation("stand")
    end
end

local function check_perch(self, dtime)
    if self.object:get_attach() then
        for p in mcl_util.connected_players() do
            for _, o in pairs(p:get_children()) do
                local l = o:get_luaentity()
                if l and l.name == "arkacia:potat" then
                    local n1 = minetest.get_node(vector.offset(p:get_pos(), 0, -0.6, 0)).name
                    local n2 = minetest.get_node(vector.offset(p:get_pos(), 0, 0, 0)).name
                    if (n1 == "air" or minetest.get_item_group(n2, "water") > 0 or minetest.get_item_group(n2, "lava") > 0) and
                        not minetest.is_creative_enabled(p:get_player_name()) then
                        o:set_detach()
                        self.detach_timer = 0
                        return
                    end
                end
            end
        end
    elseif not self.detach_timer then
        for p in mcl_util.connected_players() do
            if vector.distance(self.object:get_pos(), p:get_pos()) < 0.5 then
                perch(self, p)
                return
            end
        end
    elseif self.detach_timer then
        if self.detach_timer > 1 then
            self.detach_timer = nil
        else
            self.detach_timer = self.detach_timer + dtime
        end
    end
end

mcl_mobs.register_mob(":arkacia:potat", {
    description = S("Potat"),
    type = "animal",
    spawn_class = "passive",
    passive = true,
    pathfinding = 1,
    hp_min = 6,
    hp_max = 6,
    xp_min = 1,
    xp_max = 3,
    head_swivel = "head.control",
    bone_eye_height = 1.1,
    horizontal_head_height = 0,
    curiosity = 10,
    collisionbox = { -0.25, -0.01, -0.25, 0.25, 0.89, 0.25 },
    visual = "mesh",
    mesh = "mobs_mc_parrot.b3d",
    textures = { { "mobs_mc_parrot_blue.png" }, { "mobs_mc_parrot_green.png" }, { "mobs_mc_parrot_grey.png" }, { "mobs_mc_parrot_red_blue.png" }, { "mobs_mc_parrot_yellow_blue.png" } },
    visual_size = { x = 3, y = 3 },
    sounds = {
        random = "mobs_mc_parrot_random",
        damage = { name = "mobs_mc_parrot_hurt", gain = 0.3 },
        death = { name = "mobs_mc_parrot_death", gain = 0.6 },
        eat = "mobs_mc_animal_eat_generic",
        distance = 16,
    },
    drops = {
        {
            name = "mcl_mobitems:feather",
            chance = 1,
            min = 1,
            max = 2,
            looting = "common",
        },
    },
    animation = {
        stand_start = 0,
        stand_end = 0,
        stand_speed = 50,
        fly_start = 130,
        fly_end = 150,
        fly_speed = 50,
        walk_start = 20,
        walk_end = 40,
        walk_speed = 50,
        -- TODO: actual walk animation
        --walk_start = 0,
        --walk_end = 20,

        -- TODO: more unused animations between 45 and 130
    },
    fall_damage = 0,
    fall_speed = -2.25,
    attack_type = "dogfight",
    floats = 1,
    physical = true,
    walk_velocity = 0.5,
    run_velocity = 1,
    fly = true,
    walk_chance = 75,
    fly_chance = 50,
    makes_footstep_sound = false,
    fear_height = 0,
    view_range = 16,
    on_rightclick = function(self, clicker)
        if self._doomed then return end
        local item = clicker:get_wielded_item()
        -- Kill parrot if fed with cookie
        if item:get_name() == "mcl_farming:cookie" then
            minetest.sound_play("mobs_mc_animal_eat_generic", { object = self.object, max_hear_distance = 16 }, true)
            self.health = 0
            -- Doomed to die
            self._doomed = true
            if not minetest.is_creative_enabled(clicker:get_player_name()) then
                item:take_item()
                clicker:set_wielded_item(item)
            end
            return
        end
        -- Feed to tame, but not breed
        local food = {
            "mcl_farming:wheat_seeds",
            "mcl_farming:melon_seeds",
            "mcl_farming:pumpkin_seeds",
            "mcl_farming:beetroot_seeds",
        }
        if table.indexof(food, item:get_name()) ~= -1 and self:feed_tame(clicker, 4, false, true) then return end
        perch(self, clicker)
    end,
    do_custom = function(self, dtime)
        check_perch(self, dtime)
        check_mobimitate(self, dtime)
    end,
    do_punch = function(self, puncher) --do_punch is the mcl_mobs_redo variant - it gets called by on_punch later....
        if self.object:get_attach() == puncher then
            return false           --return false explicitly here. mcl_mobs checks for that
        end
    end,
})

-- spawn eggs
mcl_mobs.register_egg(":arkacia:potat", S("Potat"), "#0da70a", "#ff0000", 0)
