local places = {
    {name = "scp", title = "the SCP facility", pos = vector.new(1017, -54.5, -1481)},
    {name = "divground", title = "the City of Divergent on the ground", pos = vector.new(11072,-103,-8896)},
    {name = "div", title = "the City of Divergent in the sky", pos = vector.new(10997,10049,-8877)},
    {name = "divergent", title = "the City of Divergent in the sky", pos = vector.new(10997,10049,-8877)},
}
for _, place in ipairs(places) do
    minetest.register_chatcommand(place.name, {
        description = "Teleport to " .. place.title .. ".",
        privs = {
            interact = true,
        },
        func = function(name, param)
            if (param ~= "") then
                if (minetest.check_player_privs(name, "bring")) then
                    if (minetest.get_player_by_name(param) and name) then
                        name = param
                    else
                        minetest.chat_send_player(name, "\"" .. param .. "\" isn't online or doesn't exist.")
                        return
                    end
                else
                    minetest.chat_send_player(name, "You don't have permission to run this command (missing privileges: bring).")
                    return
                end
            end
            minetest.get_player_by_name(name):setpos(place.pos)
            minetest.chat_send_player(name, "Teleporting to " .. place.title .. "...")
        end
    })
end
