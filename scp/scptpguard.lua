local pos = vector.new(975, -13.5, -1534);
local player = minetest.get_player_by_name("@n")
local pos = pos
player:set_pos(pos)
minetest.chat_send_player(player.get_player_name(player), ("New respawn position set at guard room!"))
mcl_spawn.set_spawn_pos(player, vector.add(pos, vector.new(0, 1, 0)), nil)
