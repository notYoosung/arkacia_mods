local modname = "magikacia"
local vector = vector
local minetest = minetest
local magikacia = magikacia

local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local resize_max_size = 80

local spellbook_types = {
    "iron",
    "gold",
    "diamond",
    "netherite",
}

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
            local t = assert(minetest.deserialize(invmetastring)[listname])

            for i, v in pairs(t) do
                if v.name == itemname then return true end
            end
        end
        return false
    end,
}



local function get_formspec(name, width, height)
    local spellbook_inv_formspec = table.concat({
        "formspec_version[4]",
        "size[11.75,10.425]",

        "label[3.125,0.375;" .. F(C(mcl_formspec.label_color, S("Modifier"))) .. "]",

        mcl_formspec.get_itemslot_bg_v4(3.125, 0.75, 1, 1),
        "list[detached:" .. name .. ";modifiers;3.125,0.75;" .. 1 .. "," .. 1 .. ";]",

        "label[4.125,0.375;" .. F(C(mcl_formspec.label_color, S("Magic Inventory"))) .. "]",

        mcl_formspec.get_itemslot_bg_v4(4.125, 0.75, width, height),
        "list[detached:" .. name .. ";main;4.125,0.75;" .. width .. "," .. height .. ";]",

        "label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",

        mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
        "list[current_player;main;0.375,5.1;9,3;9]",

        mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
        "list[current_player;main;0.375,9.05;9,1;]",

        "listring[current_player;main]",
        "listring[detached:" .. name .. ";main]",
    })
    return spellbook_inv_formspec
end

local function inv_to_table(inv)
    local t = {}
    for listname, list in pairs(inv:get_lists()) do
        local size = inv:get_size(listname)
        if size then
            t[listname] = {}
            for i = 1, size, 1 do
                t[listname][i] = inv:get_stack(listname, i):to_table()
            end
        end
    end
    return t
end

local function table_to_inv(inv, t)
    for listname, list in pairs(t) do
        for i, stack in pairs(list) do
            inv:set_stack(listname, i, stack)
        end
    end
end


local function has_in_spellbook_inv_main(itemstack, player, itemname)
    return magikacia.inv.has_in(itemstack, player, itemname, "main")
end
local function has_in_spellbook_inv_modifiers(itemstack, player, itemname)
    return magikacia.inv.has_in(itemstack, player, itemname, "modifiers")
end


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

local function save_bag_inv_itemstack(inv, stack)
    stack, inv = magikacia.on_change_bag_inv(stack, inv)
    local meta = stack:get_meta()
    meta:set_string("magikacia_inv_content", minetest.serialize(inv_to_table(inv)))
    return stack
end

local function save_bag_inv(inv, player, listname)
    local playerinv = minetest.get_inventory { type = "player", name = player:get_player_name() }
    local bag_id = inv:get_location().name
    listname = listname or "main"
    local size = playerinv:get_size(listname)
    for i = 1, size, 1 do
        local stack = playerinv:get_stack(listname, i)
        local meta = stack:get_meta()
        if meta:get_string("magikacia_bag_identity") == bag_id then
            stack = save_bag_inv_itemstack(inv, stack)
            playerinv:set_stack(listname, i, stack)
        end
    end
end

local mod_storage = {}
local function create_invname(itemstack)
    local counter = mod_storage["counter"] or 0
    counter = counter + 1
    mod_storage["counter"] = counter
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

local function open_bag(itemstack, user, width, height, sound)
    itemstack, user, width, height, sound = magikacia.before_open_bag(itemstack, user, width, height, sound)
    local allow_bag_input = false
    if minetest.get_item_group(itemstack:get_name(), "bag_bag") > 0 then
        allow_bag_input = true
    end
    local meta = itemstack:get_meta()
    local playername = user:get_player_name()
    local invname = meta:get_string("magikacia_bag_identity")


    if invname == "" then
        local item_count = itemstack:get_count()
        if item_count > 1 then
            local newitemstack = itemstack:take_item(item_count - 1)
            minetest.after(0.01, stack_to_player_inv, newitemstack, user)
        end
        invname = create_invname(itemstack)
        meta:set_string("magikacia_bag_identity", invname)
    end

    meta:set_int("magikacia_width", width)
    meta:set_int("magikacia_height", height)
    meta:set_int("magikacia_width_modifiers", width)
    meta:set_int("magikacia_height_modifiers", height)

    local inv = minetest.create_detached_inventory(invname, {
        allow_put = function(inv, listname, index, stack, player)
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
            save_bag_inv(inv, player)
        end,
        on_put = function(inv, listname, index, stack, player)
            save_bag_inv(inv, player)
        end,
        on_take = function(inv, listname, index, stack, player)
            local size = inv:get_size(listname)
            for i = 1, size, 1 do
                local stack = inv:get_stack(listname, i)
                local remove_stack = false
                if allow_bag_input then
                    if minetest.get_item_group(stack:get_name(), "bag_bag") > 0 then
                        remove_stack = true
                    end
                else
                    if minetest.get_item_group(stack:get_name(), "bag") > 0 then
                        remove_stack = true
                    end
                end
                if remove_stack == true then
                    inv:set_stack(listname, i, "")
                    local playerinv = player:get_inventory()
                    if playerinv:room_for_item("main", stack) then
                        playerinv:add_item("main", stack)
                    else
                        minetest.item_drop(save_bag_inv_itemstack(inv, stack), player, player:get_pos())
                        minetest.close_formspec(player:get_player_name(), inv:get_location().name)
                    end
                end
            end
            save_bag_inv(inv, player)
        end,
    }, playername)
    inv:set_size("main", width * height)
    local invmetastring = meta:get_string("magikacia_inv_content")
    if invmetastring ~= "" then
        table_to_inv(inv, minetest.deserialize(invmetastring))

        itemstack, inv, user = magikacia.on_open_bag(itemstack, inv, user)
        save_bag_inv_itemstack(inv, itemstack)
    end

    if sound then
        minetest.sound_play(sound, { gain = 0.8, object = user, max_hear_distance = 5 })
    end
    minetest.show_formspec(playername, invname, get_formspec(invname, width, height))
    return itemstack
end

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

function spellbook_use_primary(itemstack, placer, pointed_thing)
    if not placer then return nil end
    local use_pos_self = placer:get_pos()
    local meta = placer:get_meta()
    local use_pos_above = nil
    local use_pos_under = nil
    local pointed_obj = nil
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

    local core_type = magikacia.get_core

    local is_placer_sneaking = false
    if placer:is_player() then
        local placer_name = placer:get_player_name()
        if controls.players[placer_name].sneak[1] then
            is_placer_sneaking = true
        end
    end


    if has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_earth") then
        local offset = placer:get_look_dir()
        for i = 1, 5 do
            local pos = vector.add(vector.offset(use_pos_self, 0, placer:get_properties().eye_height * 0.7, 0),
                vector.multiply(offset, i))
            if use_pos_above then
                magikacia.radius_effect_func(use_pos_above, 2, placer, function(obj)
                    magikacia.deal_spell_damage(obj, 3, "earth_primary", placer)
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

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_electric") then
        local electric_primary_success = false
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            if magikacia.tase(placer, obj) then
                electric_primary_success = true
            end
        end)
        if electric_primary_success then
            magikacia.spawn_effect_anim({
                pos = use_pos_above,
                texture = "effect_electric_primary",
            })
            use_success = true
            use_at_place_above = true
        end
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_fire") then
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

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_ice") then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            mcl_potions.swiftness_func(obj, -1, 3)
            mcl_potions.leaping_func(obj, -1, 3)
        end)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_telepathic") then
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

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_water") then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                magikacia.deal_spell_damage(obj, 5, "water_primary", placer)
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

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_void") then
        magikacia.radius_effect_func(use_pos_above, 2, placer, function(obj)
            magikacia.deal_spell_damage(obj, 20, "void_primary", placer)
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

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_wind") then
        magikacia.radius_effect_func(use_pos_above, 8, placer, function(obj)
            local newvel = vector.offset(
                vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos_above)), 10), 0, 15, 0)
            obj:add_velocity(newvel)
        end, true)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_disguise") then
        entity_modifier.disguise_tool_primary(itemstack, placer, pointed_thing)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_resize") then
        if pointed_obj then
            local vs = get_visual_size(pointed_obj) * 1.1
            if vs and vs <= resize_max_size then
                entity_modifier.resize(
                    pointed_obj,
                    vs,
                    0.1,
                    resize_max_size
                )
                if use_pos_above then
                    magikacia.spawn_effect_anim({
                        pos = use_pos_above,
                        texture = "effect_vortex_blue",
                        size = 15,
                    })
                    use_at_place_above = true
                end
            end
            use_success = true
        else
            local vs = get_visual_size(placer) * 1.1
            if vs and (is_gauntlet_admin or vs <= resize_max_size) then
                entity_modifier.resize_player(
                    placer,
                    vs,
                    0.1,
                    is_gauntlet_admin or resize_max_size
                )
                magikacia.spawn_effect_anim({
                    pos = use_pos_self,
                    texture = "effect_vortex_blue",
                    size = 15,
                })
            end
            use_success = true
            use_at_place_self = true
        end
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_poison") then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj, obj_is_player)
            if obj_is_player then
                mcl_potions.poison_func(obj, 1, 3)
            end
        end)
        magikacia.spawn_linger_particles(use_pos_above, 3, magikacia.textures.effect_poison_particles)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_healing") then
        magikacia.radius_effect_func(use_pos_above, 3, placer, function(obj)
            mcl_potions.regeneration_func(obj, 1, 3)
            mcl_potions.healing_func(obj, 6)
        end, true)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_nature") then
        magikacia.bone_meal(itemstack, placer, pointed_thing)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_under and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_protection") then
        minetest.registered_chatcommands["area_pos1"].func(placer:get_player_name(),
            use_pos_under.x .. " " .. use_pos_under.y .. " " .. use_pos_under.z)
        use_success = true
        use_at_place_under = true
    end

    if use_success then
        minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_above, max_hear_distance = 64, gain = 0.5 }, true)
    end

    return magikacia.on_use_bag(itemstack, placer, pointed_thing)
end

local spellbook_use_secondary = function(itemstack, placer, pointed_thing, bagtable)
    if not placer then return nil end
    local use_pos_self = placer:get_pos()
    local meta = placer:get_meta()
    local use_pos_above = nil
    local use_pos_under = nil
    local pointed_obj = nil
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


    if placer:is_player() then
        local placer_name = placer:get_player_name()
        if controls.players[placer_name].sneak[1] then
            return open_bag(itemstack, placer, bagtable.width, bagtable.height, bagtable.sound_open)
        end
    end


    local spell_earth_time_active = meta:get_float("magikacia:spell_earth_time_active")
    if has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_earth") and spell_earth_time_active == 0 then
        meta:set_float("magikacia:spell_earth_time_active", spell_earth_time_active + 1)
        placer:add_velocity({ x = 0, y = 15, z = 0 })
        magikacia.spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_earth_secondary",
        })
        use_success = true
        use_at_self = true
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_electric") then
        magikacia.lightning_strike(vector.offset(use_pos_above, 0, -1, 0), placer)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_fire") then
        mcl_potions.fire_resistance_func(placer, nil, 10)
        mcl_throwing.get_player_throw_function("magikacia:throwable_attack_fire_secondary_entity")(
            ItemStack("magikacia:throwable_attack_fire_secondary", 64), placer, pointed_thing)
        use_success = true
    end

    if has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_ice") then
        mcl_throwing.get_player_throw_function("magikacia:throwable_attack_ice_secondary_entity")(
            ItemStack("magikacia:throwable_attack_ice_secondary", 64), placer, pointed_thing)
        use_success = true
    end

    if has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_telepathic") then
        --[[minetest.show_formspec(placer:get_player_name(), "mcl_chests:ender_chest_" .. placer:get_player_name(), formspec_ender_chest)]]
        magikacia.random_teleport_obj(placer)
        magikacia.spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_self = true
    end

    if has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_water") then
        magikacia.radius_effect_func(use_pos_self, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                magikacia.deal_spell_damage(obj, 10, "water_secondary", placer)
            end
            mcl_burning.extinguish(obj)
        end, true)
        local node = minetest.get_node(vector.offset(use_pos_self, 0, 0.5, 0))
        if minetest.get_item_group(node.name, "water") > 0 or (mcl_weather.rain.raining and mcl_weather.is_outdoor(use_pos_self) and mcl_weather.has_rain(use_pos_self)) then
            placer:add_player_velocity(vector.multiply(placer:get_look_dir(), 30))
        end

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
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_void") then
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
                                magikacia.deal_spell_damage(obj, 20, "void_secondary", placer)
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
    if has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_water") then
        magikacia.radius_effect_func(use_pos_self, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                magikacia.deal_spell_damage(obj, 10, "water_secondary", placer)
            end
            mcl_burning.extinguish(obj)
        end, true)
        placer:add_player_velocity(vector.multiply(placer:get_look_dir(), 30))
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
    end

    if use_pos_above and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_wind") then
        magikacia.radius_effect_func(use_pos_above, 8, placer, function(obj)
            local newvel = vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), vector.offset(use_pos_above, 0, -0.5, 0))), -10)
            obj:add_velocity(newvel)
        end, true)
        magikacia.spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_disguise") then
        entity_modifier.disguise_tool_secondary(itemstack, placer, pointed_thing)
        magikacia.spawn_effect_anim({
            pos = use_pos_above or use_pos_self,
            texture = "effect_vortex_blue",
        })
        use_success = true
        --[[use_at_place_above = true]]
    end

    if entity_modifier and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_resize") then
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
                        texture = "effect_vortex_blue",
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
                    texture = "effect_vortex_blue",
                    size = 15,
                })
            end
            use_success = true
            use_at_place_self = true
        end
    end

    if entity_modifier and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_summoning") then
    end

    if use_pos_under and has_in_spellbook_inv_main(itemstack, placer, modname .. ":rune_protection") then
        minetest.registered_chatcommands["area_pos"].func(placer:get_player_name(),
            use_pos_under.x .. " " .. use_pos_under.y .. " " .. use_pos_under.z)
        magikacia.spawn_effect_anim({
            pos = use_pos_under,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_under = true
    end

    if use_success then
        minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_above, max_hear_distance = 64, gain = 0.5 }, true)
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

magikacia.register_bag("magikacia:spellbook_leather", {
    description = "Leather Magikacia Spellbook",
    inventory_image = magikacia.textures.spellbook_leather_inv,
    width = 1,
    height = 1,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 8,
})
magikacia.register_bag("magikacia:spellbook_iron", {
    description = "Iron Magikacia Spellbook",
    inventory_image = magikacia.textures.spellbook_iron_inv,
    width = 2,
    height = 1,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 8,
})

magikacia.register_bag("magikacia:spellbook_gold", {
    description = "Gold Magikacia Spellbook",
    inventory_image = magikacia.textures.spellbook_gold_inv,
    width = 3,
    height = 1,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 16,
})

magikacia.register_bag("magikacia:spellbook_diamond", {
    description = "Diamond Magikacia Spellbook",
    inventory_image = magikacia.textures.spellbook_diamond_inv,
    width = 5,
    height = 1,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 32,
})

magikacia.register_bag("magikacia:spellbook_netherite", {
    description = "Netherite Magikacia Spellbook",
    inventory_image = magikacia.textures.spellbook_netherite_inv,
    width = 5,
    height = 2,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 64,
})

magikacia.register_bag("magikacia:gauntlet", {
    description = "Magikacia Gauntlet",
    inventory_image = magikacia.textures.gauntlet_netherite_inv,
    width = 5,
    height = 3,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 128,
})

minetest.register_tool(":magikacia:spellbook_transporting_bag", {
    description = "Spellbook Transporting Bag",
    inventory_image = magikacia.textures.spellbook_transporting_bag_inv,
    groups = { bag = 1, bag_bag = 1 },

    on_secondary_use = function(itemstack, user)
        return open_bag(itemstack, user, 2, 2, "magikacia_open_bag")
    end,
    on_place = function(itemstack, placer, pointed_thing)
        return open_bag(itemstack, placer, 2, 2, "magikacia_open_bag")
    end,
    on_use = function(itemstack, user, pointed_thing)
        return magikacia.on_use_bag(itemstack, user, pointed_thing)
    end,
    on_drop = function(itemstack, dropper, pos)
        return magikacia.on_drop_bag(itemstack, dropper, pos)
    end
})
minetest.register_alias("magikacia:gauntlet_transporting_bag", "magikacia:spellbook_transporting_bag")

if not mcl_util._magikacia_spellbook_init then
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        local nisformn = string.find(formname, "magikacia:bag_transporting_bag_C_")
        if nisformn == 1 then
            if fields.quit then
                player, fields, name, formname, sound = magikacia.on_close_bag(player, fields, name, formname,
                    "magikacia_close_bag")
                minetest.sound_play(sound, { gain = 0.8, object = player, max_hear_distance = 5 })
            end
        end
        return
    end)
end

if not mcl_util._magikacia_spellbook_init then
    mcl_util._magikacia_spellbook_init = true
end
