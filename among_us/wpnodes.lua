auhud = auhud or {}

auhud.players = {}

minetest.register_node(":arkacia_among_us:waypoint_node", {
    description = "Waypoint Node",
    groups = {},

})



local function add_wp(player, data)
    local pname = player:get_player_name()
    if not auhud.players[pname] then
        auhud.players[pname] = {}
    end
    auhud.players[pname][data.id] = player:hud_add({
        hud_elem_type = "waypoint",
        name = data.title or "",
        text = data.id or "m",
        number = data.color or 0xffffff,
        world_pos = data.pos or vector.new(0, 0, 0),
        precision = (data.precision ~= nil) and data.precision or 1,
    })
end
local function remove_wp(player, id)
    local pname = player:get_player_name()
    local player_data = auhud.players[pname]
    if player_data and auhud.players[pname][id] then
        safe_hud_remove(player, auhud.players[pname][id])
        auhud.players[pname][id] = nil
    end
end




if not mcl_util._arkacia_among_us_init then
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "arkacia_among_us:waypoint_node_confirm_break" and fields["break"] then
            pcall(function()
                local pname = player:get_player_name()
                local indx = ""
                for ifields, _fields in pairs(fields) do
                    if ifields:find("%(") then
                        indx = ifields
                        break
                    end
                end

                if indx then
                    local pos = minetest.string_to_pos(indx)
                    if pos then
                        if minetest.is_protected(pos, pname) then
                            minetest.record_protection_violation(pos, pname)
                        else
                            local ns = auhud.node_storage[tostring(pos)]
                            if ns ~= nil then
                                for nspname, v in pairs(ns) do
                                    local nsplayer = minetest.get_player_by_name(nspname)
                                    if nsplayer then
                                        safe_hud_remove(nsplayer, v.hud_id)
                                    end
                                end
                            end
                            auhud.node_storage[tostring(pos)] = nil
                            minetest.remove_node(pos)
                        end
                    end
                end
            end)
        end
    end)
end







if not mcl_util._arkacia_among_us_init then
    mcl_util._arkacia_among_us_init = true
end
