
--[[
https://rubenwardy.com/minetest_modding_book/en/map/environment.html#finding-nodes
https://github.com/Beanzilla/OreTracker
]]

mcl_util._arkacia_among_us_init = mcl_util._arkacia_among_us_init or false


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
        title = ""--minetest.pos_to_string(pos)
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
    -- { name = "", title = "", pos = vector.new(0, 0, 0), color = 0xffffff },
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
minetest.register_craftitem(":arkacia_among_us:tool_hud", {
    description = "HUD Tool\nLeft click to change waypoint format.\nRight click to turn waypoints on/off.",
    groups = {},
    on_use = tool_hud_primary,
    on_secondary_use = tool_hud_secondary,
    on_place = tool_hud_secondary,
})

minetest.register_node(":arkacia_among_us:waypoint_node", {
    description = "Waypoint Node",
    groups = { },
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(10)
    end,
    on_timer = function(pos)
        local meta = minetest.get_meta(pos)
        local data = minetest.deserialize(meta:get_string("arkacia_among_us:data")) or {}
        for _, player in mcl_util.connected_players(pos, 128) do
            if player then
                local pname = player:get_player_name()
                local pmeta = player:get_meta()
                local pdata = pmeta:get_string("arkacia_among_us:data")
                if pdata ~= "" then
                    pdata = minetest.deserialize(pdata) or {}
                    local pwps = pdata.arkacia_among_us_wps or {}
                    if pwps[pdata.name] then
                        minetest.log()
                    end
                end
            end
        end
        local serdata = minetest.serialize(data)
        meta:set_string("arkacia_among_us:data", serdata)
        return true
    end,
    on_punch = function(pos, node, puncher, pointed_thing)
        if puncher then
            local pname = puncher:get_player_name()
            if minetest.is_protected(pos, pname) then
                minetest.record_protection_violation(pos, pname)
            else
                -- show a minetest formspec confirming whether to break the block or not
                local formspec = table.concat({
                    "formspec_version[3]",
                    "size[7,4]",
                    "label[0.375,0.375;Are you sure you want to break this block?]",
                    "button_exit[1,1;5,1;break;Break]",
                    "button_exit[1,2;5,1;cancel;Cancel]",
                    "textarea[0,0;0,0;", minetest.pos_to_string(pos), ";;]",
                }, "")
                minetest.show_formspec(pname, "arkacia_among_us:waypoint_node_confirm_break", formspec)
            end
        end
    end
})



local function tool_wps_primary(itemstack, player, pointed_thing)
end
--scroll_container[<X>,<Y>;<W>,<H>;<scrollbar name>;<orientation>;<scroll factor>;<content padding>]
local buttonheight = 0.25
for iwps = 0, 100 do
    table.insert(pos_list, { name = iwps, title = iwps, pos = vector.multiply(vector.random_direction(), 100), color = math.random(0x000, 0xffffff) })
end
local function tool_wps_secondary(itemstack, player, pointed_thing)
    -- show formspec listing among us task locations with buttons to toggle waypoint visibility
    local pname = player:get_player_name()
    local buttons = {}
    for ibutton = 0, 100 do
        table.insert(buttons, "button[1," .. tostring(ibutton * buttonheight) .. ";3," .. buttonheight  .. ";waypoint_selection_button_" .. tostring(ibutton) .. ";" .. tostring(ibutton) .. "]")
    end
    local buttonsstr = table.concat(buttons, "")
    local formspec = table.concat({
        "formspec_version[6]",
        "size[7,11]",
        "label[0.375,0.375;Waypoint Visibility]",
        "button_exit[1,1;5,1;toggle;Toggle]",
        "button_exit[1,2;5,1;cancel;Cancel]",
        "scrollbaroptions[arrows=show;thumbsize=1;max=1000;smallstep=2.5;largestep=25]",
        "scrollbar[5,4;0.25,6;vertical;sb;0]",
        "scroll_container[0.5,4;6,6;sb;vertical]",
        buttonsstr,
        "scroll_container_end[]",
    }, "")
    minetest.show_formspec(pname, "arkacia_among_us:waypoint_tool_selection", formspec)

end
minetest.register_craftitem(":arkacia_among_us:tool_wps", {
    description = "Waypoint Tool",
    groups = {},
    on_use = tool_wps_primary,
    on_secondary_use = tool_wps_secondary,
    on_place = tool_wps_secondary,
})



if not mcl_util._arkacia_among_us_init then
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "arkacia_among_us:waypoint_node_confirm_break" and fields["break"] then
            local pname = player:get_player_name()
            minetest.log(minetest.serialize(fields))
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
                        minetest.remove_node(pos)
                    end
                end
            end
        end
        if formname == "arkacia_among_us:waypoint_tool_selection" then
            local pname = player:get_player_name()
            
            -- minetest.log(minetest.serialize(fields))
            local player_wps = auhud.store[pname] or {}
            local active_wp_names = {}
            for _, hud_id in ipairs(player_wps) do
                local hud = player:hud_get(hud_id)
                if hud then
                    active_wp_names[hud.name] = hud_id
                end
            end
            minetest.log("player_wps: " .. minetest.serialize(player_wps))
            minetest.log("active_wp_names: " .. minetest.serialize(active_wp_names))
            for ifields, _fields in pairs(fields) do
                if ifields:find("waypoint_selection_button_") then
                    local wpid = ifields:gsub("^waypoint_selection_button_", "")
                    minetest.log("[arkacia_among_us] " .. pname .. " selected waypoint " .. wpid .. ".")
                    for _, v in ipairs(pos_list) do
                        if tostring(v.name) == wpid then
                            minetest.log("v.name: " .. tostring(v.name))
                            minetest.log("wpid: " .. wpid)
                            minetest.log("active_wp_names[tostring(v.name)]: " .. tostring(active_wp_names[tostring(v.name)]))
                            if active_wp_names[tostring(v.name)] == nil or active_wp_names[tostring(v.name)] == false then
                                auhud.add_pos(pname, player, v.pos, v.title, v.color)
                            else
                                local remove_indx
                                for _, hud_id in ipairs(player_wps) do
                                    if player:hud_get(hud_id).name == v.name then
                                        remove_indx = hud_id
                                        break
                                    end
                                end
                                if remove_indx then
                                    minetest.log("remove_indx: " .. remove_indx)
                                    player:hud_remove(player_wps[remove_indx])
                                end
                            end
                        end
                    end
                end
            end
            
        end
    end)
end



if not mcl_util._arkacia_among_us_init then
    mcl_util._arkacia_among_us_init = true
end

