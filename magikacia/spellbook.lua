local modname = "magikacia"
local vector = vector
local minetest = minetest
local magikacia = magikacia

local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local spellbook_types = {
    "iron",
    "gold",
    "diamond",
    "netherite",
}

mcl_util._magikacia_spellbook_init = mcl_util._magikacia_spellbook_init or false

local resize_max_size = 80

local static_objs = {
    "mcl_chests:chest",
    "mcl_itemframes:item",
    "mcl_enchanting:book",
}
function magikacia.is_obj_not_static(obj)
    if not obj then
        return
    end
    if obj:is_player() then
        return true
    end
    local le = obj:get_luaentity()
    if not le then
        return
    end
    if not le then
        return false
    end
    for _, name in ipairs(static_objs) do
        if name == obj:get_luaentity().name then
            return false
        end
    end
end

function magikacia.safe_replace(pos, node_name, placer)
    if not pos then return end
    local node = minetest.get_node(pos)
    if node and (node.name == "air" or minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].buildable_to == true) and not minetest.is_protected(pos, placer:get_player_name()) then
        minetest.swap_node(pos, { name = node_name })
    end
end

local runes = {
    "earth",
    "electric",
    "fire",
    "ice",
    "telepathic",
    "void",
    "water",
    "wind",
}



local function deal_spell_damage(obj, damage, typename, source)
    mcl_util.deal_damage(obj, 20, { type = "magikacia_spell_" .. typename, source = source, direct = source })
end





local rng = PcgRandom(32321123312123)

local function lightning_strike(pos, user)
    if not pos then
        return false
    end
    local do_strike = true
    if mcl_lightning.on_strike_functions then
        for _, func in pairs(mcl_lightning.on_strike_functions) do
            local objects = minetest.get_objects_inside_radius(pos, 3.5)
            local p, stop = pcall(function() return func(pos, pos, objects) end)
        end
    end

    local particle_pos = vector.offset(pos, 0, (mcl_lightning.size / 2) + 0.5, 0)
    local time = 0.2
    local particle_size = mcl_lightning.size * 10
    minetest.add_particlespawner({
        amount = 1,
        time = time,
        minpos = particle_pos,
        maxpos = particle_pos,
        minexptime = time,
        maxexptime = time,
        minsize = particle_size,
        maxsize = particle_size,
        collisiondetection = true,
        vertical = true,
        texture = "lightning_lightning_" .. rng:next(1, 3) .. ".png",
        glow = minetest.LIGHT_MAX,
    })

    minetest.sound_play({ name = "lightning_thunder", gain = 10 }, { pos = pos, max_hear_distance = 500 }, true)

    local objects = minetest.get_objects_inside_radius(pos, 3.5)
    for _, obj in pairs(objects) do
        if obj:is_player() and obj:get_player_name() ~= user:get_player_name() or obj:get_luaentity() then
            local lua = obj:get_luaentity()
            if lua then
                if not lua._on_lightning_strike or (lua._on_lightning_strike and lua._on_lightning_strike(lua, pos, pos, objects) ~= true) then
                    deal_spell_damage(obj, 5, "electric_primary", user)
                end
            else
                deal_spell_damage(obj, 5, "electric_primary", user)
            end
        end
    end

    for _, npos in pairs(minetest.find_nodes_in_area(vector.offset(pos, -5, -5, -5), vector.offset(pos, 5, 5, 5), { "group:affected_by_lightning" })) do
        local node = minetest.get_node(npos)
        if node then
            local def = minetest.registered_nodes[node.name]
            if def and def._on_lightning_strike then
                pcall(function()
                    def._on_lightning_strike(npos, pos, pos)
                end)
            end
        end
    end


    pos.y = pos.y + 1 / 2
    local node = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })
    if node and minetest.get_item_group(node.name, "liquid") < 1 then
        local posnode = minetest.get_node(pos)
        if posnode and posnode.name == "air" then
            if rng:next(1, 100) <= 3 then
                local sh = minetest.add_entity(pos, "mobs_mc:skeleton_horse")
                if sh then
                    local le = sh:get_luaentity()
                    if le then
                        le.owner = (user and user:is_player() and user:get_player_name()) or nil
                        le.tamed = true
                    end
                end

                local angle, posadd
                angle = math.random(0, math.pi * 2)
                for _ = 1, 3 do
                    posadd = { x = math.cos(angle), y = 0, z = math.sin(angle) }
                    posadd = vector.normalize(posadd)
                    local mob = minetest.add_entity(vector.add(pos, posadd), "mobs_mc:skeleton")
                    if mob then
                        mob:set_yaw(angle - math.pi / 2)
                        local le = mob:get_luaentity()
                        if le then
                            le.owner = (user and user:is_player() and user:get_player_name()) or ""
                        end
                    end
                    angle = angle + (math.pi * 2) / 3
                end
            end
        end
    end
end



local around_plus_pos_list = {
    { 0,  0 },
    { 1,  0 },
    { 0,  1 },
    { -1, 0 },
    { 0,  -1 },
}
local function spawn_effect_anim(def)
    if not def.pos then return end
    minetest.add_particle({
        pos = def.pos,
        velocity = { x = 0, y = 0, z = 0 },
        acceleration = { x = 0, y = 0, z = 0 },
        expirationtime = def.duration_total or 2,
        size = def.size or 25,
        collisiondetection = false,
        collision_removal = false,
        object_collision = false,
        vertical = false,
        texture = {
            name = magikacia.textures[def.texture] or "blank.png",
        },
        animation = {
            type = "vertical_frames",
            aspect_w = 32,
            aspect_h = 32,
            length = def.duration_anim or 0.25,
        },
        glow = (def.glow ~= nil and def.glow) or 14,
        attached = def.attached or nil
    })
end



local mod_target = minetest.get_modpath("mcl_target")





minetest.register_node(":magikacia:fire_temp", {
    description = "Temporary Fire",
    drawtype = "firelike",
    tiles = {
        {
            name = "fire_basic_flame_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1
            },
        },
    },
    inventory_image = "fire_basic_flame.png",
    paramtype = "light",
    light_source = minetest.LIGHT_MAX,
    walkable = false,
    buildable_to = true,
    sunlight_propagates = true,
    damage_per_second = 1,
    groups = { fire = 1, dig_immediate = 3, not_in_creative_inventory = 0, dig_by_piston = 1, destroys_items = 1, set_on_fire = 8, unsticky = 1 },
    floodable = true,
    on_flood = function(pos, _, newnode)
        if minetest.get_item_group(newnode.name, "water") ~= 0 then
            minetest.sound_play("fire_extinguish_flame", { pos = pos, gain = 0.25, max_hear_distance = 16 }, true)
        end
    end,
    drop = "",
    sounds = {},
    on_construct = function(pos)
        local timer = minetest.get_node_timer(pos)
        timer:start(5)
    end,
    on_timer = function(pos)
        if minetest.get_node(pos).name == "magikacia:fire_temp" then
            minetest.sound_play("fire_extinguish_flame", { pos = pos, gain = 0.25, max_hear_distance = 16 }, true)
            minetest.swap_node(pos, { name = "air" })
        end
    end,
})


local function get_formspec(name, width, height)
    local spellbook_inv_formspec = table.concat({
        "formspec_version[4]",
        "size[11.75,10.425]",

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


local function has_in_spellbook(itemstack, player, itemname)
    if not player or not itemstack then return nil end

    local meta = itemstack:get_meta()
    local invmetastring = meta:get_string("magikacia_inv_content")
    if invmetastring ~= "" then
        local t = assert(minetest.deserialize(invmetastring).main)

        for i, v in pairs(t) do
            if v.name == itemname then return true end
        end
    end
    return false
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

local function save_bag_inv(inv, player)
    local playerinv = minetest.get_inventory { type = "player", name = player:get_player_name() }
    local bag_id = inv:get_location().name
    local listname = "main"
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

local function radius_effect_func(pos, radius, placer, func, include_placer)
    for obj, _ in minetest.objects_inside_radius(pos, radius) do
        if obj then
            local obj_is_player = obj:is_player()
            if (obj:get_luaentity() ~= nil and magikacia.is_obj_not_static(obj))
                or (obj_is_player and (include_placer or obj:get_player_name() ~= placer:get_player_name()))
            then
                if func then
                    func(obj, obj_is_player)
                end
            end
        end
    end
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

    local is_placer_sneaking = false
    if placer:is_player() then
        local placer_name = placer:get_player_name()
        if controls.players[placer_name].sneak[1] then
            is_placer_sneaking = true
        end
    end


    if has_in_spellbook(itemstack, placer, modname .. ":rune_earth") then
        local offset = placer:get_look_dir()
        for i = 1, 5 do
            local pos = vector.add(vector.offset(use_pos_self, 0, placer:get_properties().eye_height * 0.7, 0),
                vector.multiply(offset, i))
            radius_effect_func(use_pos_above, 2, placer, function(obj)
                deal_spell_damage(obj, 3, "earth_primary", placer)
            end)
            spawn_effect_anim({
                pos = pos,
                texture = "effect_earth_primary",
                duration_total = 0.4,
                duration_anim = 0.4,
            })
        end
        use_success = true
        use_at_self = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_electric") then
        lightning_strike(vector.offset(use_pos_above, 0, -1, 0), placer)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_fire") then
        for _, k in ipairs(around_plus_pos_list) do
            magikacia.safe_replace({ x = use_pos_above.x + k[1], y = use_pos_above.y, z = use_pos_above.z + k[2] },
                "magikacia:fire_temp",
                placer)
        end
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_fire_primary",
        })
        mcl_potions.fire_resistance_func(placer, nil, 10)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_ice") then
        radius_effect_func(use_pos_above, 3, placer, function(obj)
            mcl_potions.swiftness_func(obj, -1, 3)
            mcl_potions.leaping_func(obj, -1, 3)
        end)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_telepathic") then
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
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_water") then
        radius_effect_func(use_pos_above, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                deal_spell_damage(obj, 5, "water_primary", placer)
            end
            mcl_burning.extinguish(obj)
        end, true)

        local nodes, node_counts = minetest.find_nodes_in_area(vector.offset(use_pos_above, -3, -3, -3),
            vector.offset(use_pos_above, 3, 3, 3), "group:fire", false)
        if nodes then
            minetest.bulk_set_node(nodes, { name = "air" })
        end

        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_water_primary",
            size = 30,
            duration_total = 0.4,
            duration_anim = 0.4,
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_void") then
        radius_effect_func(use_pos_above, 2, placer, function(obj)
            deal_spell_damage(obj, 20, "void_primary", placer)
        end)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_void_primary",
            duration_total = 0.5,
            duration_anim = 0.5,
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_wind") then
        radius_effect_func(use_pos_above, 8, placer, function(obj)
            local newvel = vector.offset(
                vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos_above)), 10), 0, 15, 0)
            obj:add_velocity(newvel)
        end, true)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_disguise") then
        entity_modifier.disguise_tool_primary(itemstack, placer, pointed_thing)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_resize") then
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
                    spawn_effect_anim({
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
            if vs and vs <= resize_max_size then
                entity_modifier.resize_player(
                    placer,
                    vs,
                    0.1,
                    resize_max_size
                )
                spawn_effect_anim({
                    pos = use_pos_self,
                    texture = "effect_vortex_blue",
                    size = 15,
                })
            end
            use_success = true
            use_at_place_self = true
        end
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_poison") then
        radius_effect_func(use_pos_above, 3, placer, function(obj, obj_is_player)
            if obj_is_player then
                mcl_potions.poison_func(obj, 1, 3)
            end
        end)
        magikacia.spawn_linger_particles(use_pos_above, 3, magikacia.textures.effect_poison_particles)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_healing") then
        radius_effect_func(use_pos_above, 3, placer, function(obj)
            mcl_potions.regeneration_func(obj, 1, 3)
            mcl_potions.healing_func(obj, 6)
        end, true)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_nature") then
        magikacia.bone_meal(itemstack, placer, pointed_thing)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_under and has_in_spellbook(itemstack, placer, modname .. ":rune_protection") then
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
    if has_in_spellbook(itemstack, placer, modname .. ":rune_earth") and spell_earth_time_active == 0 then
        meta:set_float("magikacia:spell_earth_time_active", spell_earth_time_active + 1)
        placer:add_velocity({ x = 0, y = 15, z = 0 })
        spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_earth_secondary",
        })
        use_success = true
        use_at_self = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_electric") then
    end

    if has_in_spellbook(itemstack, placer, modname .. ":rune_fire") then
        mcl_potions.fire_resistance_func(placer, nil, 10)
        mcl_throwing.get_player_throw_function("magikacia:throwable_attack_fire_secondary_entity")(
            ItemStack("magikacia:throwable_attack_fire_secondary", 64), placer, pointed_thing)
        use_success = true
    end

    if has_in_spellbook(itemstack, placer, modname .. ":rune_ice") then
        mcl_throwing.get_player_throw_function("magikacia:throwable_attack_ice_secondary_entity")(
            ItemStack("magikacia:throwable_attack_ice_secondary", 64), placer, pointed_thing)
        use_success = true
    end

    if has_in_spellbook(itemstack, placer, modname .. ":rune_telepathic") then
        minetest.show_formspec(placer:get_player_name(), "mcl_chests:ender_chest_" .. placer:get_player_name(),
            formspec_ender_chest)
        spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_self = true
    end

    if has_in_spellbook(itemstack, placer, modname .. ":rune_water") then
        radius_effect_func(use_pos_self, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                deal_spell_damage(obj, 10, "water_secondary", placer)
            end
            mcl_burning.extinguish(obj)
        end, true)
        placer:add_player_velocity(vector.multiply(placer:get_look_dir(), 30))

        local nodes, node_counts = minetest.find_nodes_in_area(vector.offset(use_pos_self, -3, -3, -3),
            vector.offset(use_pos_self, 3, 3, 3), "group:fire", true)
        if nodes then
            minetest.bulk_set_node(nodes, { name = "air" })
        end

        spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_water_secondary",
            attached = placer
        })
        use_success = true
        use_at_self = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_void") then
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
                                deal_spell_damage(obj, 20, "void_secondary", placer)
                            end
                        end
                    end
                end, time, victim)
            end
        end
        radius_effect_func(use_pos_above, 3, placer, function(obj)
            suck(5, obj)
        end)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_void_secondary",
            duration_total = 5,
            duration_anim = 0.5,
            size = 40,
        })
        use_success = true
        use_at_place_above = true
    end
    if has_in_spellbook(itemstack, placer, modname .. ":rune_water") then
        radius_effect_func(use_pos_self, 3, placer, function(obj)
            if not (obj:is_player() and obj:get_player_name() == placer:get_player_name()) then
                deal_spell_damage(obj, 10, "water_secondary", placer)
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

        spawn_effect_anim({
            pos = use_pos_self,
            texture = "effect_water_secondary",
            attached = placer
        })
        use_success = true
        use_at_self = true
    end

    if use_pos_above and has_in_spellbook(itemstack, placer, modname .. ":rune_wind") then
        radius_effect_func(use_pos_above, 8, placer, function(obj)
            local newvel = vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos_above)), -10)
            obj:add_velocity(newvel)
        end, true)
        spawn_effect_anim({
            pos = use_pos_above,
            texture = "effect_vortex_blue",
        })
        use_success = true
        use_at_place_above = true
    end

    if entity_modifier and has_in_spellbook(itemstack, placer, modname .. ":rune_disguise") then
        entity_modifier.disguise_tool_secondary(itemstack, placer, pointed_thing)
        spawn_effect_anim({
            pos = use_pos_above or use_pos_self,
            texture = "effect_vortex_blue",
        })
        use_success = true
        --[[use_at_place_above = true]]
    end

    if entity_modifier and has_in_spellbook(itemstack, placer, modname .. ":rune_resize") then
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
                    spawn_effect_anim({
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
                spawn_effect_anim({
                    pos = use_pos_self,
                    texture = "effect_vortex_blue",
                    size = 15,
                })
            end
            use_success = true
            use_at_place_self = true
        end
    end

    if entity_modifier and has_in_spellbook(itemstack, placer, modname .. ":rune_summoning") then
    end

    if use_pos_under and has_in_spellbook(itemstack, placer, modname .. ":rune_protection") then
        minetest.registered_chatcommands["area_pos"].func(placer:get_player_name(),
            use_pos_under.x .. " " .. use_pos_under.y .. " " .. use_pos_under.z)
        spawn_effect_anim({
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
