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

auhud.players = {}
auhud.node_storage = {}



local function safe_hud_remove(player, id)
    local pname = player:get_player_name()
    if player and id and player:hud_get(id) then
        player:hud_remove(id)
    end
    --[[auhud.players[pname] = {}]]
end

minetest.register_on_joinplayer(function(player, laston)
    local pname = player:get_player_name()
    auhud.players[pname] = {}
end)


minetest.register_on_leaveplayer(function(player, timeout)
    local pname = player:get_player_name()
    if auhud.players[pname] then
        auhud.players[pname] = nil
    end
end)


local function safe_to_number(n, default, base)
    if base == nil then
        base = 10
    end
    if n ~= nil then
        local tn = tonumber(n, base)
        if tn ~= nil then
            return tn
        end
    end
    return default
end


local function add_wp(player, data)
    minetest.log("add wp")
    local pname = player:get_player_name()
    if not auhud.players[pname] then
        minetest.log("add wp: pdata nil")
        auhud.players[pname] = {}
    end
    if data.pos then
        local pos_str = vector.to_string(data.pos)
        local ncolor = safe_to_number(data.color, 0xffffff, 16)
        local nprecision = safe_to_number(data.precision, 1)
        auhud.players[pname][pos_str] = player:hud_add({
            hud_elem_type = "waypoint",
            name = data.title or "",
            text = data.id or "m",
            number = ncolor,
            world_pos = vector.offset(data.pos, data.offsetx, data.offsety, data.offsetz) or vector.new(0, 0, 0),
            precision = nprecision,
        })
    end
end
local function update_wp(player, data)
    local pname = player:get_player_name()
    if auhud.players[pname] == nil then
        minetest.log("update wp: pdata nil")
        auhud.players[pname] = {}
    end
    if data.pos then
        local pos_str = vector.to_string(data.pos)
        local id_ = auhud.players[pname][pos_str]
        if id_ and tonumber(id_) ~= nil then
            local id = tonumber(id_)
            if id ~= nil and player:hud_get(id) then
                local ncolor = safe_to_number(data.color, 0xffffff, 16)
                local nprecision = safe_to_number(data.precision, 1)
                player:hud_change(id, "name", data.title or "")
                player:hud_change(id, "text", data.id or "m")
                player:hud_change(id, "number", ncolor)
                player:hud_change(id, "world_pos", vector.offset(data.pos, data.offsetx, data.offsety, data.offsetz) or vector.new(0, 0, 0))
                player:hud_change(id, "precision", nprecision)
            end
        else
            add_wp(player, data)
        end
    end
end
local function remove_wp(player, pos)
    minetest.log("remove wp")
    local pname = player:get_player_name()
    local player_data = auhud.players[pname]
    local pos_str = vector.to_string(pos)
    if player_data and auhud.players[pname][pos_str] then
        safe_hud_remove(player, auhud.players[pname][pos_str])
        auhud.players[pname][pos_str] = nil
    end
end



local function update_waypoint_node(pos, player, pname)
    local pos_str = vector.to_string(pos)
    if not auhud.node_storage[pos_str] then
        auhud.node_storage[pos_str] = {}
    end
    local pdata = auhud.players[pname]
    if pdata == nil then
        auhud.players[pname] = {}
    end
    local meta = minetest.get_meta(pos)
    local datastring = meta:get_string("arkacia_among_us:data")
    local data = minetest.deserialize(datastring) or {}
    if pdata then
        if pdata[pos_str] then
            update_wp(player, data)
        else
            update_wp(player, data)
        end
    end
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
        for k, v in pairs(minetest.get_connected_players()) do
            if v and v:get_pos() then
                update_waypoint_node(pos, v, v:get_player_name())
            else
                minetest.log("k err")
            end
        end
    end,
    on_construct = function(pos)
        --[[minetest.get_node_timer(pos):start(10)]]
        auhud.node_storage[vector.to_string(pos)] = {}
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
                    "textarea[0,0;0,0;", vector.to_string(pos), ";;]",
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
            local meta = minetest.get_meta(pos)
            datastring = meta:get_string("arkacia_among_us:data")
            local data = minetest.deserialize(datastring) or {}
            data.name = fields.name
            data.title = fields.name
            data.offsetx = safe_to_number(fields.offsetx, 0)
            data.offsety = safe_to_number(fields.offsety, 0)
            data.offsetz = safe_to_number(fields.offsetz, 0)
            local pprecision = safe_to_number(fields.precision, 0)
            data.precision = pprecision ~= 0 and math.pow(10, pprecision) or 0
            data.color = fields.color and fields.color:gsub("#", "") or "ffffff"
            data.pos = pos
            meta:set_string("arkacia_among_us:data", minetest.serialize(data))
            for k, v in pairs(minetest.get_connected_players()) do
                if v and v:get_pos() then
                    update_waypoint_node(pos, v, v:get_player_name())
                else
                    minetest.log("k err")
                end
            end
            update_waypoint_node_fs(pos, player)
        end
    end,
})






if not mcl_util._arkacia_among_us_init then
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "arkacia_among_us:waypoint_node_confirm_break" and fields["break"] then
            local pname = player:get_player_name()
            local pos_str = ""
            for ifields, _fields in pairs(fields) do
                if ifields:find("%(") then
                    pos_str = ifields
                    break
                end
            end

            if pos_str then
                local pos = minetest.string_to_pos(pos_str)
                if pos then
                    if minetest.is_protected(pos, pname) then
                        minetest.record_protection_violation(pos, pname)
                    else
                        local ns = auhud.node_storage[pos_str]
                        if ns ~= nil then
                            for nspname, v in pairs(ns) do
                                local nsplayer = minetest.get_player_by_name(nspname)
                                if nsplayer then
                                    safe_hud_remove(nsplayer, v.hud_id)
                                end
                            end
                        end
                        auhud.node_storage[pos_str] = nil
                        --[[for pnamei, pdatai in pairs(auhud.players) do
                            for pos_stri, _i in pairs(pdatai) do
                                if pos_stri == pos_str then
                                    remove_wp(minetest.get_player_by_name(pnamei), pos)
                                end
                            end
                        end]]
                        minetest.remove_node(pos)
                    end
                end
            end
        end
    end)
end





if not mcl_util._arkacia_among_us_init then
    minetest.register_lbm({
        name = ":arkacia_among_us:update_waypoint_nodes",
        nodenames = {
            "arkacia_among_us:waypoint_node",
        },
        run_at_every_load = true,
        action = function(pos)
            for k, v in pairs(minetest.get_connected_players()) do
                if v and v:get_pos() then
                    update_waypoint_node(pos, v, v:get_player_name())
                else
                    minetest.log("k err")
                end
            end
            update_waypoint_node_fs(pos)
        end,
    })
    mcl_player.register_globalstep_slow(function(player, dtime)
        local pname = player:get_player_name()
        local ppos = player:get_pos()
        local pdata = auhud.players[pname]
        if pdata then
            for node_pos_str, v in pairs(pdata) do
                local pos = minetest.string_to_pos(node_pos_str)
                if pos and ppos then
                    if (pos.x - ppos.x) * (pos.x - ppos.x) + (pos.y - ppos.y) * (pos.y - ppos.y) + (pos.z - ppos.z) * (pos.z - ppos.z) > 128 * 128 or not auhud.node_storage[node_pos_str] then
                        remove_wp(player, pos)
                    else
                        update_waypoint_node(pos, player, pname)
                    end
                end
            end
        elseif pdata == nil then
            auhud.players[pname] = {}
        end
    end)
    minetest.log("globalsteps: " .. #mcl_player.registered_globalsteps_slow)
end




minetest.register_tool(":arkacia_among_us:debug_tool", {
    description = "Debug Tool",
    inventory_image = "default_stone.png",
    on_use = function(itemstack, user, pointed_thing)
        minetest.chat_send_all("auhud.players: " .. dump(auhud.players))
        minetest.chat_send_all("auhud.node_storage: " .. dump(auhud.node_storage))
    end,
})



if not mcl_util._arkacia_among_us_init then
    mcl_util._arkacia_among_us_init = true
end
