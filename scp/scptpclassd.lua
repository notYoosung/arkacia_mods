local pos1 = vector.new(1038, -13.5, -1545);
local pos = {}
for z = 0, 1 do for x = 0, 4 do
    table.insert(pos,
        { x = pos1.x + x * 4, y = pos1.y, z = pos1.z - z * 23 })
    end
end
minetest.get_player_by_name("@n"):set_pos(pos[math.random(#pos)])
