local modname = "arkacia"
local S = minetest.get_translator(modname)

local hud_elem_type_field = "type"
if not minetest.features.hud_def_type_field then
	hud_elem_type_field = "hud_elem_type"
end

local hud_totem = {}

mcl_util._arkacia_mlg_totem_init = mcl_util._arkacia_mlg_totem_init or false
if not mcl_util._arkacia_mlg_totem_init then
	mcl_util._arkacia_mlg_totem_init = true
	minetest.register_on_leaveplayer(function(player)
		hud_totem[player] = nil
	end)

	minetest.register_craftitem(":" .. modname .. ":mlg_totem", {
		description = S("MLG TOTEM"),
		inventory_image = "bucket_water.png",
		wield_image = "bucket_water.png",
		stack_max = 1,
		groups = {combat_item = 1, offhand_item = 1},
		_mcl_wieldview_item = modname .. ":mlg_totem_wielded",
	})

	minetest.register_craftitem(":" .. modname .. ":mlg_totem_wielded", {
		inventory_image = "bucket_water.png",
		wield_image = "bucket_water.png",
		groups = { dig_immediate = 3, not_in_creative_inventory = 1, },
		stack_max = 1,
	})

	local particle_colors = {"98BF22", "C49E09", "337D0B", "B0B021", "1E9200"}

	mcl_damage.register_modifier(function(obj, damage, reason)
		if obj:is_player() and not reason.flags.bypasses_totem then
			local hp = obj:get_hp()
			if hp - damage <= 0 then
				local wield = obj:get_wielded_item()
				local in_offhand = false
				if wield:get_name() ~= modname .. ":mlg_totem" then
					local inv = obj:get_inventory()
					if inv then
						wield = obj:get_inventory():get_stack("offhand", 1)
						in_offhand = true
					end
				end
				if wield:get_name() == modname .. ":mlg_totem" then
					local ppos = obj:get_pos()

					if obj:get_breath() < 11 then
						obj:set_breath(10)
					end

					if not minetest.is_creative_enabled(obj:get_player_name()) then
						wield:take_item()
						if in_offhand then
							obj:get_inventory():set_stack("offhand", 1, wield)
							mcl_inventory.update_inventory_formspec(obj)
						else
							obj:set_wielded_item(wield)
						end
					end

					 
					minetest.sound_play({name = "mcl_totems_totem", gain = 1}, {pos=ppos, max_hear_distance = 16}, true)

					for i = 1, 4 do
						for c = 1, #particle_colors do
							minetest.add_particlespawner({
									amount = math.floor(100 / (4 * #particle_colors)),
									time = 1,
									minpos = vector.offset(ppos, 0, -1, 0),
									maxpos = vector.offset(ppos, 0, 1, 0),
									minvel = vector.new(-1.5, 0, -1.5),
									maxvel = vector.new(1.5, 1.5, 1.5),
									minacc = vector.new(0, -0.1, 0),
									maxacc = vector.new(0, -1, 0),
									minexptime = 1,
									maxexptime = 3,
									minsize = 1,
									maxsize = 2,
									collisiondetection = true,
									collision_removal = true,
									object_collision = false,
									vertical = false,
									texture = "mcl_particles_totem" .. i .. ".png^[colorize:#" .. particle_colors[c],
									glow = 10,
								})
						end
					end

					 
					if not hud_totem[obj] then
						hud_totem[obj] = obj:hud_add({
							[hud_elem_type_field] = "image",
							text = "bucket_water.png",
							position = {x = 0.5, y = 1},
							scale = {x = 17, y = 17},
							offset = {x = 0, y = -178},
							z_index = 100,
						})
						minetest.after(3, function()
							if obj:is_player() then
								obj:hud_remove(hud_totem[obj])
								hud_totem[obj] = nil
							end
						end)
					end

					 
					return hp - 1
				end
			end
		end
	end, 1000)
end