minetest.register_node(":magikacia:firefly_light", {
    description = "Firefly Light\n" .. minetest.colorize(mcl_colors.GREEN, "Luminance: 5"),
    drawtype = "airlike",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    air_equivalent = true,
    groups = { not_in_creative_inventory = 1 },
    light_source = 5,
    on_timer = function(pos)
        local node = minetest.get_node(pos)
        if node.name == "magikacia:firefly_light" then
            minetest.swap_node(pos, { name = "air" })
        end
        return false
    end,
})
local function register_firefly(def)
    mcl_mobs.register_mob(":magikacia:firefly_" .. def.colorname, {
        description = def.colordesc .. " Firefly",
        type = "animal",
        spawn_class = "ambient",
        can_despawn = false,
        spawn_in_group = 8,
        passive = true,
        hp_min = 1,
        hp_max = 1,
        collisionbox = { -0.25, -0.01, -0.25, 0.25, 0.89, 0.25 },
        armor = 0,
        visual = "sprite",
        textures = {
            { magikacia.textures["firefly_" .. def.colorname] },
        },
        visual_size = { x = 1, y = 1 },
        walk_velocity = 0.5,
        run_velocity = 1,
        walk_chance = 100,
        fall_damage = 0,
        view_range = 8,
        fear_height = 0,

        jump = false,
        fly = true,
        makes_footstep_sound = false,
        do_custom = function(self, dtime)
            if not self._home then
                self._home = self.object:get_pos()
            end
            self.home_timer = (self.home_timer or 0) + dtime
            self.light_timer = (self.light_timer or 0) + dtime
            if self.light_timer > 3 then
                local pos = self.object:get_pos()
                local node = minetest.get_node(pos)
                if node and node.name == "air" then
                    minetest.swap_node(pos, { name = "magikacia:firefly_light" })
                    local timer = minetest.get_node_timer(pos)
                    timer:start(3)
                end
            end
            if self.home_timer > 60 then
                local pos = self.object:get_pos()
                self.home_timer = 0
                if self._home then
                    local dist = vector.distance(self._home, pos)
                    if dist >= 16 then
                        self.object:set_pos(self._home)
                    end
                end
            end
        end,
    })

    mcl_mobs.register_egg(":magikacia:firefly_" .. def.colorname, def.colordesc .. " Firefly",
    def.spawnegg_color_background, def.spawnegg_color_overlay, 0)
end


register_firefly({
    colorname = "blue",
    colordesc = "Blue",
    spawnegg_color_background = "#5F7999",
    spawnegg_color_overlay = "#535D67",
})
register_firefly({
    colorname = "purple",
    colordesc = "Purple",
    spawnegg_color_background = "#885688",
    spawnegg_color_overlay = "#615061",
})
register_firefly({
    colorname = "green",
    colordesc = "Green",
    spawnegg_color_background = "#71BC67",
    spawnegg_color_overlay = "#597256",
})
