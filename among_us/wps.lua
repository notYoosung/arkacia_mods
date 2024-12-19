--[[
https://rubenwardy.com/minetest_modding_book/en/map/environment.html#finding-nodes
https://github.com/Beanzilla/OreTracker
]]

mcl_util._arkacia_among_us_init = mcl_util._arkacia_among_us_init or false

if not vector.random_direction then
    function vector.random_direction()
        local x, y, z, l2
        repeat
            x, y, z = math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1
            l2 = x * x + y * y + z * z
        until l2 <= 1 and l2 >= 1e-6
        local l = math.sqrt(l2)
        return vector.new(x / l, y / l, z / l)
    end
end

auhud = auhud or {}

auhud.store = auhud.store or {}
auhud.p_stats = auhud.p_stats or {}
auhud.node_store = auhud.node_store or {}




auhud.players = {}






auhud.ores = auhud.ores or {}



local function safe_hud_remove(player, id)
    pcall(function()
        local pname = player:get_player_name()
        if player and id and player:get_hud(id) then
            player:hud_remove(id)
        end
        auhud.players[pname] = {}
    end)
end

minetest.register_on_joinplayer(function(player, laston)
    auhud.p_stats[player:get_player_name()] = nil
end)


minetest.register_on_leaveplayer(function(player, timeout)
    local pname = player:get_player_name()
    local indx = 0
    local found = false
    for p_stats_pname, val in ipairs(auhud.p_stats) do
        if p_stats_pname == pname then
            found = true
            break
        end
        indx = indx + 1
    end
    if found then
        safe_hud_remove(player, auhud.p_stats(auhud.p_stats[player:get_player_name()]))
        table.remove(auhud.p_stats, indx)
    end
    if auhud.players[pname] then
        auhud.players[pname] = nil
    end
end)

minetest.register_privilege("auhud", {
    description = "Oretracker auhud Priv",
    give_to_singleplayer = true
})

minetest.register_chatcommand("auhud", {
    privs = {
        shout = true,
        auhud = true
    },
    func = function(name, param)
        if auhud.p_stats[name] then
            local p = minetest.get_player_by_name(name)
            if p ~= nil then
                safe_hud_remove(p, auhud.p_stats[name])
                auhud.p_stats[name] = nil
            end
        else
            local p = minetest.get_player_by_name(name)
            if p ~= nil then
                auhud.p_stats[name] = p:hud_add({
                    type = "text",
                    position = { x = 0.9, y = 0.87 },
                    offset = { x = 0.0, y = 0.0 },
                    text = "auhud",
                    number = 0x00e100,
                    alignment = { x = 0.0, y = 0.0 },
                    scale = { x = 100.0, y = 100.0 }
                })
            end
        end
    end,
})



auhud.add_pos = function(pname, player, pos, title, color, precision, id)
    if not title then
        title = "" --[[minetest.pos_to_string(pos)]]
    end
    local wps = auhud.store[pname] or {}
    if not color then
        color = 0xffffff
    end
    if precision == nil then
        precision = 1
    end
    local elem_id = player:hud_add({
        hud_elem_type = "waypoint",
        name = title,
        text = id or "m",
        number = color,
        world_pos = pos,
        precision = math.abs(precision),
    })
    table.insert(wps, elem_id)
    auhud.store[pname] = wps
    return elem_id
end

auhud.clear_pos = function(pname, player)
    local wps = auhud.store[pname] or {}
    for i, v in ipairs(wps) do
        safe_hud_remove(player, v)
    end
    auhud.store[pname] = {}
end








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


auhud.pos_list = auhud.pos_list or {
    { name = "Cafeteria", title = "Caf", pos = vector.new(0, 0, 0), color = 0xffffff },
    --[[{ name = "", title = "", pos = vector.new(0, 0, 0), color = 0xffffff },]]
}
auhud.node_storage = auhud.node_storage or {}

local function toggle_hud(pname, player)
    local wps = auhud.store[pname] or {}
    if #wps == 0 then
        for _, v in ipairs(auhud.pos_list) do
            auhud.add_pos(pname, player, v.pos, v.title, v.color, v.precision)
        end
        minetest.chat_send_player(pname, "All waypoints shown!")
    else
        auhud.clear_pos(pname, player)
        minetest.chat_send_player(pname, "All waypoints hidden!")
    end
end
local function tool_hud_primary(itemstack, player, pointed_thing)
    --[[local pname = player:get_player_name()
    local wps = auhud.store[pname] or {}
    if #wps == 0 then
        for _, v in ipairs(pos_list) do
            auhud.add_pos(pname, player, v.pos, v.name, v.color)
        end
    else
    end]]
end
local function tool_hud_secondary(itemstack, player, pointed_thing)
    local pname = player:get_player_name()
    toggle_hud(pname, player)
end
minetest.register_craftitem(":arkacia_among_us:tool_hud", {
    description = "HUD Tool\nRight-click to turn waypoints on/off\n[EXPERIMENTAL/FOR TESTING]",
    groups = {},
    on_use = tool_hud_primary,
    on_secondary_use = tool_hud_secondary,
    on_place = tool_hud_secondary,
})


local function update_waypoint_node(pos)
    local meta = minetest.get_meta(pos)
    local data = minetest.deserialize(meta:get_string("arkacia_among_us:data")) or {}
    local wpdata = {
        name = data.name or "",
        title = data.title or data.name or "",
        pos = vector.offset(pos, tonumber(data.offsetx or 0), tonumber(data.offsety or 0), tonumber(data.offsetz or 0)),
        color = data.color ~= nil and tonumber(data.color, 16) or 0xfff,
        precision = data.precision
    }
    wpdata.id = tostring(pos)
    local has_id = false
    local id_indx
    for ipos, vpos in pairs(auhud.pos_list) do
        if vpos.id == wpdata.id then
            has_id = true
            auhud.pos_list[ipos] = wpdata
            id_indx = ipos
            break
        end
    end
    if not has_id then
        table.insert(auhud.pos_list, wpdata)
        id_indx = #table
    end

    if id_indx then
        data.id_indx = id_indx
        local storage = auhud.node_storage[tostring(pos)] or {}

        for player, _ in mcl_util.connected_players(pos, 128) do
            if player then
                local pname = player:get_player_name()
                local pstorage = storage[pname] or {}
                if pstorage.hud_id == nil then
                    pstorage.hud_id = auhud.add_pos(player:get_player_name(), player, wpdata.pos, wpdata.name, wpdata.color, math.abs(wpdata.precision or 0))
                else
                    player:hud_change(pstorage.hud_id, "name", wpdata.name)
                    player:hud_change(pstorage.hud_id, "number", wpdata.color)
                    player:hud_change(pstorage.hud_id, "world_pos", wpdata.pos)
                    player:hud_change(pstorage.hud_id, "precision", wpdata.precision or 1)
                end
                storage[pname] = pstorage
            end
        end

        auhud.node_storage[tostring(pos)] = storage
    end
    local serdata = minetest.serialize(data)
    meta:set_string("arkacia_among_us:data", serdata)
end


local function update_waypoint_node_fs(pos, player)
    local meta = minetest.get_meta(pos)
    local datastring = meta:get_string("arkacia_among_us:data")
    local data = minetest.deserialize(datastring) or {}
    local pnum = data.precision ~= 0 and math.log(data.precision or 10, 10) or 0

    local fs = table.concat({
        "formspec_version[6]",
        "size[9,10]",
        "label[       4.00,0.375;Waypoint Node]",

        "label[        0.375,1.0;Name]",
        "field[      0.375,1.175; 8.25,0.5;name;;" .. (data.name or "") .. "]",

        "label[      0.375,2;Pos Offset]",
        "field[       0.37,2.275; 2.75,0.5;offsetx;X;" .. (data.offsetx or 0) .. "]",
        "field[       3.12,2.275; 2.75,0.5;offsety;Y;" .. (data.offsety or 0) .. "]",
        "field[       5.87,2.275; 2.75,0.5;offsetz;Z;" .. (data.offsetz or 0) .. "]",

        "label[        0.375,3.0;Color (HEX) (#ffffff or ffffff)]",
        "field[      0.375,3.175; 8.25,0.5;color;;#" .. (data.color or "ffffff") .. "]",

        "label[        0.375,4.0;Distance Decimal Precision (0 to disable)]",
        "field[      0.375,4.175; 8.25,0.5;precision;;" .. (pnum or "0") .. "]",

        "button_exit[0.375,8.675; 4,1;save;Save]",
        "button_exit[4.375,8.675; 4,1;cancel;Cancel]",
    }, "")
    meta:set_string("formspec", fs)
end
minetest.register_node(":arkacia_among_us:waypoint_node", {
    description = "Waypoint Node",
    groups = {},
    after_place_node = function(pos, placer)
        update_waypoint_node_fs(pos, placer)
        update_waypoint_node(pos)
    end,
    on_construct = function(pos)
        --[[minetest.get_node_timer(pos):start(10)]]
        auhud.node_storage[tostring(pos)] = {}
    end,
    on_timer = function(pos)
        --[[local timer = minetest.get_node_timer(pos)
        timer:start(10)
        update_waypoint_node(pos)
        return true]]
    end,
    on_punch = function(pos, node, puncher, pointed_thing)
        if puncher then
            local pname = puncher:get_player_name()
            if minetest.is_protected(pos, pname) then
                minetest.record_protection_violation(pos, pname)
            else
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
    end,
    on_receive_fields = function(pos, formname, fields, player)
        update_waypoint_node_fs(pos, player)
        local pname = player:get_player_name()
        if minetest.is_protected(pos, pname) then
            return
        end

        if fields.save then

        end

        if fields.save then
            local meta = minetest.get_meta(pos)
            datastring = meta:get_string("arkacia_among_us:data")
            local data = minetest.deserialize(datastring) or {}
            data.name = fields.name
            data.title = fields.name
            data.offsetx = tonumber(fields.offsetx) or 0
            data.offsety = tonumber(fields.offsety) or 0
            data.offsetz = tonumber(fields.offsetz) or 0
            local pnum = fields.precision and tonumber(fields.precision) or 0
            data.precision = pnum ~= 0 and math.pow(10, pnum) or 0
            data.color = fields.color and fields.color:gsub("#", "") or "ffffff"
            meta:set_string("arkacia_among_us:data", minetest.serialize(data))
            update_waypoint_node(pos)
            update_waypoint_node_fs(pos, player)
        end
    end,
})

if not mcl_util._arkacia_among_us_init then
    minetest.register_lbm({
        name = ":arkacia_among_us:update_waypoint_nodes",
        nodenames = {
            "arkacia_among_us:waypoint_node",
        },
        run_at_every_load = true,
        action = function(pos)
            update_waypoint_node(pos)
            update_waypoint_node_fs(pos)
        end,
    })
    mcl_player.register_globalstep_slow(function(player, dtime)
        local pname = player:get_player_name()
        local ppos = player:get_pos()
        minetest.log("gs")
        for node_pos_str, pdata in pairs(auhud.node_storage) do
            if pdata then
                local pos = minetest.string_to_pos(node_pos_str)
                if pos and ppos then
                    if (pos.x - ppos.x) * (pos.x - ppos.x) + (pos.y - ppos.y) * (pos.y - ppos.y) + (pos.z - ppos.z) * (pos.z - ppos.z) > 256 * 256 then
                        local ns = pdata[pname]
                        if ns then
                            safe_hud_remove(player, ns.hud_id)
                            auhud.node_storage[node_pos_str][pname] = nil
                        end
                    else
                        update_waypoint_node(pos)
                    end
                end
            end
        end
    end)
    minetest.log("globalsteps: " .. #mcl_player.registered_globalsteps_slow)
end


local function tool_wps_primary(itemstack, player, pointed_thing)
end
local buttonheight = 0.25
for iwps = 0, 100 do
    table.insert(auhud.pos_list, { name = iwps, title = iwps, pos = vector.multiply(vector.random_direction(), math.random() * 1000), color = math.random(0x000, 0xffffff) })
end
local function tool_wps_secondary(itemstack, player, pointed_thing)
    local pname = player:get_player_name()
    local buttons = {}
    for ibutton = 0, 100 do
        table.insert(buttons, "button[1," .. tostring(ibutton * buttonheight) .. ";3," .. buttonheight .. ";waypoint_selection_button_" .. tostring(ibutton) .. ";" .. tostring(ibutton) .. "]")
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
    description = "Waypoint Tool\nRight-click to manage waypoint visibility\n[EXPERIMENTAL/FOR TESTING]",
    groups = {},
    on_use = tool_wps_primary,
    on_secondary_use = tool_wps_secondary,
    on_place = tool_wps_secondary,
})



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
        elseif formname == "arkacia_among_us:waypoint_tool_selection" then
            local pname = player:get_player_name()
            local player_wps = auhud.store[pname] or {}
            local active_wp_names = {}
            for _, hud_id in ipairs(player_wps) do
                local hud = player:hud_get(hud_id)
                if hud then
                    active_wp_names[hud.name] = hud_id
                end
            end
            for ifields, _fields in pairs(fields) do
                if ifields == "toggle" then
                    toggle_hud(pname, player)
                end
                if ifields:find("waypoint_selection_button_") then
                    local wpid = ifields:gsub("^waypoint_selection_button_", "")
                    for _, v in ipairs(auhud.pos_list) do
                        local vname = tostring(v.name)
                        if vname == wpid then
                            if active_wp_names[vname] == nil or active_wp_names[vname] == false then
                                auhud.add_pos(pname, player, v.pos, v.title, v.color, v.precision)
                            else
                                local remove_indx
                                for ihud_id, hud_id in ipairs(player_wps) do
                                    local hud_elem = player:hud_get(hud_id)
                                    if hud_elem and hud_elem.name == vname then
                                        remove_indx = ihud_id
                                        break
                                    end
                                end
                                if remove_indx and player_wps[remove_indx] then
                                    safe_hud_remove(player, player_wps[remove_indx])
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

minetest.register_tool(":arkaica_among_us:debug_tool", {
    description = "Debug Tool\n[EXPERIMENTAL/FOR TESTING]",
    on_use = function()
        minetest.chat_send_all("[HUD Debug Tool] auhud.node_store: " .. dump(auhud.node_store))
        minetest.chat_send_all("[HUD Debug Tool] auhud.players: " .. dump(auhud.players))
        minetest.chat_send_all("[HUD Debug Tool] auhud.store: " .. dump(auhud.store))
        minetest.chat_send_all("[HUD Debug Tool] auhud.p_stats: " .. dump(auhud.p_stats))
    end
})



if not mcl_util._arkacia_among_us_init then
    mcl_util._arkacia_among_us_init = true
end
