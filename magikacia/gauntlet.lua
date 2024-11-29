local modname = "magikacia"
local vector = vector
local minetest = minetest

local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local gauntlet_types = {
    "iron",
    "gold",
    "diamond",
    "netherite",
}

mcl_util._magikacia_gauntlet_init = mcl_util._magikacia_gauntlet_init or false

local runes = {
    "earth",
    "electricity",
    "fire",
    "ice",
    "telepathic",
    "void",
    "water",
    "wind",
}
local function register_attack(name, def)
    local typename = "magikacia_spell_" .. name
    mcl_death_messages.messages[typename] = {
        magic = {
            plain = "@1 was killed by " .. def.title,
            assist = "@1 was killed by " .. def.title .. " whilst trying to escape @2",
            killer = "@1 was killed by @2 using " .. def.title,
            item = "@1 was killed by @2 using @3 with " .. def.title,
        },
    }
    mcl_damage.types[typename] = { bypasses_armor = false, bypasses_magic = false, bypasses_invulnerability = false, bypasses_totem = false }
end
register_attack("earth_primary", {
    title = "an earth  spell",
})
register_attack("earth_secondary", {
    title = "an earth  spell",
})

register_attack("electricity_primary", {
    title = "an electricity  spell",
})
register_attack("electricity_secondary", {
    title = "an electricity  spell",
})

register_attack("fire_primary", {
    title = "a fire  spell",
})
register_attack("_secondary", {
    title = "a fire  spell",
})

register_attack("ice_primary", {
    title = "an ice  spell",
})
register_attack("ice_secondary", {
    title = "an ice  spell",
})

register_attack("telepathic_primary", {
    title = "an telepathic  spell",
})
register_attack("telepathic_secondary", {
    title = "an telepathic  spell",
})

register_attack("void_primary", {
    title = "a void blast spell",
})

register_attack("void_secondary", {
    title = "a void vortex spell",
})
register_attack("water_primary", {
    title = "an water  spell",
})
register_attack("water_secondary", {
    title = "an water  spell",
})

register_attack("wind_primary", {
    title = "an wind  spell",
})
register_attack("wind_secondary", {
    title = "an wind  spell",
})

function mcl_bone_meal.add_bone_meal_particle(pos, def)
    if not def then
        def = {}
    end
    minetest.add_particlespawner({
        amount = def.amount or 10,
        time = def.time or 0.1,
        minpos = def.minpos or vector.subtract(pos, 0.5),
        maxpos = def.maxpos or vector.add(pos, 0.5),
        minvel = def.minvel or vector.new(-0.01, 0.01, -0.01),
        maxvel = def.maxvel or vector.new(0.01, 0.01, 0.01),
        minacc = def.minacc or vector.new(0, 0, 0),
        maxacc = def.maxacc or vector.new(0, 0, 0),
        minexptime = def.minexptime or 1,
        maxexptime = def.maxexptime or 4,
        minsize = def.minsize or 0.7,
        maxsize = def.maxsize or 2.4,
        texture = "mcl_particles_bonemeal.png^[colorize:#00EE00:125", 
        glow = def.glow or 1,
    })
end

local function bone_meal(itemstack, user, pointed_thing)
    local pname = user and user:get_player_name()
    local unode = minetest.get_node(pointed_thing.under)
    local anode = minetest.get_node(pointed_thing.above)
    local udef = minetest.registered_nodes[unode.name]
    local adef = minetest.registered_nodes[anode.name]
    if udef and udef._on_bone_meal then
        if pname and minetest.is_protected(pointed_thing.under, pname) then
            minetest.record_protection_violation(pointed_thing.under, pname)
            return
        end
        if udef._on_bone_meal(itemstack, user, pointed_thing, pointed_thing.under, unode) ~= false then
            mcl_bone_meal.add_bone_meal_particle(pointed_thing.under)
            mcl_bone_meal.add_bone_meal_particle(pointed_thing.above)
        end
    elseif adef and adef._on_bone_meal then
        if minetest.is_protected(pointed_thing.above, pname) then
            minetest.record_protection_violation(pointed_thing.above, pname)
            return
        end
        if adef._on_bone_meal(itemstack, user, pointed_thing, pointed_thing.above, anode) ~= false then
            mcl_bone_meal.add_bone_meal_particle(pointed_thing.above)
        end
    end
    return
end
local rng = PcgRandom(32321123312123)

local function lightning_strike(pos)
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
        local lua = obj:get_luaentity()
        if lua then
            if not lua._on_lightning_strike or (lua._on_lightning_strike and lua._on_lightning_strike(lua, pos, pos, objects) ~= true) then
                mcl_util.deal_damage(obj, 5, { type = "magikacia_spell_electricity_primary" })
            end
        else
            mcl_util.deal_damage(obj, 5, { type = "magikacia_spell_electricity_primary" })
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
                minetest.add_entity(pos, "mobs_mc:skeleton_horse")

                local angle, posadd
                angle = math.random(0, math.pi * 2)
                for _ = 1, 3 do
                    posadd = { x = math.cos(angle), y = 0, z = math.sin(angle) }
                    posadd = vector.normalize(posadd)
                    local mob = minetest.add_entity(vector.add(pos, posadd), "mobs_mc:skeleton")
                    if mob then
                        mob:set_yaw(angle - math.pi / 2)
                    end
                    angle = angle + (math.pi * 2) / 3
                end
            else
                minetest.set_node(pos, { name = "mcl_fire:fire" })
            end
        end
    end
end



local function safe_replace(pos, node_name, placer)
    local node = minetest.get_node(pos)
    if (node.name == "air" or minetest.registered_nodes[node.name].buildable_to == true) then
        minetest.place_node(pos, { name = node_name }, placer)
    end
end
local around_circle_3_pos_list = {
    { 0,  0 },
    { 1,  0 },
    { 0,  1 },
    { -1, 0 },
    { 0,  -1 },
}
local function spawn_effect_anim(pos, texture)
    minetest.add_particle({
        pos = pos,
        velocity = { x = 0, y = 0, z = 0 },
        acceleration = { x = 0, y = 0, z = 0 },
        expirationtime = 2,
        size = 25,
        collisiondetection = false,
        collision_removal = false,
        object_collision = false,
        vertical = false,
        texture = {
            name = magikacia.textures[texture],
        },
        animation = {
            type = "vertical_frames",
            aspect_w = 32,
            aspect_h = 32,
            length = 0.25,
        },
        glow = 14,
    })
end





local function get_formspec(name, width, height)
    local gauntlet_inv_formspec = table.concat({
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
    return gauntlet_inv_formspec
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


local function has_in_gauntlet(itemstack, player, itemname)
    
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

function gauntlet_use_primary(itemstack, placer, pointed_thing)
    if not placer then return nil end
    local meta = placer:get_meta()
    local use_pos_above = nil
    if pointed_thing.type == "node" then
        use_pos_above = pointed_thing.above
    elseif pointed_thing.type == "object" then
        use_pos_above = pointed_thing.ref:get_pos()
    end
    local use_pos_under = nil
    if pointed_thing.type == "node" then
        use_pos_under = pointed_thing.under
    elseif pointed_thing.type == "object" then
        use_pos_under = vector.offset(pointed_thing.ref:get_pos(), 0, -1, 0)
    end
    local use_success = false
    local use_at_place_above = false
    local use_at_place_under = false
    local use_at_self = false

    local spell_earth_time_active = meta:get_float("magikacia:spell_earth_time_active")
    if has_in_gauntlet(itemstack, placer, modname .. ":rune_earth") and spell_earth_time_active == 0 then
        meta:set_float("magikacia:spell_earth_time_active", spell_earth_time_active + 1)
        placer:add_velocity({ x = 0, y = 15, z = 0 })
        spawn_effect_anim(use_pos_above, "effect_earth_primary")
        use_success = true
        use_at_self = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_electricity") then
        lightning_strike(use_pos_above)
        spawn_effect_anim(use_pos_above, "effect_vortex_blue")
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_fire") then
        for _, k in ipairs(around_circle_3_pos_list) do
            safe_replace({ x = use_pos_above.x + k[1], y = use_pos_above.y, z = use_pos_above.z + k[2] }, "mcl_fire:fire",
                placer)
        end
        spawn_effect_anim(use_pos_above, "effect_vortex_blue")
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_ice") then
        spawn_effect_anim(use_pos_above, "effect_vortex_blue")
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_telepathic") then
        if pointed_thing.type == "node" then
            placer:set_pos({ x = use_pos_above.x, y = use_pos_above.y - 0.5, z = use_pos_above.z })
        else
            placer:set_pos(use_pos_above)
        end
        spawn_effect_anim(use_pos_above, "effect_vortex_blue")
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_water") then
        spawn_effect_anim(use_pos_above, "effect_vortex_blue")
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_void") then
        for obj, _ in minetest.objects_inside_radius(use_pos_above, 2) do
            if not obj then goto continue end
            if (obj:get_luaentity() ~= nil
                    and obj:get_luaentity().name ~= "mcl_chests:chest"
                    and obj:get_luaentity().name ~= "mcl_itemframes:item"
                    and obj:get_luaentity().name ~= "mcl_enchanting:book")
                or obj:is_player()
            then
                mcl_util.deal_damage(obj, 20, "magikacia_spell_void")
            end
            ::continue::
        end
        spawn_effect_anim(use_pos_above, "effect_void_primary")
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_wind") then
        for obj, _ in minetest.objects_inside_radius(use_pos_above, 8) do
            if not obj then goto continue end
            if (obj:get_luaentity() ~= nil
                    and obj:get_luaentity().name ~= "mcl_chests:chest"
                    and obj:get_luaentity().name ~= "mcl_itemframes:item"
                    and obj:get_luaentity().name ~= "mcl_enchanting:book")
                or obj:is_player()
            then
                local newvel = vector.offset(vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos_above)), 10), 0, 10, 0)
                obj:add_velocity(newvel)
            end
            ::continue::
        end
        spawn_effect_anim(use_pos_above, "effect_vortex_blue")
        use_success = true
        use_at_place_above = true
    end

    if use_pos_above and has_in_gauntlet(itemstack, placer, modname .. ":rune_nature") then
        bone_meal(itemstack, placer, pointed_thing)
        use_success = true
        use_at_place_above = true
    end

    if use_pos_under and has_in_gauntlet(itemstack, placer, modname .. ":rune_protection") then
        minetest.registered_chatcommands["area_pos1"].func(placer:get_player_name(), use_pos_under.x .. " " .. use_pos_under.y .. " " .. use_pos_under.z) 
        use_success = true
        use_at_place_under = true
    end

    if use_at_place_above then
    end
    if use_at_place_under then
    end
    if use_at_self then
    end

    if use_success then
        minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_above, max_hear_distance = 64 }, true)
    end

    return magikacia.on_use_bag(itemstack, placer, pointed_thing)
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

local gauntlet_use_secondary = function(itemstack, placer, pointed_thing, bagtable)
    if not placer then return nil end
    local meta = placer:get_meta()
    local use_pos_above = nil
    if pointed_thing.type == "node" then
        use_pos_above = pointed_thing.above
    elseif pointed_thing.type == "object" then
        use_pos_above = pointed_thing.ref:get_pos()
    end
    if pointed_thing.type == "node" then
        use_pos = pointed_thing.above
    elseif pointed_thing.type == "object" then
        use_pos = pointed_thing.ref:get_pos()
    end
    local use_pos_under = nil
    if pointed_thing.type == "node" then
        use_pos_under = pointed_thing.under
    elseif pointed_thing.type == "object" then
        use_pos_under = vector.offset(pointed_thing.ref:get_pos(), 0, -1, 0)
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

    if use_pos_under and has_in_gauntlet(itemstack, placer, modname .. ":rune_protection") then
        minetest.registered_chatcommands["area_pos"].func(placer:get_player_name(), use_pos_under.x .. " " .. use_pos_under.y .. " " .. use_pos_under.z) 
        spawn_effect_anim(use_pos_under, "effect_vortex_blue")
        use_success = true
        use_at_place_under = true
    end
    if use_pos_under and has_in_gauntlet(itemstack, placer, modname .. ":rune_ender") then
        minetest.show_formspec(placer:get_player_name(), "mcl_chests:ender_chest_" .. placer:get_player_name(), formspec_ender_chest)
        spawn_effect_anim(placer:get_pos(), "effect_vortex_blue")
        use_success = true
        use_at_self = true
    end

    if use_at_place_above then
        spawn_effect_anim(use_pos_above, "effect_vortex_blue")
    end
    if use_at_place_under then
    end
    if use_at_self then
    end

    if use_success then
        minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_above, max_hear_distance = 64 }, true)
    end

    return nil
end

function magikacia.register_bag(name, bagtable)
    minetest.register_tool(":" .. name, {
        description = bagtable.description,
        inventory_image = bagtable.inventory_image,
        groups = { bag = 1 },
        on_secondary_use = function(itemstack, user, pointed_thing)
            return gauntlet_use_secondary(itemstack, user, pointed_thing, bagtable)
        end,
        on_place = function(itemstack, placer, pointed_thing)
            return gauntlet_use_secondary(itemstack, placer, pointed_thing, bagtable)
        end,
        on_use = function(itemstack, user, pointed_thing)
            return gauntlet_use_primary(itemstack, user, pointed_thing)
        end,
        on_drop = function(itemstack, dropper, pos)
            return magikacia.on_drop_bag(itemstack, dropper, pos)
        end,
        range = bagtable.range,
    })
    local s = "_magikacia_gauntlet_init_" .. name:gsub("[^a-zA-Z0-9]", "") .. "_C_"
    if not mcl_util[s] then
        mcl_util[s] = true
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
    end
end

magikacia.register_bag("magikacia:gauntlet_iron", {
    description = "Iron Magikacia Gauntlet",
    inventory_image = magikacia.textures.gauntlet_iron_inv,
    width = 1,
    height = 1,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 8,
})

magikacia.register_bag("magikacia:gauntlet_gold", {
    description = "Gold Magikacia Gauntlet",
    inventory_image = magikacia.textures.gauntlet_gold_inv,
    width = 2,
    height = 2,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 16,
})

magikacia.register_bag("magikacia:gauntlet_diamond", {
    description = "Diamond Magikacia Gauntlet",
    inventory_image = magikacia.textures.gauntlet_diamond_inv,
    width = 3,
    height = 3,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 32,
})

magikacia.register_bag("magikacia:gauntlet_netherite", {
    description = "Netherite Magikacia Gauntlet",
    inventory_image = magikacia.textures.gauntlet_netherite_inv,
    width = 4,
    height = 4,
    sound_open = "magikacia_open_bag",
    sound_close = "magikacia_close_bag",
    range = 64,
})



minetest.register_tool(":magikacia:gauntlet_transporting_bag", {
    description = "Bag Transporting Bag",
    inventory_image = magikacia.textures.gauntlet_transporting_bag_inv,
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

if not mcl_util._magikacia_gauntlet_init then
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

if not mcl_util._magikacia_gauntlet_init then
    mcl_util._magikacia_gauntlet_init = true
end