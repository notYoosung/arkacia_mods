
--[[
https://rubenwardy.com/minetest_modding_book/en/map/environment.html#finding-nodes
https://github.com/Beanzilla/OreTracker
]]


auhud = {}

auhud.store = {}
auhud.p_stats = {}


-- minetest.log("action", "[oretracker-auhud] Detected game "..auhud.gamemode..".")

-- Form a container to track what ores we want to follow
auhud.ores = {}





minetest.register_on_joinplayer(function(player, laston)
    auhud.p_stats[player:get_player_name()] = nil
end)

minetest.register_on_leaveplayer(function(player, timeout)
    local indx = 0
    local found = false
    for pname, val in ipairs(auhud.p_stats) do
        if pname == player:get_player_name() then
            found = true
            break
        end
        indx = indx + 1
    end
    if found then
        player:hud_remove(auhud.p_stats(auhud.p_stats[player:get_player_name()]))
        table.remove(auhud.p_stats, indx)
    end
end)

-- A priv for those to use this power
minetest.register_privilege("auhud", {
    description = "Oretracker auhud Priv",
    give_to_singleplayer = true -- Also given to those with server priv
})

minetest.register_chatcommand("auhud", {
    privs = {
        shout = true,
        auhud = true -- Require our own priv
    },
    func = function(name, param)
        if auhud.p_stats[name] then
            local p = minetest.get_player_by_name(name)
            if p ~= nil then
                p:hud_remove(auhud.p_stats[name])
                auhud.p_stats[name] = nil
            end
        else
            local p = minetest.get_player_by_name(name)
            if p ~= nil then
                auhud.p_stats[name] = p:hud_add({
                    hud_elem_type = "text",
                    position = {x = 0.9, y = 0.87},
                    offset = {x = 0.0, y = 0.0},
                    text = "auhud",
                    number = 0x00e100, -- 0, 225, 0 (RGB)
                    alignment = {x = 0.0, y = 0.0},
                    scale = {x = 100.0, y = 100.0}
                })
            end
        end
    end,
})



-- Adds a waypoint to the given player's HUD, given title and color
auhud.add_pos = function(pname, player, pos, title, color)
    if not title then
        title = minetest.pos_to_string(pos)
    end
    local wps = auhud.store[pname] or {}
    if not color then
        color = 0xffffff
    end
    table.insert(wps,
        player:hud_add({
            hud_elem_type = "waypoint",
            name = title,
            text = "m",
            number = color,
            world_pos = pos
        })
    )
    auhud.store[pname] = wps
end

-- Clears all waypoints from the given player's HUD
auhud.clear_pos = function(pname, player)
    local wps = auhud.store[pname] or {}
    for i, v in ipairs(wps) do
        player:hud_remove(v)
    end
    auhud.store[pname] = {}
end











local pos_list = {
    { name = "Cafeteria", title = "Caf", pos = vector.new(0, 0, 0), color = 0xffffff },
    { name = "", title = "", pos = vector.new(0, 0, 0), color = 0xffffff },
}

local function toggle_hud(pname, player)
    local wps = auhud.store[pname] or {}
    if #wps == 0 then
        for _, v in ipairs(pos_list) do
            auhud.add_pos(pname, player, v.pos, v.title, v.color)
        end
    else
        auhud.clear_pos(pname, player)
    end
end
local function tool_hud_primary(itemstack, player, pointed_thing)
    local pname = player:get_player_name()
    local wps = auhud.store[pname] or {}
    if #wps == 0 then
    else
        for _, v in ipairs(pos_list) do
            auhud.add_pos(pname, player, v.pos, v.name, v.color)
        end
    end
end
local function tool_hud_secondary(itemstack, player, pointed_thing)
    local pname = player:get_player_name()
    toggle_hud(pname, player)

end
minetest.register_craftitem("among_us:tool_hud", {
    description = "HUD Tool\nLeft click to change waypoint format.\nRight click to turn waypoints on/off.",
    inventory_image = nil,
    groups = {},
    on_use = tool_hud_primary,
    on_secondary_use = tool_hud_secondary,
    on_place = tool_hud_secondary,
})


