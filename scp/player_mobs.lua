local S = minetest.get_translator("mobs_mc")

mcl_mobs.register_mob(":scp:player_mob_mtf_epsilon_11", {
	description = minetest.colorize("#FF5555", "MTF Epsilon-11 | \"NINE TAILED FOX\""),
	type = "monster",
	spawn_class = "hostile",
	pathfinding = 1,
	hp_min = 24,
	hp_max = 24,
	xp_min = 6,
	xp_max = 6,
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 1.90, 0.3},
	visual = "mesh",
	mesh = "mcl_armor_character.b3d",
	head_swivel = "head.control",
	bone_eye_height = 2.2,
	head_eye_height = 2.2,
	curiosity = 100,
	textures = {"blank.png^[png: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", "blank.png", "blank.png"},
	visual_size = {
		x = 1,
		y = 1
	},
	makes_footstep_sound = true,
	damage = 13,
	reach = 2,
	walk_velocity = 1.2,
	run_velocity = 1.6,
	attack_type = "dogfight",
    specific_attack = { "player", },
	group_attack = true,
	attack_npcs = true,
	drops = {{
		name = "mcl_core:emerald",
		chance = 0,
		min = 0,
		max = 0,
		looting = "common"
	},},
	animation = {
		stand_start = 40, stand_end = 49, stand_speed = 2,
		walk_start = 0, walk_end = 39, speed_normal = 25,
		run_start = 0, run_end = 39, speed_run = 50,
		punch_start = 50, punch_end = 59, punch_speed = 20,
	},
	view_range = 16,
	fear_height = 4
})

mcl_mobs.register_egg(":scp:player_mob_mtf_epsilon_11", minetest.colorize("#FF5555", "MTF Epsilon-11 | \"NINE TAILED FOX\""), "#333333", "#6F130B", 0)
minetest.register_alias("scp:playermodel_entity", "scp:player_mob_mtf_epsilon_11")

