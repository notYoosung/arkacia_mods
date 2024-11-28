local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local sf = string.format

local mod_doc = minetest.get_modpath("doc")
local shulker_num_tt_stacks = 5

-- Christmas chest setup
local it_is_christmas = false
local date = os.date("*t")
if (
		date.month == 12 and (
			date.day == 24 or
			date.day == 25 or
			date.day == 26
		)
	) then
	it_is_christmas = true
end

local tiles_chest_normal_small = { "mcl_chests_normal.png" }
local tiles_chest_normal_double = { "mcl_chests_normal_double.png" }

if it_is_christmas then
	tiles_chest_normal_small = { "mcl_chests_normal_present.png^mcl_chests_noise.png" }
	tiles_chest_normal_double = { "mcl_chests_normal_double_present.png^mcl_chests_noise_double.png" }
end

local tiles_chest_trapped_small = { "mcl_chests_trapped.png" }
local tiles_chest_trapped_double = { "mcl_chests_trapped_double.png" }

if it_is_christmas then
	tiles_chest_trapped_small = { "mcl_chests_trapped_present.png^mcl_chests_noise.png" }
	tiles_chest_trapped_double = { "mcl_chests_trapped_double_present.png^mcl_chests_noise_double.png" }
end

local tiles_chest_ender_small = { "mcl_chests_ender.png" }

local ender_chest_texture = { "mcl_chests_ender.png" }
if it_is_christmas then
	tiles_chest_ender_small = { "mcl_chests_ender_present.png^mcl_chests_noise.png" }
	ender_chest_texture = { "mcl_chests_ender_present.png" }
end

-- Chest Entity
local animate_chests = (minetest.settings:get_bool("animated_chests") ~= false)
local entity_animations = {
	shulker = {
		speed = 50,
		open = { x = 45, y = 95 },
		close = { x = 95, y = 145 },
	},
	chest = {
		speed = 25,
		open = { x = 0, y = 7 },
		close = { x = 13, y = 20 },
	},
}


local function get_entity_pos(pos, dir, double)
	pos = vector.copy(pos)
	if double then
		local add, mul, vec, cross = vector.add, vector.multiply, vector.new, vector.cross
		pos = add(pos, mul(cross(dir, vec(0, 1, 0)), -0.5))
	end
	return pos
end


local function get_entity_info(pos, param2, double, dir, _)
	dir = dir or minetest.facedir_to_dir(param2)
	return dir, get_entity_pos(pos, dir, double)
end

local function create_entity(pos, node_name, textures, param2, double, sound_prefix, mesh_prefix, animation_type, dir, entity_pos)
	if animate_chests or double then
		dir, entity_pos = get_entity_info(pos, param2, double, dir, entity_pos)
		local initialization_data = minetest.serialize({pos, node_name, textures, dir, double, sound_prefix, mesh_prefix, animation_type, "###mcl_chests:chest###"})
		local obj = minetest.add_entity(entity_pos, "mcl_chests:chest", initialization_data)
		if obj and obj:get_pos() then
			local luaentity = obj:get_luaentity()
			return luaentity
		else
			minetest.log("warning", "[mcl_chests] Failed to create entity at " .. (entity_pos and minetest.pos_to_string(entity_pos, 1) or "nil"))
		end
	end
end

local function find_or_create_entity(pos, node_name, textures, param2, double, sound_prefix, mesh_prefix, animation_type
	, dir, entity_pos)
	dir, entity_pos = get_entity_info(pos, param2, double, dir, entity_pos)
	return find_entity(entity_pos) or
		create_entity(pos, node_name, textures, param2, double, sound_prefix, mesh_prefix, animation_type, dir, entity_pos)
end

local no_rotate, simple_rotate
if minetest.get_modpath("screwdriver") then
	no_rotate = screwdriver.disallow
	simple_rotate = function(pos, node, user, mode, new_param2)
		if screwdriver.rotate_simple(pos, node, user, mode, new_param2) ~= false then
			local nodename = node.name
			local nodedef = minetest.registered_nodes[nodename]
			local dir = minetest.facedir_to_dir(new_param2)
			if animate_chests then
				find_or_create_entity(pos, nodename, nodedef._chest_entity_textures, new_param2, false, nodedef._chest_entity_sound, nodedef._chest_entity_mesh, nodedef._chest_entity_animation_type, dir):set_yaw(dir)
			end
		else
			return false
		end
	end
end

--[[ List of open chests.
Key: Player name
Value:
	If player is using a chest: { pos = <chest node position> }
	Otherwise: nil ]]
local open_chests = {}

local function back_is_blocked(pos, dir)
	pos = vector.add(pos, dir)
	local def = minetest.registered_nodes[minetest.get_node(pos).name]
	pos.y = pos.y + 1
	local def2 = minetest.registered_nodes[minetest.get_node(pos).name]
	return not def or def.groups.opaque == 1 or not def2 or def2.groups.opaque == 1
end

-- To be called if a player opened a chest
local function player_chest_open(player, pos, node_name, textures, param2, double, sound, mesh, shulker)
	local name = player:get_player_name()
	open_chests[name] = {
		pos = pos,
		node_name = node_name,
		textures = textures,
		param2 = param2,
		double = double,
		sound = sound,
		mesh = mesh,
		shulker = shulker
	}
	if animate_chests then
		local dir = minetest.facedir_to_dir(param2)
		local blocked = not shulker and (back_is_blocked(pos, dir) or double and back_is_blocked(mcl_util.get_double_container_neighbor_pos(pos, param2, node_name:sub(-4)), dir))
		find_or_create_entity(pos, node_name, textures, param2, double, sound, mesh, shulker and "shulker" or "chest", dir):open(name, blocked)
	else
		minetest.sound_play(sound .. "_open", { pos = pos, gain = 0.5, max_hear_distance = 16 }, true)
	end
end

-- Simple protection checking functions
local function protection_check_move(pos, _, _, _, _, count, player)
	local name = player:get_player_name()
	if minetest.is_protected(pos, name) then
		minetest.record_protection_violation(pos, name)
		return 0
	else
		return count
	end
end

local function protection_check_put_take(pos, _, _, stack, player)
	local name = player:get_player_name()
	if minetest.is_protected(pos, name) then
		minetest.record_protection_violation(pos, name)
		return 0
	else
		return stack:get_count()
	end
end

-- To be called when a chest is closed (only relevant for trapped chest atm)
local function chest_update_after_close(pos)
	local node = minetest.get_node(pos)
	if animate_chests then
		if node.name == "mcl_chests:trapped_chest_on_small" then
			mcl_redstone.swap_node(pos, {name="mcl_chests:trapped_chest_small", param2 = node.param2})
			find_or_create_entity(pos, "mcl_chests:trapped_chest_small", {"mcl_chests_trapped.png"}, node.param2, false, "default_chest", "mcl_chests_chest", "chest"):reinitialize("mcl_chests:trapped_chest_small")
		elseif node.name == "mcl_chests:trapped_chest_on_left" then
			mcl_redstone.swap_node(pos, { name = "mcl_chests:trapped_chest_left", param2 = node.param2 })
			find_or_create_entity(pos, "mcl_chests:trapped_chest_left", tiles_chest_trapped_double, node.param2, true,
				"default_chest", "mcl_chests_chest", "chest"):reinitialize("mcl_chests:trapped_chest_left")

			local pos_other = mcl_util.get_double_container_neighbor_pos(pos, node.param2, "left")
			minetest.swap_node(pos_other, { name = "mcl_chests:trapped_chest_right", param2 = node.param2 })
		elseif node.name == "mcl_chests:trapped_chest_on_right" then
			mcl_redstone.swap_node(pos, { name = "mcl_chests:trapped_chest_right", param2 = node.param2 })

			local pos_other = mcl_util.get_double_container_neighbor_pos(pos, node.param2, "right")
			mcl_redstone.swap_node(pos_other, { name = "mcl_chests:trapped_chest_left", param2 = node.param2 })
			find_or_create_entity(pos_other, "mcl_chests:trapped_chest_left", tiles_chest_trapped_double, node.param2, true,
				"default_chest", "mcl_chests_chest", "chest"):reinitialize("mcl_chests:trapped_chest_left")
		end
	end
end

-- To be called if a player closed a chest
local function player_chest_close(player)
	local name = player:get_player_name()
	local open_chest = open_chests[name]
	if open_chest == nil then
		return
	end
	if animate_chests then
		find_or_create_entity(open_chest.pos, open_chest.node_name, open_chest.textures, open_chest.param2, open_chest.double, open_chest.sound, open_chest.mesh, open_chest.shulker and "shulker" or "chest"):close(name)
	else
		minetest.sound_play(open_chest.sound .. "_close", { pos = open_chest.pos, gain = 0.5, max_hear_distance = 16 }, true)
	end
	chest_update_after_close(open_chest.pos)

	open_chests[name] = nil
end

-- This is a helper function to register both chests and trapped chests. Trapped chests will make use of the additional parameters
local chestusage = S("To access its inventory, rightclick it. When broken, the items will drop out.")



-- Disable chest when it has been closed
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname:find("mcl_chests:") == 1 then
		if fields.quit then
			player_chest_close(player)
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	player_chest_close(player)
end)


minetest.register_node("mcl_chests:ender_chest", {
	description = S("Ender Chest"),
	_tt_help = S("27 interdimensional inventory slots") ..
		"\n" .. S("Put items inside, retrieve them from any ender chest"),
	_doc_items_longdesc = S(
		"Ender chests grant you access to a single personal interdimensional inventory with 27 slots. This inventory is the same no matter from which ender chest you access it from. If you put one item into one ender chest, you will find it in all other ender chests. Each player will only see their own items, but not the items of other players."),
	_doc_items_usagehelp = S("Rightclick the ender chest to access your personal interdimensional inventory."),
	drawtype = "mesh",
	mesh = "mcl_chests_chest.b3d",
	tiles = tiles_chest_ender_small,
	use_texture_alpha = "opaque",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { deco_block = 1, unmovable_by_piston = 1},
	sounds = mcl_sounds.node_sound_stone_defaults(),
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		node.name = "mcl_chests:ender_chest_small"
		minetest.set_node(pos, node)
	end,
})

local formspec_ender_chest = table.concat({
	"formspec_version[4]",
	"size[11.75,10.425]",

	"label[0.375,0.375;" .. F(C(mcl_formspec.label_color, S("Ender Chest"))) .. "]",
	mcl_formspec.get_itemslot_bg_v4(0.375, 0.75, 9, 3),
	"list[current_player;enderchest;0.375,0.75;9,3;]",
	"label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",
	mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
	"list[current_player;main;0.375,5.1;9,3;9]",

	mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
	"list[current_player;main;0.375,9.05;9,1;]",

	"listring[current_player;enderchest]",
	"listring[current_player;main]",
})


minetest.register_node("mcl_chests:ender_chest_small", {
	description = S("Ender Chest"),
	_tt_help = S("27 interdimensional inventory slots") ..
		"\n" .. S("Put items inside, retrieve them from any ender chest"),
	_doc_items_longdesc = S(
		"Ender chests grant you access to a single personal interdimensional inventory with 27 slots. This inventory is the same no matter from which ender chest you access it from. If you put one item into one ender chest, you will find it in all other ender chests. Each player will only see their own items, but not the items of other players."),
	_doc_items_usagehelp = S("Rightclick the ender chest to access your personal interdimensional inventory."),
	drawtype = animate_chests and "nodebox" or "mesh",
	mesh = not animate_chests and "mcl_chests_chest.obj" or nil,
	_mcl_baseitem = "mcl_chests:ender_chest",
	node_box = animate_chests and {
		type = "fixed",
        fixed = {-0.4375, -0.5, -0.4375, 0.4375, 0.375, 0.4375},
	} or nil,
	collision_box = {
		type = "fixed",
		fixed = {-0.4375, -0.5, -0.4375, 0.4375, 0.375, 0.4375},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.4375, -0.5, -0.4375, 0.4375, 0.375, 0.4375},
	},
	tiles = animate_chests and {"blank.png"} or {"mcl_chests_ender.png"},
	_chest_entity_textures = {"mcl_chests_ender.png"},
	_chest_entity_sound = "mcl_chests_enderchest",
	_chest_entity_mesh = "mcl_chests_chest",
	_chest_entity_animation_type = "chest",
	use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
	--[[{"mcl_chests_ender_chest_top.png", "mcl_chests_ender_chest_bottom.png",
		"mcl_chests_ender_chest_right.png", "mcl_chests_ender_chest_left.png",
		"mcl_chests_ender_chest_back.png", "mcl_chests_ender_chest_front.png"},]]--
	-- Note: The “container” group is missing here because the ender chest does not
	-- have an inventory on its own
	groups = { pickaxey = 1, deco_block = 1, material_stone = 1, chest_entity = 1, not_in_creative_inventory = 1, unmovable_by_piston = 1},
	is_ground_content = false,
	paramtype = "light",
	light_source = 7,
	paramtype2 = "facedir",
	sounds = mcl_sounds.node_sound_stone_defaults(),
	drop = "mcl_core:obsidian 8",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec_ender_chest)
		create_entity(pos, "mcl_chests:ender_chest_small", {"mcl_chests_ender.png"}, minetest.get_node(pos).param2, false, "mcl_chests_enderchest", "mcl_chests_chest", "chest")
	end,
	on_rightclick = function(pos, node, clicker)
		local def = minetest.registered_nodes[minetest.get_node(vector.offset(pos, 0, 1, 0)).name]
		if not def or def.groups.opaque == 1 then
			-- won't open if there is no space from the top
			return false
		end
		minetest.show_formspec(clicker:get_player_name(), "mcl_chests:ender_chest_" .. clicker:get_player_name(),
			formspec_ender_chest)
		player_chest_open(clicker, pos, "mcl_chests:ender_chest_small", ender_chest_texture, node.param2, false,
			"mcl_chests_enderchest", "mcl_chests_chest")
	end,
	on_receive_fields = function(_, _, fields, sender)
		if fields.quit then
			player_chest_close(sender)
		end
	end,
	_mcl_blast_resistance = 3000,
	_mcl_hardness = 22.5,
	_mcl_silk_touch_drop = { "mcl_chests:ender_chest" },
	on_rotate = simple_rotate,
})

-- minetest.register_on_joinplayer(function(player)
-- 	local inv = player:get_inventory()
-- 	inv:set_size("enderchest", 9 * 3)
-- end)

minetest.register_allow_player_inventory_action(function(player, action, inv, info)
	if inv:get_location().type == "player" and (
			action == "move" and (info.from_list == "enderchest" or info.to_list == "enderchest")
			or action == "put" and info.listname == "enderchest"
			or action == "take" and info.listname == "enderchest"
		) then
		local def = player:get_wielded_item():get_definition()

		if not minetest.find_node_near(player:get_pos(), def and def.range or ItemStack():get_definition().range or tonumber(minetest.settings:get("mcl_hand_range")) or 4.5, "mcl_chests:ender_chest_small", true) then
			return 0
		end
	end
end)

minetest.register_craft({
	output = "mcl_chests:ender_chest",
	recipe = {
		{ "mcl_core:obsidian", "mcl_core:obsidian", "mcl_core:obsidian" },
		{ "mcl_core:obsidian", "mcl_end:ender_eye", "mcl_core:obsidian" },
		{ "mcl_core:obsidian", "mcl_core:obsidian", "mcl_core:obsidian" },
	},
})

-- Shulker boxes
local boxtypes = {
	white = S("White Shulker Box"),
	grey = S("Light Grey Shulker Box"),
	orange = S("Orange Shulker Box"),
	cyan = S("Cyan Shulker Box"),
	magenta = S("Magenta Shulker Box"),
	violet = S("Purple Shulker Box"),
	lightblue = S("Light Blue Shulker Box"),
	blue = S("Blue Shulker Box"),
	yellow = S("Yellow Shulker Box"),
	brown = S("Brown Shulker Box"),
	green = S("Lime Shulker Box"),
	dark_green = S("Green Shulker Box"),
	pink = S("Pink Shulker Box"),
	red = S("Red Shulker Box"),
	dark_grey = S("Grey Shulker Box"),
	black = S("Black Shulker Box"),
}

local shulker_mob_textures = {
	white = "mobs_mc_shulker_white.png",
	grey = "mobs_mc_shulker_silver.png",
	orange = "mobs_mc_shulker_orange.png",
	cyan = "mobs_mc_shulker_cyan.png",
	magenta = "mobs_mc_shulker_magenta.png",
	violet = "mobs_mc_shulker_purple.png",
	lightblue = "mobs_mc_shulker_light_blue.png",
	blue = "mobs_mc_shulker_blue.png",
	yellow = "mobs_mc_shulker_yellow.png",
	brown = "mobs_mc_shulker_brown.png",
	green = "mobs_mc_shulker_lime.png",
	dark_green = "mobs_mc_shulker_green.png",
	pink = "mobs_mc_shulker_pink.png",
	red = "mobs_mc_shulker_red.png",
	dark_grey = "mobs_mc_shulker_gray.png",
	black = "mobs_mc_shulker_black.png",
}
local canonical_shulker_color = "violet"

local function formspec_shulker_box(name)
	if not name or name == "" then
		name = S("Shulker Box")
	end

	return table.concat({
		"formspec_version[4]",
		"size[11.75,10.425]",

		"label[0.375,0.375;" .. F(C(mcl_formspec.label_color, name)) .. "]",
		mcl_formspec.get_itemslot_bg_v4(0.375, 0.75, 9, 3),
		"list[context;main;0.375,0.75;9,3;]",
		"label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",
		mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
		"list[current_player;main;0.375,5.1;9,3;9]",

		mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
		"list[current_player;main;0.375,9.05;9,1;]",

		"listring[context;main]",
		"listring[current_player;main]",
	})
end

local function set_shulkerbox_meta(nmeta, imeta)
	local name = imeta:get_string("name")
	nmeta:set_string("description", imeta:get_string("description"))
	nmeta:set_string("name", name)
	nmeta:set_string("formspec", formspec_shulker_box(name))
end

local shulker_tt_empty = S("27 inventory slots") .. "\n" .. S("Can be carried around with its contents")

tt.register_snippet(function(itemstring, _ , itemstack)
	if minetest.get_item_group(itemstring, "shulker_box") > 0 then
		if itemstack then
			local d = ""
			local i = 0
			local its = minetest.deserialize(itemstack:get_meta():get_string(""))
			if its then
				for _, v in ipairs(its) do
					local stack = ItemStack(v)
					if not stack:is_empty() then
						if i < shulker_num_tt_stacks then
							local newline = d ~= "" and "\n" or ""
							local item = (stack:get_short_description() or stack:get_description())
							local count = (stack:get_count() > 1 and ("x"..stack:get_count()) or "")
							d = d..newline..item.." "..count
						end
						i = i + 1
					end
				end
			end
			if d ~= "" and i - shulker_num_tt_stacks > 0 then
				d = d .. "\n "..S("and @1 more",tostring(i - shulker_num_tt_stacks))
			end
			if i > 0 then
				return d, mcl_colors.GREEN
			end
		end
		return shulker_tt_empty, mcl_colors.GREEN
	end
end)

for color, desc in pairs(boxtypes) do
	local mob_texture = shulker_mob_textures[color]
	local is_canonical = color == canonical_shulker_color
	local longdesc, usagehelp, create_entry, entry_name
	if mod_doc then
		if is_canonical then
			longdesc = S(
				"A shulker box is a portable container which provides 27 inventory slots for any item except shulker boxes. Shulker boxes keep their inventory when broken, so shulker boxes as well as their contents can be taken as a single item. Shulker boxes come in many different colors.")
			usagehelp = S(
				"To access the inventory of a shulker box, place and right-click it. To take a shulker box and its contents with you, just break and collect it, the items will not fall out. Place the shulker box again to be able to retrieve its contents.")
			entry_name = S("Shulker Box")
		else
			create_entry = false
		end
	end

	local small_name = "mcl_chests:" .. color .. "_shulker_box_small"

	minetest.register_node("mcl_chests:" .. color .. "_shulker_box", {
		description = desc,
		_doc_items_create_entry = create_entry,
		_doc_items_entry_name = entry_name,
		_doc_items_longdesc = longdesc,
		_doc_items_usagehelp = usagehelp,
		tiles = { mob_texture },
		use_texture_alpha = "opaque",
		drawtype = "mesh",
		mesh = "mcl_chests_shulker.b3d",
		groups = {
			handy = 1,
			pickaxey = 1,
			container = 3,
			deco_block = 1,
			dig_by_piston = 1,
			unsticky = 1,
			shulker_box = 1,
			old_shulker_box_node = 1
		},
		is_ground_content = false,
		sounds = mcl_sounds.node_sound_stone_defaults(),
		stack_max = 1,
		drop = "",
		paramtype = "light",
		paramtype2 = "facedir",
		on_construct = function(pos)
			local node = minetest.get_node(pos)
			node.name = small_name
			minetest.set_node(pos, node)
		end,
		after_place_node = function(pos, placer, itemstack, _)
			local nmeta = minetest.get_meta(pos)
			local imetadata = itemstack:get_meta():get_string("")
			local iinv_main = minetest.deserialize(imetadata)
			local ninv = nmeta:get_inventory()
			ninv:set_list("main", iinv_main)
			ninv:set_size("main", 9 * 3)
			set_shulkerbox_meta(nmeta, itemstack:get_meta())

			if minetest.is_creative_enabled(placer and placer:get_player_name() or "") then
				if not ninv:is_empty("main") then
					return nil
				else
					return itemstack
				end
			else
				return nil
			end
		end,
		_on_dispense = function(stack, _, droppos, dropnode, dropdir)
			-- Place shulker box as node
			local def = minetest.registered_nodes[dropnode.name]
			if def and def.buildable_to then
				minetest.set_node(droppos, { name = small_name, param2 = minetest.dir_to_facedir(dropdir) })
				local ninv = minetest.get_inventory({ type = "node", pos = droppos })
				local imetadata = stack:get_meta():get_string("")
				local iinv_main = minetest.deserialize(imetadata)
				ninv:set_list("main", iinv_main)
				ninv:set_size("main", 9 * 3)
				set_shulkerbox_meta(minetest.get_meta(droppos), stack:get_meta())
				stack:take_item()
			end
			return stack
		end,
	})
	local function get_shulker_stack(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local items = {}
		for i = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			items[i] = stack:to_string()
		end
		local data = minetest.serialize(items)
		local boxitem = ItemStack("mcl_chests:" .. color .. "_shulker_box")
		local boxitem_meta = boxitem:get_meta()
		boxitem_meta:set_string("name", meta:get_string("name"))
		boxitem_meta:set_string("", data)
		tt.reload_itemstack_description(boxitem)
		return boxitem
	end

	minetest.register_node(small_name, {
		description = desc,
		_tt_help = S("27 inventory slots") .. "\n" .. S("Can be carried around with its contents"),
		_doc_items_create_entry = create_entry,
		_doc_items_entry_name = entry_name,
		_doc_items_longdesc = longdesc,
		_doc_items_usagehelp = usagehelp,
		drawtype = animate_chests and "nodebox" or "mesh",
		mesh = not animate_chests and "mcl_chests_shulker.obj" or nil,
		tiles = animate_chests and {"blank.png"} or {mob_texture},
		use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or true,
		_chest_entity_textures = {mob_texture},
		_chest_entity_sound = "mcl_chests_shulker",
		_chest_entity_mesh = "mcl_chests_shulker",
		_chest_entity_animation_type = "shulker",
		_mcl_baseitem = get_shulker_stack,
		groups = {
			handy = 1,
			pickaxey = 1,
			container = 3,
			deco_block = 1,
			dig_by_piston = 1,
			shulker_box = 1,
			chest_entity = 1,
			not_in_creative_inventory = 1
		},
		is_ground_content = false,
		sounds = mcl_sounds.node_sound_stone_defaults(),
		stack_max = 1,
		drop = "",
		paramtype = "light",
		paramtype2 = "facedir",
		--	TODO: Make shulker boxes rotatable
		--	This doesn't work, it just destroys the inventory:
		--	on_place = minetest.rotate_node,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", formspec_shulker_box(nil))
			local inv = meta:get_inventory()
			inv:set_size("main", 9*3)
			create_entity(pos, small_name, {mob_texture}, minetest.get_node(pos).param2, false, "mcl_chests_shulker", "mcl_chests_shulker", "shulker")
		end,
		after_place_node = function(pos, placer, itemstack, _)
			if not placer or not placer:is_player() then
				return itemstack
			end

			local nmeta = minetest.get_meta(pos)
			local imetadata = itemstack:get_meta():get_string("")
			local iinv_main = minetest.deserialize(imetadata)
			local ninv = nmeta:get_inventory()
			ninv:set_list("main", iinv_main)
			ninv:set_size("main", 9 * 3)
			set_shulkerbox_meta(nmeta, itemstack:get_meta())

			if minetest.is_creative_enabled(placer:get_player_name()) then
				if not ninv:is_empty("main") then
					return nil
				else
					return itemstack
				end
			else
				return nil
			end
		end,
		on_rightclick = function(pos, node, clicker)
			player_chest_open(clicker, pos, small_name, { mob_texture }, node.param2, false, "mcl_chests_shulker",
				"mcl_chests_shulker", true)
		end,
		on_receive_fields = function(_, _, fields, sender)
			if fields.quit then
				player_chest_close(sender)
			end
		end,
		on_destruct = function(pos)
			local boxitem = get_shulker_stack(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if minetest.is_creative_enabled("") then
				if not inv:is_empty("main") then
					minetest.add_item(pos, boxitem)
				end
			else
				minetest.add_item(pos, boxitem)
			end
		end,
		allow_metadata_inventory_move = protection_check_move,
		allow_metadata_inventory_take = protection_check_put_take,
		allow_metadata_inventory_put = function(pos, _, _, stack, player)
			local name = player:get_player_name()
			if minetest.is_protected(pos, name) then
				minetest.record_protection_violation(pos, name)
				return 0
			end
			-- Do not allow to place shulker boxes into shulker boxes
			local group = minetest.get_item_group(stack:get_name(), "shulker_box")
			if group == 0 or group == nil then
				return stack:get_count()
			else
				return 0
			end
		end,
		_mcl_blast_resistance = 6,
		_mcl_hardness = 2,
	})

	if mod_doc and not is_canonical then
		doc.add_entry_alias("nodes", "mcl_chests:" .. canonical_shulker_color .. "_shulker_box", "nodes",
			"mcl_chests:" .. color .. "_shulker_box")
		doc.add_entry_alias("nodes", "mcl_chests:" .. canonical_shulker_color .. "_shulker_box_small", "nodes",
			"mcl_chests:" .. color .. "_shulker_box_small")
	end
	minetest.register_craft({
		type = "shapeless",
		output = "mcl_chests:"..color.."_shulker_box",
		recipe = { "group:shulker_box", "mcl_dyes:"..mcl_dyes.mcl2_to_color(color) }
	})
end

minetest.register_craft({
	output = "mcl_chests:violet_shulker_box",
	recipe = {
		{ "mcl_mobitems:shulker_shell" },
		{ "mcl_chests:chest" },
		{ "mcl_mobitems:shulker_shell" },
	},
})

-- Save metadata of shulker box when used in crafting
minetest.register_on_craft(function(itemstack, _, old_craft_grid, _)
	if minetest.get_item_group(itemstack:get_name(), "shulker_box") ~= 1 then
		return
	end
	local original
	for i = 1, #old_craft_grid do
		local item = old_craft_grid[i]:get_name()
		if minetest.get_item_group(item, "shulker_box") == 1 then
			original = old_craft_grid[i]
			break
		end
	end
	if original then
		local ometa = original:get_meta():to_table()
		local nmeta = itemstack:get_meta()
		nmeta:from_table(ometa)
		return itemstack
	end
end)

local function select_and_spawn_entity(pos, node)
	local node_name = node.name
	local node_def = minetest.registered_nodes[node_name]
	local double_chest = minetest.get_item_group(node_name, "double_chest") > 0
	if not animate_chests and not double_chest then
		return
	end

	find_or_create_entity(pos, node_name, node_def._chest_entity_textures, node.param2, double_chest, node_def._chest_entity_sound, node_def._chest_entity_mesh, node_def._chest_entity_animation_type)
end

minetest.register_lbm({
	label = "Spawn Chest entities",
	name = "mcl_chests:spawn_chest_entities",
	nodenames = { "group:chest_entity" },
	run_at_every_load = true,
	action = select_and_spawn_entity,
})

minetest.register_lbm({
	label = "Replace old chest nodes",
	name = "mcl_chests:replace_old",
	nodenames = { "mcl_chests:chest", "mcl_chests:trapped_chest", "mcl_chests:trapped_chest_on",
		"mcl_chests:ender_chest",
		"group:old_shulker_box_node" },
	run_at_every_load = true,
	action = function(pos, node)
		local node_name = node.name
		node.name = node_name .. "_small"
		minetest.swap_node(pos, node)
		select_and_spawn_entity(pos, node)
		if node_name == "mcl_chests:trapped_chest_on" then
			minetest.log("action", "[mcl_chests] Disabled active trapped chest on load: " .. minetest.pos_to_string(pos))
			chest_update_after_close(pos)
		elseif node_name == "mcl_chests:ender_chest" then
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", formspec_ender_chest)
		end
	end
})

minetest.register_lbm({
	-- Disable active/open trapped chests when loaded because nobody could
	-- have them open at loading time.
	-- Fixes redstone weirdness.
	label = "Disable active trapped chests",
	name = "mcl_chests:reset_trapped_chests",
	nodenames = { "mcl_chests:trapped_chest_on_small", "mcl_chests:trapped_chest_on_left",
		"mcl_chests:trapped_chest_on_right" },
	run_at_every_load = true,
	action = function(pos)
		minetest.log("action", "[mcl_chests] Disabled active trapped chest on load: " .. minetest.pos_to_string(pos))
		chest_update_after_close(pos)
	end,
})

minetest.register_lbm({
	label = "Update shulker box formspecs (0.72.0)",
	name = "mcl_chests:update_shulker_box_formspecs_0_72_0",
	nodenames = { "group:shulker_box" },
	run_at_every_load = false,
	action = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec_shulker_box(meta:get_string("name")))
	end,
})

minetest.register_lbm({
	label = "Upgrade old ender chest formspec",
	name = "mcl_chests:replace_old_ender_form",
	nodenames = { "mcl_chests:ender_chest_small" },
	run_at_every_load = false,
	action = function(pos)
		minetest.get_meta(pos):set_string("formspec", "")
	end,
})
