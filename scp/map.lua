--[[minetest.register_craftitem("bear:id_card", {
    description = "ID Card",
    texture = "",
})

minetest.register_craftitem(":bear:id_card", {description = "ID Card", texture = "mcl_maps_map_texture_0.tga",})


local item = core.get_player_by_name("singleplayer"):get_wielded_item() local match = string.match(item.texture, "mcl_maps_map_texture_(.*)\\.tga") if match then minetest.chat_send_all(match) end

meta:set_string("mcl_maps:id", id)


local player = core.get_player_by_name("@n") local item = player:get_wielded_item() local id =  tostring(item:get_meta():get_string("mcl_maps:id")) local meta = minetest.get_meta(vector.new(1001, -14, -1590)) meta:set_string("commands", id) minetest.chat_send_player("@n", id)
local player = core.get_player_by_name("@n") local item = player:get_wielded_item() local itemmeta = item:get_meta() local nodemeta = minetest.get_meta(vector.new(1001, -14, -1590)) itemmeta:set_string("mcl_maps:id", nodemeta:get_string("commands"))    player:get_inventory():set_stack("main", player:get_wield_index(), item) itemmeta:set_string("mcl_maps:minp", minetest.pos_to_string(vector.zero())) itemmeta:set_string("mcl_maps:maxp", minetest.pos_to_string(vector.zero()))
]]







mcl_player.register_globalstep(function(player)
	local wield = player:get_wielded_item()
	local texture = mcl_maps.load_map_item(wield)
	local hud = huds[player]
	if texture then
		local wield_def = wield:get_definition()
		local hand_def = player:get_inventory():get_stack("hand", 1):get_definition()

		if hand_def and wield_def and hand_def._mcl_hand_id ~= wield_def._mcl_hand_id then
			wield:set_name("mcl_maps:filled_map_" .. hand_def._mcl_hand_id)
			player:set_wielded_item(wield)
		end

		if texture ~= maps[player] then
			player:hud_change(hud.map, "text", "[combine:140x140:0,0=mcl_maps_map_background.png:6,6=" .. texture)
			maps[player] = texture
		end

		local pos = vector.round(player:get_pos())
		local meta = wield:get_meta()
		local minp = minetest.string_to_pos(meta:get_string("mcl_maps:minp"))
		local maxp = minetest.string_to_pos(meta:get_string("mcl_maps:maxp"))
		if minp and maxp then
			local marker = "mcl_maps_player_arrow.png"

			if pos.x < minp.x then
				marker = "mcl_maps_player_dot.png"
				pos.x = minp.x
			elseif pos.x > maxp.x then
				marker = "mcl_maps_player_dot.png"
				pos.x = maxp.x
			end

			if pos.z < minp.z then
				marker = "mcl_maps_player_dot.png"
				pos.z = minp.z
			elseif pos.z > maxp.z then
				marker = "mcl_maps_player_dot.png"
				pos.z = maxp.z
			end
			
			if marker == "mcl_maps_player_arrow.png" then
				local yaw = (math.floor(player:get_look_horizontal() * 180 / math.pi / 90 + 0.5) % 4) * 90
				marker = marker .. "^[transformR" .. yaw
			end
			
			player:hud_change(hud.marker, "text", marker)
			player:hud_change(hud.marker, "offset", { x = (6 - 140 / 2 + pos.x - minp.x) * 2, y = (6 - 140 + maxp.z - pos.z) * 2 })
		end
	elseif maps[player] then
		player:hud_change(hud.map, "text", "blank.png")
		player:hud_change(hud.marker, "text", "blank.png")
		maps[player] = nil
	end
end)
