local pos1 = vector.new(1038, -13.5, -1545);
local pos_list = {}
for z = 0, 1 do for x = 0, 4 do
    table.insert(pos_list,
        { x = pos1.x + x * 4, y = pos1.y, z = pos1.z - z * 23 })
    end
end
local player = minetest.get_player_by_name("@n")
local pos = pos_list[math.random(#pos_list)]
player:set_pos(pos)
minetest.chat_send_player(player.get_player_name(player), ("New respawn position set at Class-D cell!"))
mcl_spawn.set_spawn_pos(player, vector.add(pos, vector.new(0, 1, 0)), nil)
