local modname = "magikacia"
--[[local vector = vector
local minetest = minetest
local magikacia = magikacia]]

local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local resize_max_size = 80


local around_plus_pos_list = {
    { 0,  0 },
    { 1,  0 },
    { 0,  1 },
    { -1, 0 },
    { 0,  -1 },
}

mcl_util._magikacia_spellbook_init = mcl_util._magikacia_spellbook_init or false




magikacia.inv = {
    has_in = function(itemstack, player, itemname, listname)
        if not player or not itemstack then return nil end

        local meta = itemstack:get_meta()
        local invmetastring = meta:get_string("magikacia_inv_content")
        if invmetastring ~= "" then
            local invtable = assert(minetest.deserialize(invmetastring))
            local t = invtable[listname]
            if not t then return nil end
            for i, v in pairs(t) do
                if v.name == itemname then return true end
            end
        end
        return false
    end,
    get_in = function(itemstack, player, listname)
        if not player or not itemstack then return nil end
        local meta = itemstack:get_meta()
        local invmetastring = meta:get_string("magikacia_inv_content")
        if invmetastring ~= "" then
            local invtable = assert(minetest.deserialize(invmetastring))
            local t = invtable[listname]
            if not t then return {} end
            return t
        else
            return {}
        end
    end,
    get_in_reversed_key_value = function(itemstack, player, listname)
        if not player or not itemstack then return nil end
        local meta = itemstack:get_meta()
        local invmetastring = meta:get_string("magikacia_inv_content")
        if invmetastring ~= "" then
            local invtable = minetest.deserialize(invmetastring)
            if not invtable then return {} end
            local t = invtable[listname]
            if not t then return {} end
            local t2 = {}
            for _, v in ipairs(t) do
                t2[v.name] = true
            end
            return t2
        else
            return {}
        end
    end,
    create_bag_inv = function(itemstack, player, width, height, invname, allow_bag_input, playername, meta, inv)
        --[[meta:set_int("magikacia_width_" .. listname, width)
        meta:set_int("magikacia_height_" .. listname, height)]]
        local invmetastring = meta:get_string("magikacia_inv_content")
        if invmetastring ~= "" then
            magikacia.inv.table_to_inv(inv, minetest.deserialize(invmetastring))

            itemstack, inv, user = magikacia.on_open_bag(itemstack, inv, user)
            magikacia.inv.save_bag_inv_itemstack(inv, itemstack)
        end
        return itemstack, inv, user
    end,
    save_bag_inv_itemstack = function(inv, stack, listname)
        stack, inv = magikacia.on_change_bag_inv(stack, inv)
        local meta = stack:get_meta()
        local ser = minetest.serialize(magikacia.inv.inv_to_table(inv))
        meta:set_string("magikacia_inv_content", ser)
        return stack
    end,
    save_bag_inv = function(inv, player, _)
        local playerinv = player:get_inventory()
        local bag_id = inv:get_location().name
        local playerlistname = "main"
        local size = playerinv:get_size(playerlistname)
        for i = 1, size, 1 do
            local stack = playerinv:get_stack(playerlistname, i)
            local meta = stack:get_meta()
            local stack_id = meta:get_string("magikacia_bag_identity")
            if stack_id == bag_id then
                stack = magikacia.inv.save_bag_inv_itemstack(inv, stack)
                playerinv:set_stack(playerlistname, i, stack)
            end
        end
        return inv
    end,
    inv_to_table = function(inv)
        local t = {}
        for _listname, list in pairs(inv:get_lists()) do
            local size = inv:get_size(_listname)
            if size then
                t[_listname] = {}
                for i = 1, size, 1 do
                    t[_listname][i] = inv:get_stack(_listname, i):to_table()
                end
            end
        end
        return t
    end,

    table_to_inv = function(inv, t)
        for _listname, list in pairs(t) do
            for i, stack in pairs(list) do
                inv:set_stack(_listname, i, stack)
            end
        end
    end,
}


local function get_formspec(name, width_main, height_main, width_cores, height_cores)
    --[[4.125]]
    local magic_inventory_x = 11.75 / 2 - width_main / 2
    local spellbook_inv_formspec = table.concat({
        "formspec_version[4]",
        "size[11.75,10.425]",

        width_cores and ("label[0.375,0.375;" .. F(C(mcl_formspec.label_color, S("Cores"))) .. "]") or "",

        width_cores and (mcl_formspec.get_itemslot_bg_v4(0.375, 0.75, width_cores, height_cores)) or "",
        width_cores and ("list[detached:" .. name .. ";cores;0.375,0.75;" .. width_cores .. "," .. height_cores .. ";]") or "",

        "label[" .. magic_inventory_x .. ",0.375;" .. F(C(mcl_formspec.label_color, S("Magic Inventory"))) .. "]",
        mcl_formspec.get_itemslot_bg_v4(magic_inventory_x, 0.75, width_main, height_main),
        "list[detached:" .. name .. ";main;" .. magic_inventory_x .. ",0.75;" .. width_main .. "," .. height_main .. ";]",
        "label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",

        mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
        "list[current_player;main;0.375,5.1;9,3;9]",

        mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
        "list[current_player;main;0.375,9.05;9,1;]",

        "listring[current_player;main]",
        "listring[detached:" .. name .. ";main]",
        "listring[current_player;main]",
        "listring[detached:" .. name .. ";cores]",
    })
    return spellbook_inv_formspec
end



function magikacia.has_in_spellbook_inv_main(itemstack, player, itemname)
    return magikacia.inv.has_in(itemstack, player, itemname, "main")
end

local has_in_spellbook_inv_main = magikacia.has_in_spellbook_inv_main
function magikacia.has_in_spellbook_inv_cores(itemstack, player, itemname)
    return magikacia.inv.has_in(itemstack, player, itemname, "cores")
end

local has_in_spellbook_inv_cores = magikacia.has_in_spellbook_inv_cores


local formspec_ender_chest = table.concat({
    "formspec_version[4]",
    "size[11.75,10.425]",

    "label[0.375,0.375;" .. F(C(mcl_formspec.label_color, S("Ender Chest"))) .. "]",
    mcl_formspec.get_itemslot_bg_v4(0.375, 0.75, 9, 3),
    "list[current_player;enderchest;0.375,0.75;9,3;]",
    "label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",
    mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
    "list[current_player;main;0.375,5.1;9,3;9]",

    mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
    "list[current_player;main;0.375,9.05;9,1;]",

    "listring[current_player;enderchest]",
    "listring[current_player;main]",
})


function magikacia.on_change_bag_inv(bagstack, baginv)
    return bagstack, baginv
end

function magikacia.on_open_bag(bagstack, baginv, player)
    return bagstack, baginv, player
end

function magikacia.on_close_bag(player, fields, name, formname, sound)
    return player, fields, name, formname, sound
end

function magikacia.before_open_bag(itemstack, user, width, height, sound)
    return itemstack, user, width, height, sound
end

function magikacia.on_use_bag(itemstack, user, pointed_thing)
    return itemstack, user, pointed_thing
end

function magikacia.on_drop_bag(itemstack, dropper, pos)
    minetest.item_drop(itemstack, dropper, pos)
    return itemstack, dropper, pos
end

--[[local mod_storage = {}]]
magikacia.rand = PcgRandom(213123)
local function create_invname(itemstack)
    --[[local counter = mod_storage["counter"] or 0
    counter = counter + 1
    mod_storage["counter"] = counter]]
    counter = magikacia.rand:next(0, 2147483647)
    return itemstack:get_name() .. "_C_" .. counter
end

local function stack_to_player_inv(stack, player)
    local payerinv = player:get_inventory()
    if payerinv:room_for_item("main", stack) then
        payerinv:add_item("main", stack)
    else
        minetest.item_drop(stack, player, player:get_pos())
    end
end

local function open_bag(itemstack, user, width_main, height_main, sound, width_cores, height_cores)
    itemstack, user, width_main, height_main, sound = magikacia.before_open_bag(itemstack, user, width_main, height_main, sound)
    local allow_bag_input = false
    if minetest.get_item_group(itemstack:get_name(), "bag_bag") > 0 then
        allow_bag_input = true
    end
    local meta = itemstack:get_meta()
    local playername = user:get_player_name()
    local invname = meta:get_string("magikacia_bag_identity")


    if invname == "" then
        invname = create_invname(itemstack)
        meta:set_string("magikacia_bag_identity", invname)
    end

    local inv = minetest.create_detached_inventory(invname, {
        allow_put = function(inv, _listname, index, stack, player)
            if allow_bag_input then
                if minetest.get_item_group(stack:get_name(), "bag_bag") > 0 then
                    return 0
                end
            else
                if minetest.get_item_group(stack:get_name(), "bag") > 0 then
                    return 0
                end
            end
            return stack:get_count()
        end,
        on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
            magikacia.inv.save_bag_inv(inv, player, from_list)
            magikacia.inv.save_bag_inv(inv, player, to_list)
        end,
        on_put = function(inv, listname, index, stack, player)
            magikacia.inv.save_bag_inv(inv, player, listname)
        end,
        on_take = function(inv, takelistname, index, stack, player)
            local _takelistname = inv:get_location().name
            local size = inv:get_size(takelistname)
            for i = 1, size, 1 do
                local invstack = inv:get_stack(takelistname, i)
                local remove_stack = false
                if allow_bag_input then
                    if minetest.get_item_group(invstack:get_name(), "bag_bag") > 0 then
                        remove_stack = true
                    end
                else
                    if minetest.get_item_group(invstack:get_name(), "bag") > 0 then
                        remove_stack = true
                    end
                end
                if remove_stack == true then
                    inv:set_stack(takelistname, i, "")
                    local playerinv = player:get_inventory()
                    if playerinv:room_for_item("main", invstack) then
                        playerinv:add_item("main", invstack)
                    else
                        minetest.item_drop(magikacia.inv.save_bag_inv_itemstack(inv, invstack), player,
                            player:get_pos())
                        minetest.close_formspec(player:get_player_name(), inv:get_location().name)
                    end
                end
            end
            magikacia.inv.inv_to_table(inv)
            magikacia.inv.save_bag_inv(inv, player, _takelistname)
        end,
    }, playername)

    inv:set_size("main", width_main * height_main)
    inv:set_size("cores", width_cores * height_cores)
    itemstack, inv, user = magikacia.inv.create_bag_inv(itemstack, user, width_main, height_main, invname, allow_bag_input,
        playername, meta, inv)


    if sound then
        minetest.sound_play(sound, { gain = 0.8, object = user, max_hear_distance = 5 })
    end
    minetest.show_formspec(playername, invname, get_formspec(invname, width_main, height_main, width_cores, height_cores))
    return itemstack
end
--[[
function magikacia.bag_inv_add_item(bagstack, itemstack)
    local meta = bagstack:get_meta()
    local invname = meta:get_string("magikacia_bag_identity")
    if not invname then
        return false
    end
    local inv = minetest.create_detached_inventory(invname, {})
    local width = meta:get_int("magikacia_width")
    local height = meta:get_int("magikacia_height")
    inv:set_size("main", width * height)
    local invmetastring = meta:get_string("magikacia_inv_content")
    if invmetastring ~= "" then
        table_to_inv(inv, minetest.deserialize(invmetastring))

        bagstack, inv = magikacia.on_change_bag_inv(bagstack, inv)
    end
    if inv:room_for_item("main", itemstack) then
        inv:add_item("main", itemstack)
        return save_bag_inv_itemstack(inv, bagstack)
    end
    return false
end

function magikacia.bag_inv_remove_item(bagstack, itemstack)
    local meta = bagstack:get_meta()
    local invname = meta:get_string("magikacia_bag_identity")
    if not invname then
        return false
    end
    local inv = minetest.create_detached_inventory(invname, {})
    local width = meta:get_int("magikacia_width")
    local height = meta:get_int("magikacia_height")
    inv:set_size("main", width * height)
    local invmetastring = meta:get_string("magikacia_inv_content")
    if invmetastring ~= "" then
        table_to_inv(inv, minetest.deserialize(invmetastring))

        bagstack, inv = magikacia.on_change_bag_inv(bagstack, inv)
    end
    if inv:contains_item("main", itemstack) then
        inv:remove_item("main", itemstack)
        return save_bag_inv_itemstack(inv, bagstack)
    end
    return false
end
--]]

local function get_visual_size(obj)
    if not obj then return nil end
    local vs
    if obj:is_player() then
        vs = entity_modifier.player_sizes and entity_modifier.player_sizes[obj:get_player_name()] or nil
    end
    if not vs then
        vs = 1
        local pprops = obj:get_properties()
        if pprops and pprops.visual_size then
            local ppropsvs = pprops.visual_size
            if ppropsvs and ppropsvs.x then
                vs = ppropsvs.x
            end
        end
    end
    return vs
end

magikacia.get_core_multipliers = function(inv_cores)
    local core_multipliers = {
        damage = 1,
        physical_effect = 1,
        cooldown = 1,
        energy_cost = 1,
    }
    for _, item_core in pairs(inv_cores) do
        local item_core_name = item_core.name
        local itemdef = minetest.registered_items[item_core_name]
        if itemdef then
            local itemdef_modifiers = itemdef._magikacia_modifiers
            if itemdef_modifiers then
                for modifier_name, modifier_value in pairs(itemdef_modifiers) do
                    core_multipliers[modifier_name] = (core_multipliers[modifier_name] or 1) * modifier_value
                end
            end
        end
    end
    return core_multipliers
end

local wind_primary_sneak_pos_list = {}
for i = 0, math.pi * 6, math.pi / 5 do
    table.insert(wind_primary_sneak_pos_list, vector.new(math.cos(i) * i, i * 2, i * math.sin(i)))
end

local specific_attack_all = {}
for mob_name, _ in pairs(mcl_mobs.registered_mobs) do
    if mob_name ~= ":magikacia:adminite" then
        table.insert(specific_attack_all, mob_name)
    end
end


local function spellbook_use_primary(itemstack, placer, pointed_thing)
    if not placer then return nil end
    local placer_name = placer:get_player_name()
    local use_pos_self = placer:get_pos()
    --[[local meta = placer:get_meta()]]
    local use_pos_above
    local use_pos_under
    local pointed_obj
    if pointed_thing.type == "node" then
        use_pos_above = pointed_thing.above
        use_pos_under = pointed_thing.under
    elseif pointed_thing.type == "object" then
        pointed_obj = pointed_thing.ref
        use_pos_above = pointed_obj:get_pos()
        use_pos_under = vector.offset(use_pos_above, 0, -1, 0)
    end
    local use_success = false
    local use_at_place_above = false
    local use_at_place_under = false
    local use_at_self = false
    local itemname = itemstack:get_name()
    local is_gauntlet_admin = itemname == "magikacia:gauntlet_admin"
    local placer_props = placer:get_properties()
    local placer_eye_height = placer_props.eye_height or 1.625

    local inv_cores = magikacia.inv.get_in(itemstack, placer, "cores") or {}
    local cores_multipliers = magikacia.get_core_multipliers(inv_cores)
    

    local inv_runes_contains = magikacia.inv.get_in_reversed_key_value(itemstack, placer, "main") or {}



    local is_placer_sneaking = false
    if placer:is_player() then
        if controls.players[placer_name].sneak[1] then
            is_placer_sneaking = true
        end
    end


    if inv_runes_contains["magikacia:rune_earth"] then
        local offset = placer:get_look_dir()
        for i = 1, 5 do
            local pos = vector.add(vector.offset(use_pos_self, 0, placer_eye_height * 0.7, 0),
                vector.multiply(offset, i))
            if pos then
                magikacia.radius_effect_func(pos, 2, placer, function(obj)
                    magikacia.deal_spell_damage(obj, 3 * cores_multipliers.damage, "earth_primary", placer)
                end)
            end
            magikacia.spawn_effect_anim({
                pos = pos,
                texture = "effect_earth_primary",
                duration_total = 0.4,
                duration_anim = 0.4,
            })
        end
        use_success = true
        use_at_self = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_electric"] then
        local electric_primary_success = false
        magikacia.radius_effect_func(use_pos_above, 3.5, placer, function(obj)
            if magikacia.tase(placer, obj) then
                electric_primary_success = true
            end
        end)
        if electric_primary_success then
            use_success = true
            use_at_place_above = true
        end
        local spd = 3 / 0.25
        magikacia.spawn_effect_anim_spawner({
            time = 0.01,
            pos = use_pos_above,
            amount = 50,
            minsize = 1,
            maxsize = 5,
            minexptime = 0.0,
            maxexptime = 0.25,
            minvel = { x = -spd, y = -spd, z = -spd },
            maxvel = { x = spd, y = spd, z = spd },
            minacc = { x = 0, y = 0, z = 0 },
            maxacc = { x = 0, y = 0, z = 0 },
            texture = "effect_electric_primary",
        })
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_fire"] then
        for _, k in ipairs(around_plus_pos_list) do
            magikacia.safe_replace({ x = use_pos_above.x + k[1], y = use_pos_above.y, z = use_pos_above.z + k[2] },
                "magikacia:fire_temp",
                placer)
        end
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_fire_primary",
        })
        mcl_potions.fire_resistance_func(placer, nil, 10)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_ice"] then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            mcl_potions.swiftness_func(obj, -1, 3 * cores_multipliers.physical_effect)
            mcl_potions.leaping_func(obj, -1, 3 * cores_multipliers.physical_effect)
        end)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_telepathic"] then
        if is_placer_sneaking then
            if pointed_obj then
                local pself = placer:get_pos()
                if pself then
                    pointed_obj:set_pos(pself)
                end
                placer:set_pos(use_pos_above)
            elseif pointed_thing.type == "node" then
                placer:set_pos({ x = use_pos_above.x, y = use_pos_above.y - 0.5, z = use_pos_above.z })
            else
                placer:set_pos(use_pos_above)
            end
        else
            if pointed_thing.type == "node" then
                placer:set_pos({ x = use_pos_above.x, y = use_pos_above.y - 0.5, z = use_pos_above.z })
            else
                placer:set_pos(use_pos_above)
            end
        end
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_water"] then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                magikacia.deal_spell_damage(obj, 5 * cores_multipliers.damage, "water_primary", placer)
            end
            mcl_burning.extinguish(obj)
        end, true)

        local nodes, node_counts = minetest.find_nodes_in_area(vector.offset(use_pos_above, -3, -3, -3),
            vector.offset(use_pos_above, 3, 3, 3), "group:fire", false)
        if nodes then
            minetest.bulk_set_node(nodes, { name = "air" })
        end

        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_water_primary",
            size = 30,
            duration_total = 0.4,
            duration_anim = 0.4,
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_void"] then
        magikacia.radius_effect_func(use_pos_above, 2, placer, function(obj)
            magikacia.deal_spell_damage(obj, 20 * cores_multipliers.damage, "void_primary", placer)
        end)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_void_primary",
            duration_total = 0.5,
            duration_anim = 0.5,
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_wind"] then
        if not is_placer_sneaking then
            magikacia.radius_effect_func(use_pos_above, 8, placer, function(obj)
                local newvel = vector.offset(
                    vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos_above)), 10 * cores_multipliers.physical_effect), 0, 15, 0)
                obj:add_velocity(newvel)
            end, true)
            magikacia.spawn_effect_anim({
                pos = use_pos_above,
                texture = "effect_wind_primary",
            })
        else
            local function suck(n, victim, original_pos)
                if victim then
                    minetest.after(0.05, function(nsub, obj)
                        if obj then
                            local pobj = obj:get_pos()
                            if pobj then
                                nsub = nsub + 1
                                if nsub < #wind_primary_sneak_pos_list then
                                    obj:move_to(vector.add(original_pos, wind_primary_sneak_pos_list[nsub]))
                                    local v = obj:get_velocity()
                                    if v then
                                        obj:add_velocity({ x = v.x, y = -(v.y or 0) * 2, z = v.z })
                                    end
                                    suck(nsub, obj, original_pos)
                                    --[[magikacia.deal_spell_damage(obj, 1 * cores_multipliers.damage, "wind_primary_sneak", placer)]]
                                end
                            end
                        end
                    end, n, victim)
                end
            end
            magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
                local p = obj:get_pos()
                if p then
                    suck(0, obj, p)
                end
            end)
            for ipos, pos in ipairs(wind_primary_sneak_pos_list) do
                minetest.after(ipos * 0.05, function()
                    magikacia.spawn_effect_anim({
                        pos = vector.add(use_pos_above, pos),
                        texture = "effect_wind_primary_sneak",
                        size = 40,
                    })
                end)
            end
            magikacia.spawn_effect_anim({
                pos = use_pos_above,
                texture = "effect_wind_primary_sneak",
                size = 40,
            })
        end
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and use_pos_above and inv_runes_contains["magikacia:rune_disguise"] then
        entity_modifier.disguise_tool_primary(itemstack, placer, pointed_thing)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and use_pos_above and inv_runes_contains["magikacia:rune_resize"] then
        if pointed_obj then
            local vs = get_visual_size(pointed_obj) * 1 + 0.1 * cores_multipliers.physical_effect
            if vs and (is_gauntlet_admin or vs <= resize_max_size) then
                entity_modifier.resize(
                    pointed_obj,
                    vs,
                    0.1,
                    is_gauntlet_admin and true or resize_max_size
                )
                if use_pos_above then
                    magikacia.spawn_effect_anim({
                        pos = use_pos_above,
                        texture = "effect_resize_primary",
                        size = 15,
                    })
                    use_at_place_above = true
                end
            end
            use_success = true
        else
            local vs = get_visual_size(placer) * 1 + 0.1 * cores_multipliers.physical_effect
            if vs and (is_gauntlet_admin or vs <= resize_max_size) then
                entity_modifier.resize_player(
                    placer,
                    vs,
                    0.1,
                    is_gauntlet_admin and true or resize_max_size
                )
                magikacia.spawn_effect_anim({
                    pos = use_pos_self,
                    texture = "effect_resize_primary",
                    size = 15,
                })
            end
            use_success = true
            use_at_self = true
        end
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_poison"] then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj, obj_is_player)
            if obj_is_player then
                mcl_potions.poison_func(obj, 1 * cores_multipliers.damage, 3 * cores_multipliers.physical_effect)
            end
        end)
        magikacia.spawn_linger_particles(use_pos_above, 3, magikacia.textures.effect_poison_particles)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_healing"] then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            mcl_potions.regeneration_func(obj, 1, 3 * cores_multipliers.physical_effect)
            mcl_potions.healing_func(obj, 6 * cores_multipliers.physical_effect)
        end, true)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end




    if use_pos_above and inv_runes_contains["magikacia:rune_nature"] then
        for i = 5, 5 * cores_multipliers.physical_effect, 5 do
            for ii = 0, math.pi * 2 - 0.01, math.pi / 3 do
                local above_posi = {
                    x = math.round(use_pos_above.x + math.cos(ii) * i),
                    y = use_pos_above.y,
                    z = math.round(use_pos_above.z + math.sin(ii) * i),
                }
                local under_posi = { x = above_posi.x, y = above_posi.y - 1, z = above_posi.z }
                magikacia.bone_meal(itemstack, placer, { type = "node", under = under_posi, above = above_posi })
            end
        end
        use_success = true
        use_at_place_above = true
    end

    if use_pos_under and inv_runes_contains["magikacia:rune_protection"] then
        minetest.registered_chatcommands["area_pos1"].func(placer:get_player_name(),
            use_pos_under.x .. " " .. use_pos_under.y .. " " .. use_pos_under.z)
        use_success = true
        use_at_place_under = true
    end

    if inv_runes_contains["magikacia:rune_bubble"] then
        local add_vel = vector.multiply(placer:get_look_dir(), 20 * cores_multipliers.physical_effect)
        local _bubble_itemstack
        local bubble_use_pos
        if magikacia_bubbles then
            _bubble_itemstack, bubble_use_pos = magikacia_bubbles.bubble_blower_primary(itemstack, placer, pointed_thing)
        end
        if bubble_use_pos then
            magikacia.radius_effect_func(bubble_use_pos, 3, placer, function(obj, obj_is_player)
                if obj_is_player then
                    mcl_potions.poison_func(obj, 1 * cores_multipliers.damage, 2 * cores_multipliers.physical_effect)
                end
                obj:add_velocity(add_vel)
            end)
            use_success = true
            use_at_place_above = true
        end
    end
    
    if inv_runes_contains["magikacia:rune_absolute_solver"] then
        local pdata = magikacia.players[placer_name]
        pdata.effect_absolute_solver_primary_captured_list = pdata.effect_absolute_solver_primary_captured_list or {}
        if is_placer_sneaking or #pdata.effect_absolute_solver_primary_captured_list > 0 then
            pdata.effect_absolute_solver_primary_captured_list = {}
        elseif pointed_obj and use_pos_above then
            if not magikacia.is_obj_static(pointed_obj) then
                if pdata then
                    table.insert(magikacia.players[placer_name].effect_absolute_solver_primary_captured_list, {
                        obj = pointed_obj,
                        dist = vector.distance(vector.offset(use_pos_self, 0, placer_eye_height, 0), use_pos_above),
                    })
                end
            end
        end
        use_success = true
        use_at_place_above = true
    end

    if inv_runes_contains["magikacia:rune_shadow"] then
        local pdata = magikacia.players[placer_name]
        if not pdata.effect_shadow_primary_captured_list or #pdata.effect_shadow_primary_captured_list == 0 then
            local look_dir = placer:get_look_dir()
            local look_horiz = placer:get_look_horizontal()
            local look_vert = -placer:get_look_vertical()
            local ent_spd = 10
            local spawn_pos = vector.offset(placer:get_pos(), 0, placer_eye_height, 0)
            local frame_duration = 0.2
            local ent = magikacia.spawn_effect_entity_3d({
                pos = spawn_pos,
                itemname = "magikacia:zzz_textures_effect_shadow_primary",
                rotation = { x = look_vert, y = look_horiz, z = 0 },
                size = 1,
                nframes = 4,
                total_anim_time = frame_duration * 4,
                expiration_time = frame_duration * 4,
                base_item = "magikacia:zzz_textures_effect_shadow_primary",
            })
            local ent_vel = look_dir:multiply(ent_spd)
            ent:set_velocity(ent_vel)
            --[[minetest.log("look_horiz:" .. look_horiz)
            minetest.log("look_vert: " .. look_vert)--]]
            local end_pos = vector.add(spawn_pos, vector.multiply(ent_vel, frame_duration * 4))
            minetest.after(frame_duration * 4, function(dtime)
                magikacia.radius_effect_func(end_pos, 1.5, placer, function(obj, obj_is_player)
                    if pdata then
                        pdata.effect_shadow_primary_captured_list = pdata.effect_shadow_primary_captured_list or {}
                        table.insert(magikacia.players[placer_name].effect_shadow_primary_captured_list, {
                            obj = obj,
                        })
                        magikacia.players[placer_name].effect_shadow_primary_capture_pos = end_pos
                    end
                end)
            end)
            use_success = true
            use_at_self = true
        else
            if use_pos_above then
                magikacia.players[placer_name].effect_shadow_primary_capture_pos = vector.offset(use_pos_above, 0, pointed_thing.type == "node" and -0.5 or 0, 0)
                local effect_shadow_primary_captured_list = pdata.effect_shadow_primary_captured_list
                if effect_shadow_primary_captured_list then
                    for _, captured_def in pairs(effect_shadow_primary_captured_list) do
                        local obj = captured_def.obj
                        if obj and obj:is_valid() and obj:get_pos() then
                            obj:move_to(vector.offset(use_pos_above, 0, -0.5, 0))
                        end
                    end
                end
                pdata.effect_shadow_primary_captured_list = {}
            end
        end
    end

    if inv_runes_contains["magikacia:rune_summoning"] then
        local safe_use_pos = use_pos_above or use_pos_self
        if safe_use_pos then
            local ent = minetest.add_entity(safe_use_pos, ":magikacia:adminite", minetest.serialize({
                owner = placer_name,
                specific_attack = specific_attack_all,
            }))
            magikacia.spawn_effect_anim({
                pos = safe_use_pos,
                texture = "effect_vortex_blue",
            })
            use_success = true
            use_at_pos_above = true
        end
    end


    if inv_runes_contains["magikacia:rune_rope"] then
        mcl_throwing.get_player_throw_function("magikacia:throwable_attack_rope_primary_entity")(ItemStack("magikacia:throwable_attack_rope_primary", 64), placer, pointed_thing)
        use_success = true
        use_at_pos_above = true
    end

    if use_pos_under and use_pos_above and inv_runes_contains["magikacia:rune_portal"] then
        magikacia.effect_portal_pairs[pname].primary = {
            pos = use_pos_above,
            dir = vector.subtract(use_pos_under, use_pos_above),
        }
    end

    if use_success then
        if use_at_self then
            minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_self, max_hear_distance = 32, gain = 0.5 }, true)
        end
        if use_at_place_above then
            minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_above, max_hear_distance = 32, gain = 0.5 }, true)
        end
        if use_at_place_under then
            minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_under, max_hear_distance = 32, gain = 0.5 }, true)
        end
    end

    return magikacia.on_use_bag(itemstack, placer, pointed_thing)
end
magikacia.registered_player_globalsteps["spellbook:effect_absolute_solver_primary"] = function(player, dtime)
    local pname = player:get_player_name()
    local player_data = magikacia.players[pname]
    if player_data then
        local effect_absolute_solver_primary_captured_list = player_data.effect_absolute_solver_primary_captured_list
        if effect_absolute_solver_primary_captured_list then
            local player_props = player:get_properties()
            local eye_height = player_props.eye_height or 1.625
            local eye_pos = vector.offset(player:get_pos(), 0, eye_height, 0)
            local look_dir = player:get_look_dir()
            for _, captured_def in ipairs(effect_absolute_solver_primary_captured_list) do
                local obj = captured_def.obj
                if obj and obj:is_valid() and obj:get_pos() then
                    local move_to_pos = vector.add(eye_pos, vector.multiply(look_dir, captured_def.dist ~= nil and captured_def.dist or 4))
                    obj:move_to(move_to_pos)
                    obj:set_velocity(vector.new(0, 9.8 * dtime, 0))
                    magikacia.spawn_effect_anim({
                        pos = vector.offset(move_to_pos, 0, 0.5, 0),
                        texture = "effect_absolute_solver_primary",
                        size = 25,
                        duration_total = dtime,
                    })
                end
            end
        end
    end
end
magikacia.registered_player_globalsteps["spellbook:effect_shadow_primary"] = function(player, dtime)
    local pname = player:get_player_name()
    local player_data = magikacia.players[pname]
    if player_data then
        local effect_shadow_primary_captured_list = player_data.effect_shadow_primary_captured_list
        if effect_shadow_primary_captured_list then
            for _, captured_def in pairs(effect_shadow_primary_captured_list) do
                local obj = captured_def.obj
                if obj and obj:is_valid() and obj:get_pos() then
                    local move_to_pos = player_data.effect_shadow_primary_capture_pos
                    if move_to_pos then
                        obj:move_to(move_to_pos)
                        obj:set_velocity(vector.new(0, 9.8 * dtime, 0))
                        magikacia.spawn_effect_anim({
                            pos = vector.offset(move_to_pos, 0, 0.5, 0),
                            texture = magikacia.textures["effect_shadow_primary"] .. "^[verticalframe:4:4",
                            size = 25,
                            duration_total = dtime,
                            duration_anim = dtime,
                        })
                    end
                else
                    effect_shadow_primary_captured_list[_] = nil
                end
            end
        end
    end
end
local spellbook_use_secondary = function(itemstack, placer, pointed_thing, bagtable)
    if not placer then return nil end
    local placer_name = placer:get_player_name()
    local use_pos_self = placer:get_pos()
    local meta = placer:get_meta()
    local use_pos_above
    local use_pos_under
    local pointed_obj
    if pointed_thing.type == "node" then
        use_pos_above = pointed_thing.above
        use_pos_under = pointed_thing.under
    elseif pointed_thing.type == "object" then
        pointed_obj = pointed_thing.ref
        use_pos_above = pointed_obj:get_pos()
        use_pos_under = vector.offset(use_pos_above, 0, -1, 0)
    end
    local use_success = false
    local use_at_place_above = false
    local use_at_place_under = false
    local use_at_self = false
    local itemname = itemstack:get_name()
    local is_gauntlet_admin = itemname == "magikacia:gauntlet_admin"

    local inv_cores = magikacia.inv.get_in(itemstack, placer, "cores") or {}
    local cores_multipliers = magikacia.get_core_multipliers(inv_cores)

    local inv_runes_contains = magikacia.inv.get_in_reversed_key_value(itemstack, placer, "main") or {}

    if placer:is_player() then
        if controls.players[placer_name].sneak[1] then
            return open_bag(itemstack, placer, bagtable.width_main, bagtable.height_main, bagtable.sound_open, bagtable.width_cores, bagtable.height_cores)
        end
    end


    local spell_earth_time_active = meta:get_float("magikacia:spell_earth_time_active")
    if inv_runes_contains["magikacia:rune_earth"] and spell_earth_time_active == 0 then
        meta:set_float("magikacia:spell_earth_time_active", spell_earth_time_active + 1)
        placer:add_velocity({ x = 0, y = 15, z = 0 })
        magikacia.spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_earth_secondary",
        })
        use_success = true
        use_at_self = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_electric"] then
        magikacia.lightning_strike(vector.offset(use_pos_above, 0, -1, 0), placer)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if inv_runes_contains["magikacia:rune_fire"] then
        mcl_potions.fire_resistance_func(placer, nil, 10)
        mcl_throwing.get_player_throw_function("magikacia:throwable_attack_fire_secondary_entity")(
            ItemStack("magikacia:throwable_attack_fire_secondary", 64), placer, pointed_thing)
        use_success = true
    end

    if inv_runes_contains["magikacia:rune_ice"] then
        mcl_throwing.get_player_throw_function("magikacia:throwable_attack_ice_secondary_entity")(
            ItemStack("magikacia:throwable_attack_ice_secondary", 64), placer, pointed_thing)
        use_success = true
    end

    if inv_runes_contains["magikacia:rune_telepathic"] then
        --[[minetest.show_formspec(placer:get_player_name(), "mcl_chests:ender_chest_" .. placer:get_player_name(), formspec_ender_chest)]]
        magikacia.random_teleport_obj(placer)
        magikacia.spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_self = true
    end

    if use_pos_above and inv_runes_contains["magikacia:rune_void"] then
        local function suck(time, victim)
            if victim then
                minetest.after(0.1, function(t, obj)
                    if obj then
                        local pobj = obj:get_pos()
                        if pobj then
                            if t - 0.1 > 0 then
                                obj:set_pos(vector.offset(pobj, 0, -1.1, 0))
                                suck(t - 0.1, obj)
                            else
                                magikacia.deal_spell_damage(obj, 20 * cores_multipliers.damage, "void_secondary", placer)
                            end
                        end
                    end
                end, time, victim)
            end
        end
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            suck(5, obj)
        end)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_void_secondary",
            duration_total = 5,
            duration_anim = 0.5,
            size = 40,
        })
        use_success = true
        use_at_place_above = true
    end
    if use_pos_self and inv_runes_contains["magikacia:rune_water"] then
        local node = minetest.get_node(use_pos_self)
        if node and minetest.get_item_group(node.name, "water") > 0 or (mcl_weather.rain.raining and mcl_weather.is_outdoor(use_pos_self) and mcl_weather.has_rain(use_pos_self)) then
            magikacia.radius_effect_func(use_pos_self, 3, placer, function(obj)
                if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                    magikacia.deal_spell_damage(obj, 10 * cores_multipliers.damage, "water_secondary", placer)
                end
                mcl_burning.extinguish(obj)
            end, true)

            placer:add_player_velocity(vector.multiply(placer:get_look_dir(), 50 * cores_multipliers.physical_effect))
            mcl_potions.water_breathing_func(placer, nil, 10)

            local nodes, node_counts = minetest.find_nodes_in_area(vector.offset(use_pos_self, -3, -3, -3),
                vector.offset(use_pos_self, 3, 3, 3), "group:fire", true)
            if nodes then
                minetest.bulk_set_node(nodes, { name = "air" })
            end

            magikacia.spawn_effect_anim({
                pos = use_pos_self,
                texture = "effect_water_secondary",
                attached = placer
            })
            use_success = true
            use_at_self = true
        else
            mcl_throwing.get_player_throw_function("magikacia:throwable_attack_water_secondary_entity")(
                ItemStack("magikacia:throwable_attack_water_secondary", 64), placer, pointed_thing)
            use_success = true
        end
    end

    if use_pos_self and inv_runes_contains["magikacia:rune_wind"] then
        magikacia.radius_effect_func(use_pos_self, 3, placer, function(obj)
            magikacia.deal_spell_damage(obj, 10 * cores_multipliers.damage, "wind_secondary", placer)
        end)

        placer:add_player_velocity(vector.multiply(placer:get_look_dir(), 30 * cores_multipliers.physical_effect))
        
        magikacia.spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_vortex_blue",
            duration_total = 0.4,
            duration_anim = 0.4,
        })
        use_success = true
    end

    if entity_modifier and inv_runes_contains["magikacia:rune_disguise"] then
        entity_modifier.disguise_tool_secondary(itemstack, placer, pointed_thing)
        magikacia.spawn_effect_anim({
            pos = use_pos_above or use_pos_self,
            texture = "effect_vortex_blue",
        })
        use_success = true
        --[[use_at_place_above = true]]
    end

    if entity_modifier and inv_runes_contains["magikacia:rune_resize"] then
        if pointed_obj then
            local vs = get_visual_size(pointed_obj) / 1.1
            if vs and vs >= 0.1 then
                entity_modifier.resize(
                    pointed_obj,
                    vs,
                    0.1,
                    resize_max_size
                )
                if use_pos_above then
                    magikacia.spawn_effect_anim({
                        pos = use_pos_above,
                        texture = "effect_resize_secondary",
                        size = 15,
                    })
                    use_at_place_above = true
                end
            end
            use_success = true
        else
            local vs = get_visual_size(placer) / 1.1
            if vs and vs >= 0.1 then
                entity_modifier.resize_player(
                    placer,
                    vs,
                    0.1,
                    resize_max_size
                )
                magikacia.spawn_effect_anim({
                    pos = use_pos_self,
                    texture = "effect_resize_secondary",
                    size = 15,
                })
            end
            use_success = true
            use_at_place_self = true
        end
    end

    if inv_runes_contains["magikacia:rune_absolute_solver"] then
        local base_pos = use_pos_above or use_pos_self
        if base_pos then
            for i = 0, -50, -5 do
                local pos = vector.offset(base_pos, 0, i, 0)
                if not minetest.is_protected(pos, placer:get_player_name()) then
                    magikacia.explode(pos, 2, {
                        drop_chance = 0,
                        particles = false,
                        fire = false,
                        sound = false,
                    }, placer, placer, "absolute_solver_secondary", not false)
                else
                    magikacia.radius_effect_func(pos, 2, placer, function(obj)
                        magikacia.deal_spell_damage(obj, 20 * cores_multipliers.damage, "absolute_solver_secondary", placer)
                    end)
                end
            end
            magikacia.spawn_effect_anim({
                pos = base_pos,
                texture = "effect_absolute_solver_secondary",
                size = 30,
            })
            use_success = true
            use_at_place_above = true
        end
    end

    if inv_runes_contains["magikacia:rune_summoning"] then
    end

    if inv_runes_contains["magikacia:rune_protection"] then
        local base_pos = use_pos_under or use_pos_self
        if base_pos then
            minetest.registered_chatcommands["area_pos2"].func(placer:get_player_name(), base_pos.x .. " " .. base_pos.y .. " " .. base_pos.z)
            magikacia.spawn_effect_anim({
                pos = base_pos,
                texture = "effect_vortex_blue",
            })
            use_success = true
            if base_pos == use_pos_under then
                use_at_place_under = true
            else
                use_at_place_self = true
            end
        end
    end

    if inv_runes_contains["magikacia:rune_bubble"] then
        if magikacia_bubbles then
            magikacia_bubbles.bubble_blower_secondary(itemstack, placer, pointed_thing)
            use_success = true
            use_at_place_above = true
        end
    end

    if inv_runes_contains["magikacia:rune_shield"] then
        if meta:get_int("magikacia:rune_shield_active") == 0 then
            --[[minetest.add_entity(pos, name, minetest.serialize({ owner=placer_name, }))]]
            meta:set_int("magikacia:rune_shield_active", 1)
        elseif meta:get_int("magikacia:rune_shield_active") == 1 then
            magikacia.radius_effect_func(use_pos_self, 5, placer, function(obj)
                magikacia.deal_spell_damage(obj, 10 * cores_multipliers.damage, "shield_secondary", placer)
                minetest.sound_play("mcl_block", { object = obj, max_hear_distance = 16, gain = 1, pitch = 0.5 }, true)
                obj:add_velocity(vector.offset(vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos_self)), 10), 0, 20, 0))
            end)
            meta:set_int("magikacia:rune_shield_active", 0)
        end
        use_success = true
        use_at_place_self = true
    end

    if use_pos_under and use_pos_above and inv_runes_contains["magikacia:rune_portal"] then
        local vel_change = nil
        local out_dir = vector.subtract(use_pos_above, use_pos_under)
        local primary_portal = magikacia.effect_portal_pairs[pname].primary
        if primary_portal then
            local primary_portal_out_dir = primay_portal.out_dir
            vel_change = vector.new(
                out_dir.x / primary_portal_out_dir.x,
                out_dir.y / primary_portal_out_dir.y,
                out_dir.z / primary_portal_out_dir.z,
            )
        end
        magikacia.effect_portal_pairs[pname].secondary = {
            pos = use_pos_above,
            out_dir = out_dir,
            vel_change = vel_change,
        }
    end

    if use_success then
        if use_at_self then
            minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_self, max_hear_distance = 32, gain = 0.5 }, true)
        end
        if use_at_place_above then
            minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_above, max_hear_distance = 32, gain = 0.5 }, true)
        end
        if use_at_place_under then
            minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_under, max_hear_distance = 32, gain = 0.5 }, true)
        end
    end

    return nil
end

function magikacia.register_bag(name, bagtable)
    minetest.register_tool(":" .. name, {
        description = bagtable.description,
        inventory_image = bagtable.inventory_image,
        groups = { spellbook = 1, enchanted = 1 },
        on_secondary_use = function(itemstack, user, pointed_thing)
            return spellbook_use_secondary(itemstack, user, pointed_thing, bagtable)
        end,
        on_place = function(itemstack, placer, pointed_thing)
            return spellbook_use_secondary(itemstack, placer, pointed_thing, bagtable)
        end,
        on_use = function(itemstack, user, pointed_thing)
            return spellbook_use_primary(itemstack, user, pointed_thing)
        end,
        on_drop = function(itemstack, dropper, pos)
            return magikacia.on_drop_bag(itemstack, dropper, pos)
        end,
        range = bagtable.range,
    })
    local s = "_magikacia_spellbook_init_" .. name:gsub("[^a-zA-Z0-9]", "") .. "_C_"
    if not mcl_util[s] then
        mcl_util[s] = true
        if not mcl_util._magikacia_spellbook_init then
            minetest.register_on_player_receive_fields(function(player, formname, fields)
                local nisformn = string.find(formname, name .. "_C_")
                if nisformn == 1 then
                    if fields.quit then
                        player, fields, name, formname, sound = magikacia.on_close_bag(player, fields, name, formname,
                            bagtable.sound_close)
                        if bagtable.sound_close then
                            minetest.sound_play(sound, { gain = 0.8, object = player, max_hear_distance = 5 })
                        end
                    end
                end
                return
            end)
            if name:find("spellbook_") then
                minetest.register_alias(string.gsub(name, "spellbook", "gauntlet"), name)
            end
        end
    end
end

local color_list = {
    mcl_colors.DARK_GREEN,
    mcl_colors.RED,
    mcl_colors.AQUA,
}
local function c(color_id, text)
    return minetest.colorize(color_list[color_id], text)
end
function magikacia.wrapper_register_spellbook(def)
    local namelower = def.name:lower()
    magikacia.register_bag("magikacia:spellbook_" .. namelower, {
        description = table.concat({
            c(3, def.name .. " Magikacia Spellbook"),
            c(1, "Range: ") .. c(3, def.range .. " blocks"),
            c(1, "Inventory Spaces - Main: ") .. c(3, def.width_main * def.height_main),
            c(1, "Inventory Spaces - Cores: ") .. c(3, def.width_cores * def.height_cores),
            c(2, "WARNING: Still in development! Items inside may dissapear or be corrupted!"),
        }, "\n"),
        inventory_image = magikacia.textures["spellbook_" .. namelower .. "_inv"],
        width_main = def.width_main,
        height_main = def.height_main,
        sound_open = "magikacia_open_bag",
        sound_close = "magikacia_close_bag",
        range = def.range,
        width_cores = def.width_cores,
        height_cores = def.height_cores,
    })
end

magikacia.wrapper_register_spellbook({
    name = "Leather",
    width_main = 1,
    height_main = 1,
    range = 4,
    width_cores = 0,
    height_cores = 0,
})
magikacia.wrapper_register_spellbook({
    name = "Iron",
    width_main = 2,
    height_main = 1,
    range = 8,
    width_cores = 1,
    height_cores = 1,
})
magikacia.wrapper_register_spellbook({
    name = "Gold",
    width_main = 3,
    height_main = 1,
    range = 16,
    width_cores = 1,
    height_cores = 1,
})
magikacia.wrapper_register_spellbook({
    name = "Diamond",
    width_main = 5,
    height_main = 1,
    range = 32,
    width_cores = 1,
    height_cores = 2,
})
magikacia.wrapper_register_spellbook({
    name = "Netherite",
    width_main = 5,
    height_main = 2,
    range = 64,
    width_cores = 1,
    height_cores = 2,
})
magikacia.register_bag("magikacia:gauntlet_admin", {
    description = table.concat({
        c(3, "Magikacia Admin Gauntlet"),
        c(1, "Range: ") .. c(3, "128 blocks"),
        c(2, "WARNING: Still in development! Items inside may dissapear or be corrupted!"),
    }, "\n"),
    inventory_image = magikacia.textures.gauntlet_netherite_inv .. mcl_enchanting.overlay,
    width_main = 7,
    height_main = 3,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 128,
    width_cores = 1,
    height_cores = 3,
})
minetest.register_alias("magikacia:gauntlet", "magikacia:gauntlet_admin")

minetest.register_tool(":magikacia:spellbook_transporting_bag", {
    description = "Spellbook Transporting Bag",
    inventory_image = magikacia.textures.spellbook_transporting_bag_inv,
    groups = { bag = 1, bag_bag = 1 },

    on_secondary_use = function(itemstack, user)
        return open_bag(itemstack, user, 2, 2, "magikacia_open_bag", 0, 0)
    end,
    on_place = function(itemstack, placer, pointed_thing)
        return open_bag(itemstack, placer, 2, 2, "magikacia_open_bag", 0, 0)
    end,
    on_use = function(itemstack, user, pointed_thing)
        return magikacia.on_use_bag(itemstack, user, pointed_thing)
    end,
    on_drop = function(itemstack, dropper, pos)
        return magikacia.on_drop_bag(itemstack, dropper, pos)
    end
})
minetest.register_alias("magikacia:gauntlet_transporting_bag", "magikacia:spellbook_transporting_bag")

magikacia.register_on_player_receive_fields("magikacia_on_close_bag", function(player, formname, fields)
    local nisformn = string.find(formname, "magikacia:bag_transporting_bag_C_")
    if nisformn == 1 then
        if fields.quit then
            player, fields, name, formname, sound = magikacia.on_close_bag(player, fields, name, formname,
                "magikacia_close_bag")
            minetest.sound_play(sound, { gain = 0.8, object = player, max_hear_distance = 5 })
        end
    end
end)

if not mcl_util._magikacia_spellbook_init then
    mcl_util._magikacia_spellbook_init = true
end
