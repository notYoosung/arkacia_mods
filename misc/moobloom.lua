local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)


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

local blank = "blank.png^[png:"
local buttercup_texture = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXOXkFy+AAAAAQG2v00lAAAAfklEQVQ4EWNgGAWjIUDrEPj/wvX//zd5/8my5/8js/9/rnH9/31BGGhIPk5DWHCZ/vrpJQauPz8YOHmAKv5cw6WMgQmXTMq6/wyP/rIzvOXRZmCU2M2ISx1OF3zg52cIXfaVgU/sCS69hMXlCoVx+h2mG6cXQAo0tORg6nDSAOMJJUWThgXlAAAAAElFTkSuQmCC"
local moobloom_texture = blank .. "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"
local moobloom_spawnegg_texture = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAABAAAAAQE4IvRAAAABU0lEQVQ4Ec2SvU7DMBSFT5ImlAJV+FEpRQjRn4GhMMIAKy/B1LEjT9KRsSMbWyXUN2AlYoKCVBYWUBC0VKqK4djYchrExMCVYju+99z7+drAv7brM4jLU4jfIJ2fnA9RS2T8LIJ+U7ofn4C1/TaWthqpeHc6AcUrhU2Ei6sID7vSXVwG8mEBz/ftFE1mOgEr04L8PD6cKhZCFeFkfdxcNNSPNSaQeOZaBfDqXSl2e2VMBir6NVbzbQ/Ya8LoUgQMm0RH8OaUgLModZAbxRhGx2rTGk0PdHX6JEHlToaRQMxuG0n1i9C+GUPALnvFdVmdZ7fxxVUZnkmRXBiCwVsMMRpLrxY7O4qCm7oHud3zRAbTDO4SjYjsvFvryMDx99m18H34kngPhsBOq6tRbJsfzICktiUI6NANIoltvL7SQQsb9ZOUxo4zaybiq+SnkxrnXy4+AdIXdFtVg5h7AAAAAElFTkSuQmCC"
local pink_daisy_texture = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAW0lEQVR42mMYBcMevF1++j8Ik6351+nr/79vufb/dvcW0gwBaQThH3MZ/n9u4YAbRIrtIA1gA+5nM4DYpHsFqAnFC/QORAQIXa37P2iWHnmGiNewoGgm2xB88gBCYVhFQGm8EAAAAABJRU5ErkJggg=="
local moolip_texture = blank .. "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"
local moolip_spawnegg_texture = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAABAAAAAQE4IvRAAAABnklEQVQ4Ec1SvU4CQRD+OA5BlB9B4MBEg1pYamJiZeEbWCgv4DPwFja2GivjA5hYaaxsNEosNFopRiVREEQ4fu48bt3duBsO1MTOaXZ3Zr5vvplZ4F9bNrVE1uIL5DeR6nfB7PwyB2WMSVSsJiKqn5BkEOu5PVdvfp+DgdPBONwuN6bCGlK3LTwaVZyG31Fu17Fxse/AKL2MoLUVl4KQ1w/L7sDnUhH3DGMiGINeKPWlO1pgPa+YaejhMDrExnS+Aws240TiwcBqdJYRkO3iqVThIGDRASp9/M6El54GhZpUxcloDQW9gsV6lKU4TLbAqmeic/BQYD6tojgToGALDduENjQiQUxF92Ykga0FcBbTueDYYAjBmze0KQGzsXvTUd0kHUkoCVifTKZFg4HrMj1tFNJemSguR/4X3pZ4y2EwBx8ilahCQS7R5FsQvR8HyhxTatWweXkgcX1DLH3oUOkaLZtwRWwOwqpGA4TwPyZckEzCIwb0tTLhxk7pHH4tgq2rQwfG8ZDZ9MKIfMkI/1SVp2fsvuZ+zO3G/fn+CUDWoifJPZ+KAAAAAElFTkSuQmCC"

mcl_flowers.register_simple_flower("buttercup", {
	desc = "Buttercup",
	image = buttercup_texture,
	selection_box = { -5/16, -0.5, -5/16, 5/16, 3/16, 5/16 },
	potted = true,
})
mcl_flowers.register_simple_flower("pink_daisy", {
	desc = "Pink Daisy",
	image = pink_daisy_texture,
	selection_box = { -5 / 16, -0.5, -5 / 16, 5 / 16, 3 / 16, 5 / 16 },
	potted = true,
})

local cow_def = {
	description = S("Cow"),
	type = "animal",
	spawn_class = "passive",
	passive = true,
	hp_min = 10,
	hp_max = 10,
	xp_min = 1,
	xp_max = 3,
	collisionbox = { -0.45, -0.01, -0.45, 0.45, 1.39, 0.45 },
	spawn_in_group = 4,
	spawn_in_group_min = 3,
	visual = "mesh",
	mesh = "mobs_mc_cow.b3d",
	textures = { {
		"mobs_mc_cow.png",
		"blank.png",
	}, },
	head_swivel = "head.control",
	bone_eye_height = 10,
	head_eye_height = 1.1,
	horizontal_head_height = -1.8,
	curiosity = 2,
	head_yaw = "z",
	makes_footstep_sound = true,
	walk_velocity = 0.7,
	run_velocity = 1.5,
	follow_velocity = 1.5,
	walk_chance = 15,
	drops = {
		{
			name = "mcl_mobitems:beef",
			chance = 1,
			min = 1,
			max = 3,
			looting = "common",
		},
		{
			name = "mcl_mobitems:leather",
			chance = 1,
			min = 0,
			max = 2,
			looting = "common",
		},
	},
	runaway = true,
	sounds = {
		random = "mobs_mc_cow",
		damage = "mobs_mc_cow_hurt",
		death = "mobs_mc_cow_hurt",
		eat = "mobs_mc_animal_eat_generic",
		distance = 16,
	},
	animation = {
		stand_start = 0,
		stand_end = 0,
		walk_start = 0,
		walk_end = 40,
		walk_speed = 40,
		run_start = 0,
		run_end = 40,
		run_speed = 40,
	},
	_child_animations = {
		stand_start = 41,
		stand_end = 41,
		walk_start = 41,
		walk_end = 81,
		walk_speed = 80,
		run_start = 41,
		run_end = 81,
		run_speed = 80,
	},
	on_rightclick = function(self, clicker)
		if self:feed_tame(clicker, 1, true, false) then return end
		if self.child then return end

		local item = clicker:get_wielded_item()
		if item:get_name() == "mcl_buckets:bucket_empty" and clicker:get_inventory() then
			local inv = clicker:get_inventory()
			inv:remove_item("main", "mcl_buckets:bucket_empty")
			minetest.sound_play("mobs_mc_cow_milk", { pos = self.object:get_pos(), gain = 0.6 })
			if inv:room_for_item("main", { name = "mcl_mobitems:milk_bucket" }) then
				clicker:get_inventory():add_item("main", "mcl_mobitems:milk_bucket")
			else
				local pos = self.object:get_pos()
				pos.y = pos.y + 0.5
				minetest.add_item(pos, { name = "mcl_mobitems:milk_bucket" })
			end
			return
		end
	end,
	follow = { "mcl_farming:wheat_item" },
	view_range = 10,
	fear_height = 4,
	can_despawn = false,
}

local sound_place = mcl_sounds.node_sound_leaves_defaults().place

mcl_mobs.register_mob(":arkacia:moobloom", table.merge(cow_def, {
	description = S("Moobloom"),
	spawn_in_group_min = 4,
	spawn_in_group = 8,
	textures = { { moobloom_texture, buttercup_texture } },
	on_lightning_strike = function(self)
		mcl_util.replace_mob(self.object, "arkacia:moolip")
		return true
	end,
	on_rightclick = function(self, clicker)
		if self:feed_tame(clicker, 1, true, false) then return end
		if self.child then return end

		local item = clicker:get_wielded_item()
		if minetest.get_item_group(item:get_name(), "shears") > 0 then
			local pos = self.object:get_pos()
			minetest.sound_play("mcl_tools_shears_cut", { pos = pos }, true)

			minetest.add_item({ x = pos.x, y = pos.y + 1.4, z = pos.z }, "mcl_flowers:buttercup")
			mcl_util.replace_mob(self.object, "mobs_mc:cow")

			if not minetest.is_creative_enabled(clicker:get_player_name()) then
				item:add_wear(mobs_mc.shears_wear)
				clicker:get_inventory():set_stack("main", clicker:get_wield_index(), item)
			end
		elseif item:get_name() == "mcl_buckets:bucket_empty" and clicker:get_inventory() then
			local inv = clicker:get_inventory()
			inv:remove_item("main", "mcl_buckets:bucket_empty")
			minetest.sound_play("mobs_mc_cow_milk", { pos = self.object:get_pos(), gain = 0.6 })
			if inv:room_for_item("main", { name = "mcl_mobitems:milk_bucket" }) then
				clicker:get_inventory():add_item("main", "mcl_mobitems:milk_bucket")
			else
				local pos = self.object:get_pos()
				pos.y = pos.y + 0.5
				minetest.add_item(pos, { name = "mcl_mobitems:milk_bucket" })
			end
		end
	end,
	_on_dispense = function(self, dropitem, pos, droppos, dropnode, dropdir)
		if minetest.get_item_group(dropitem:get_name(), "shears") > 0 then
			minetest.add_item({ x = pos.x, y = pos.y + 1.4, z = pos.z }, "mcl_flowers:buttercup")
			mcl_util.replace_mob(self.object, "mobs_mc:cow")
			return dropitem
		end
		return mcl_mobs.mob_class._on_dispense(self, dropitem, pos, droppos, dropnode, dropdir)
	end,
	do_custom = function(self, dtime)
		self.egg_timer = (self.egg_timer or 5) - dtime
		if self.egg_timer > 0 then
			return
		end
		self.egg_timer = nil

		local pos = self.object:get_pos()

		local node = minetest.get_node_or_nil(pos)
		local soil_node = minetest.get_node_or_nil(vector.add(pos, {x=0, y=-1, z=0}))
		local ok = soil_node and (soil_node.name == "mcl_core:dirt" or minetest.get_item_group(soil_node.name, "grass_block") == 1 or soil_node.name == "mcl_lush_caves:moss")
		if (node.name == "air" or minetest.registered_nodes[node.name].buildable_to == true) and ok then
			local flower = "mcl_flowers:dandelion"
			if math.random() < 0.2 then
				flower = "mcl_flowers:sunflower"
			end
			
			local success = minetest.place_node(pos, { name = flower }, self.object)
			if success then
				mcl_bone_meal.add_bone_meal_particle(pos)
				minetest.sound_play(sound_place, { pos = pos, max_hear_distance = 16 }, true)
				minetest.sound_play("mobs_mc_chicken_lay_egg", {
					pos = pos,
					gain = 1.0,
					max_hear_distance = 16,
				}, true)
			end	
		end

	end,
}))
mcl_mobs.register_egg(":arkacia:moobloom", S("Moobloom"), "#a00f10", "#b7b7b7", 0)
minetest.override_item("arkacia:moobloom", {
	inventory_image = moobloom_spawnegg_texture
})



mcl_mobs.register_mob(":arkacia:moolip", table.merge(cow_def, {
	description = S("Moolip"),
	spawn_in_group_min = 4,
	spawn_in_group = 8,
	textures = { { moolip_texture, pink_daisy_texture } },
	on_lightning_strike = function(self)
		mcl_util.replace_mob(self.object, "arkacia:moobloom")
		return true
	end,
	on_rightclick = function(self, clicker)
		if self:feed_tame(clicker, 1, true, false) then return end
		if self.child then return end

		local item = clicker:get_wielded_item()
		if minetest.get_item_group(item:get_name(), "shears") > 0 then
			local pos = self.object:get_pos()
			minetest.sound_play("mcl_tools_shears_cut", { pos = pos }, true)

			minetest.add_item({ x = pos.x, y = pos.y + 1.4, z = pos.z }, "mcl_flowers:pink_daisy")
			mcl_util.replace_mob(self.object, "mobs_mc:cow")

			if not minetest.is_creative_enabled(clicker:get_player_name()) then
				item:add_wear(mobs_mc.shears_wear)
				clicker:get_inventory():set_stack("main", clicker:get_wield_index(), item)
			end
		elseif item:get_name() == "mcl_buckets:bucket_empty" and clicker:get_inventory() then
			local inv = clicker:get_inventory()
			inv:remove_item("main", "mcl_buckets:bucket_empty")
			minetest.sound_play("mobs_mc_cow_milk", { pos = self.object:get_pos(), gain = 0.6 })
			if inv:room_for_item("main", { name = "mcl_mobitems:milk_bucket" }) then
				clicker:get_inventory():add_item("main", "mcl_mobitems:milk_bucket")
			else
				local pos = self.object:get_pos()
				pos.y = pos.y + 0.5
				minetest.add_item(pos, { name = "mcl_mobitems:milk_bucket" })
			end
		end
	end,
	_on_dispense = function(self, dropitem, pos, droppos, dropnode, dropdir)
		if minetest.get_item_group(dropitem:get_name(), "shears") > 0 then
			minetest.add_item({ x = pos.x, y = pos.y + 1.4, z = pos.z }, "mcl_flowers:pink_daisy")
			mcl_util.replace_mob(self.object, "mobs_mc:cow")
			return dropitem
		end
		return mcl_mobs.mob_class._on_dispense(self, dropitem, pos, droppos, dropnode, dropdir)
	end,
	do_custom = function(self, dtime)
		self.egg_timer = (self.egg_timer or 5) - dtime
		if self.egg_timer > 0 then
			return
		end
		self.egg_timer = nil

		local pos = self.object:get_pos()

		local node = minetest.get_node_or_nil(pos)
		local soil_node = minetest.get_node_or_nil(vector.add(pos, { x = 0, y = -1, z = 0 }))
		local ok = soil_node and
		(soil_node.name == "mcl_core:dirt" or minetest.get_item_group(soil_node.name, "grass_block") == 1 or soil_node.name == "mcl_lush_caves:moss")
		if (node.name == "air" or minetest.registered_nodes[node.name].buildable_to == true) and ok then
			local flower = "mcl_flowers:peony"
			if math.random() < 0.4 then
				flower = "mcl_flowers:allium"
			elseif math.random() < 0.8 then
				flower = "mcl_flowers:allium"
			end

			local success = minetest.place_node(pos, { name = flower }, self.object)
			if success then
				mcl_bone_meal.add_bone_meal_particle(pos)
				minetest.sound_play(sound_place, { pos = pos, max_hear_distance = 16 }, true)
				minetest.sound_play("mobs_mc_chicken_lay_egg", {
					pos = pos,
					gain = 1.0,
					max_hear_distance = 16,
				}, true)
			end
		end
	end,
}))
mcl_mobs.register_egg(":arkacia:moolip", S("Moolip"), "#a00f10", "#b7b7b7", 0)
minetest.override_item("arkacia:moolip", {
	inventory_image = moolip_spawnegg_texture
})
