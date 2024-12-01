local modname = "arkacia"

local blank = "blank.png^[png:"
local textures = {
    eoaktiakouskou = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAANdJREFUOE9jZCAD5IbY/Qdpe/LyEwMjPv0whehqQBphAKcByLaAFL/5+AWu6fClO4wmQTr/z6y7wsgIUjh5zSEUg5A1rz98AcMSmGaQiWADYP6BKQaJwZyJbgCyZrABIAKmAaQYxpYR52NAdxm6ZhQDYB4E2UysZgwXgARI0YzVC+hRhs3ZyGrAYRBoa/CfVJtR0gE2AwjZjGEAKKGAEghIgljN8DAAuQBmACma4QkJFHWgNECqZrgBF249Y/iuwsEAStukZk5GWz0VcFKG+Z8UA+xizP4DADe+qlra0BuKAAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    eoaktiakouskou_0 = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAARFJREFUOE9jfPrkwf9TJ44yBIZEMzKQAAJtDf5fffCcAazJ0VT7v5qsJMPMdXtQDMkNsfuPzcwnLz/BheEa0A2BaUZWDNO1/vAFRpMgnf9n1l1hRLERZIiBqgxD/7KdjCADQJpBitFdAdMMEseQhBny59d3BqIMAAUGsi0gm688fMsAcwk+28EugDlVRpwPrFZKiJfh1PWnDB9+/MYwBNnpMIPBBsA4sACDuQg9YLEaANKML8BghpxleMEACnV0L4EFQOEAorGFOEgcm81wLxByAT7N8GjE5gWQRpACbM5G9gbYC+gGELIVxQBkzcTaimHAhVvPGL6rcBB0LraMxWirp/L/5fvPDLcevyQpO8MMAwCebb8nUMBIpwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    eoaktiakouskou_1 = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAPBJREFUOE9jZGBgYHj65MF/aRkFRhCbVADWtH7N0v9S0jIM5pb2KIbkhtj9x2fghVvPGOAaHE21/6vJSjLMXLcHLAbT/OTlJ6xmvPn4BSyOYiOyISADQJrXH76A1WsmQTr/z6y7woghCTLEQFWG4c+v7wy4DIBpxnABzNlXHr5lABnSv2wnXttRDEAOMJDNH378xmoIsu1wA9ADDOZvmHeQXYLTAFz+RQ5YdM0oLsAX4uhRjByv8DgnJsqwJQiCBmBzNlEuAGkEKQQlFnzJGcMFxGqEGQo3AJQxvqtwELQR3TVgA2z1VMDOPXzpDslZGgBBLq8tVNRZYAAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    eoaktiakouskou_2 = blank .. "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAQZJREFUOE9jZKAQMOLTnxti9x9ZfvKaQxjqUQSePnnwX1pGASwG0/zk5Se4GTLifCj2Xbj1jAHFgPVrlv6XkpZhMLe0ZwQZANK8/vAFuJpAWwO4i958/AI2DMNJjqba/9VkJRnYmH4xoBuAbL1JkM7/M+uuMGIYMK0s9P/q/dcYQIbMXLcHZxhhGIAcYCCbP/z4zWCgKsPQv2wnVkNQDEAPMJi/Qd7BZghMMzwMsAUYzL/YDCHJAJBB6IaQbADMEFDAnmV4wQAKfZgL4YkGX5Qhewc9dog2AORsmEE4XQBSgJzycGlCTlAoLgAlz+8qHHB5ZJtwZTq4AaCMAQKHL93Bm0PRDQIAdSqxLc5CLEEAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
}

arkacia_bows = {}


local GRAVITY = 9.81
local BOW_DURABILITY = -1


local BOW_CHARGE_TIME_HALF = 20000
local BOW_CHARGE_TIME_FULL = 50000



local PLAYER_USE_BOW_SPEED = tonumber(minetest.settings:get("movement_speed_crouch")) /
tonumber(minetest.settings:get("movement_speed_walk"))



local BOW_MAX_SPEED = 100

local bow_load = {}


local bow_index = {}

function arkacia_bows.shoot_arrow(arrow_item, pos, dir, yaw, shooter, power, damage, is_critical, bow_stack, collectable)
    local obj = minetest.add_entity({ x = pos.x, y = pos.y, z = pos.z }, arrow_item .. "_entity")
    if not obj or not obj:get_pos() then return end
    if power == nil then
        power = BOW_MAX_SPEED
    end
    if damage == nil then
        damage = 3
    end
    local knockback
    if bow_stack then
        local enchantments = mcl_enchanting.get_enchantments(bow_stack)
        if enchantments.power then
            damage = damage + (enchantments.power + 1) / 4
        end
        if enchantments.punch then
            knockback = enchantments.punch * 3
        end
        if enchantments.flame then
            mcl_burning.set_on_fire(obj, math.huge)
        end
    end
    obj:set_velocity({ x = dir.x * power, y = dir.y * power, z = dir.z * power })
    obj:set_acceleration({ x = 0, y = -GRAVITY, z = 0 })
    obj:set_yaw(yaw - math.pi / 2)
    local le = obj:get_luaentity()
    le._shooter = shooter
    le._source_object = shooter
    le._damage = damage
    le._is_critical = is_critical
    le._startpos = pos
    le._knockback = knockback
    le._collectable = collectable
    minetest.sound_play("mcl_bows_bow_shoot", { pos = pos, max_hear_distance = 16 }, true)
    if shooter and shooter:is_player() then
        if obj:get_luaentity().player == "" then
            obj:get_luaentity().player = shooter
        end
        obj:get_luaentity().node = shooter:get_inventory():get_stack("main", 1):get_name()
    end
    return obj
end

local function get_arrow(player)
    local inv = player:get_inventory()
    local arrow_stack, arrow_stack_id
    for i = 1, inv:get_size("main") do
        local it = inv:get_stack("main", i)
        if not it:is_empty() and minetest.get_item_group(it:get_name(), "ammo_bow") ~= 0 then
            arrow_stack = it
            arrow_stack_id = i
            break
        end
    end
    return arrow_stack, arrow_stack_id
end

local function player_shoot_arrow(itemstack, player, power, damage, is_critical)
    local arrow_stack, arrow_stack_id = get_arrow(player)
    local arrow_itemstring
    local has_infinity_enchantment = mcl_enchanting.has_enchantment(player:get_wielded_item(), "infinity")
    local infinity_used = false

    if minetest.is_creative_enabled(player:get_player_name()) then
        if arrow_stack then
            arrow_itemstring = arrow_stack:get_name()
        else
            arrow_itemstring = "mcl_bows:arrow"
        end
    else
        if not arrow_stack then
            return false
        end
        arrow_itemstring = arrow_stack:get_name()
        if has_infinity_enchantment and minetest.get_item_group(arrow_itemstring, "ammo_bow_regular") > 0 then
            infinity_used = true
        else
            arrow_stack:take_item()
        end
        local inv = player:get_inventory()
        inv:set_stack("main", arrow_stack_id, arrow_stack)
    end
    if not arrow_itemstring then
        return false
    end
    local playerpos = player:get_pos()
    local dir = player:get_look_dir()
    local yaw = player:get_look_horizontal()

    arkacia_bows.shoot_arrow(arrow_itemstring, { x = playerpos.x, y = playerpos.y + 1.5, z = playerpos.z }, dir, yaw, player,
        power, damage, is_critical, player:get_wielded_item(), not infinity_used)
    return true
end


minetest.register_tool(":" .. modname .. ":eoaktiakouskou", {
    description = "Eoaktiakouskou",
    inventory_image = textures.eoaktiakouskou,
    wield_scale = mcl_vars.tool_wield_scale,
    stack_max = 1,
    range = 4,

    on_use = function() return end,
    on_place = function(itemstack, player, pointed_thing)
        local rc = mcl_util.call_on_rightclick(itemstack, player, pointed_thing)
        if rc then return rc end

        itemstack:get_meta():set_string("active", "true")
        return itemstack
    end,
    on_secondary_use = function(itemstack)
        itemstack:get_meta():set_string("active", "true")
        return itemstack
    end,
    groups = { weapon = 1, weapon_ranged = 1, bow = 1, enchantability = 1 },
    _mcl_uses = -1,
})


local function reset_bows(player)
    local inv = player:get_inventory()
    local list = inv:get_list("main")
    for place, stack in pairs(list) do
        if stack:get_name() == modname .. ":eoaktiakouskou" or stack:get_name() == modname .. ":eoaktiakouskou_enchanted" then
            stack:get_meta():set_string("active", "")
        elseif stack:get_name() == modname .. ":eoaktiakouskou_0" or stack:get_name() == modname .. ":eoaktiakouskou_1" or stack:get_name() == modname .. ":eoaktiakouskou_2" then
            stack:set_name(modname .. ":eoaktiakouskou")
            stack:get_meta():set_string("active", "")
            list[place] = stack
        elseif stack:get_name() == modname .. ":eoaktiakouskou_0_enchanted" or stack:get_name() == modname .. ":eoaktiakouskou_1_enchanted" or stack:get_name() == modname .. ":eoaktiakouskou_2_enchanted" then
            stack:set_name(modname .. ":eoaktiakouskou_enchanted")
            stack:get_meta():set_string("active", "")
            list[place] = stack
        end
    end
    inv:set_list("main", list)
end


local function reset_bow_state(player, also_reset_bows)
    bow_load[player:get_player_name()] = nil
    bow_index[player:get_player_name()] = nil
    if minetest.get_modpath("playerphysics") then
        playerphysics.remove_physics_factor(player, "speed", "mcl_bows:use_bow")
    end
    if also_reset_bows then
        reset_bows(player)
    end
end


for level = 0, 2 do
    minetest.register_tool(":" .. modname .. ":eoaktiakouskou_" .. level, {
        description = "Eoaktiakouskou",
        inventory_image = textures["eoaktiakouskou_" .. level],
        wield_scale = mcl_vars.tool_wield_scale,
        stack_max = 1,
        range = 0,
        groups = { not_in_creative_inventory = 1, not_in_craft_guide = 1, bow = 1, enchantability = 1 },

        on_use = function() return end,
        on_drop = function(itemstack, dropper, pos)
            reset_bow_state(dropper)
            itemstack:get_meta():set_string("active", "")
            if mcl_enchanting.is_enchanted(itemstack:get_name()) then
                itemstack:set_name(modname .. ":eoaktiakouskou_enchanted")
            else
                itemstack:set_name(modname .. ":eoaktiakouskou")
            end
            minetest.item_drop(itemstack, dropper, pos)
            itemstack:take_item()
            return itemstack
        end,

        on_place = function(itemstack)
            return itemstack
        end,
        _mcl_uses = -1,
    })
end


mcl_util._arkacia_eoaktiakouskou_init = mcl_util._arkacia_eoaktiakouskou_init or false
if not mcl_util._arkacia_eoaktiakouskou_init then
    mcl_util._arkacia_eoaktiakouskou_init = true
    controls.register_on_release(function(player, key, time)
        if key ~= "RMB" and key ~= "zoom" then return end

        local wielditem = player:get_wielded_item()
        if (wielditem:get_name() == modname .. ":eoaktiakouskou_0" or wielditem:get_name() == modname .. ":eoaktiakouskou_1" or wielditem:get_name() == modname .. ":eoaktiakouskou_2" or
                wielditem:get_name() == modname .. ":eoaktiakouskou_0_enchanted" or wielditem:get_name() == modname .. ":eoaktiakouskou_1_enchanted" or wielditem:get_name() == modname .. ":eoaktiakouskou_2_enchanted") then
            local enchanted = mcl_enchanting.is_enchanted(wielditem:get_name())
            local speed, damage
            local p_load = bow_load[player:get_player_name()]
            local charge

            if type(p_load) == "number" then
                charge = minetest.get_us_time() - p_load
            else
                charge = 0
                minetest.log("warning",
                    "[mcl_bows] Player " .. player:get_player_name() .. " fires arrow with non-numeric bow_load!")
            end
            charge = math.max(math.min(charge, BOW_CHARGE_TIME_FULL), 0)

            local charge_ratio = charge / BOW_CHARGE_TIME_FULL
            charge_ratio = math.max(math.min(charge_ratio, 1), 0)



            local is_critical = false
            if charge >= BOW_CHARGE_TIME_FULL then
                speed = BOW_MAX_SPEED
                damage = 100
                is_critical = true
            else
                speed = math.max(4, BOW_MAX_SPEED * charge_ratio)
                damage = math.max(1, math.floor(90 * charge_ratio))
            end

            local has_shot = player_shoot_arrow(wielditem, player, speed, damage, is_critical)

            if enchanted then
                wielditem:set_name(modname .. ":eoaktiakouskou_enchanted")
            else
                wielditem:set_name(modname .. ":eoaktiakouskou")
            end

            player:set_wielded_item(wielditem)
            reset_bow_state(player, true)
        end
    end)

    controls.register_on_hold(function(player, key, time)
        local name = player:get_player_name()
        local creative = minetest.is_creative_enabled(name)
        if (key ~= "RMB" and key ~= "zoom") or not (creative or get_arrow(player)) then
            return
        end

        local wielditem = player:get_wielded_item()
        if bow_load[name] == nil
            and (wielditem:get_name() == modname .. ":eoaktiakouskou" or wielditem:get_name() == modname .. ":eoaktiakouskou_enchanted")
            and (wielditem:get_meta():get("active") or key == "zoom") and (creative or get_arrow(player)) then
            local enchanted = mcl_enchanting.is_enchanted(wielditem:get_name())
            if enchanted then
                wielditem:set_name(modname .. ":eoaktiakouskou_0_enchanted")
            else
                wielditem:set_name(modname .. ":eoaktiakouskou_0")
            end
            player:set_wielded_item(wielditem)
            if minetest.get_modpath("playerphysics") then
                playerphysics.add_physics_factor(player, "speed", "mcl_bows:use_bow", PLAYER_USE_BOW_SPEED)
            end
            bow_load[name] = minetest.get_us_time()
            bow_index[name] = player:get_wield_index()
        else
            if player:get_wield_index() == bow_index[name] then
                if type(bow_load[name]) == "number" then
                    if wielditem:get_name() == modname .. ":eoaktiakouskou_0" and minetest.get_us_time() - bow_load[name] >= BOW_CHARGE_TIME_HALF then
                        wielditem:set_name(modname .. ":eoaktiakouskou_1")
                    elseif wielditem:get_name() == modname .. ":eoaktiakouskou_0_enchanted" and minetest.get_us_time() - bow_load[name] >= BOW_CHARGE_TIME_HALF then
                        wielditem:set_name(modname .. ":eoaktiakouskou_1_enchanted")
                    elseif wielditem:get_name() == modname .. ":eoaktiakouskou_1" and minetest.get_us_time() - bow_load[name] >= BOW_CHARGE_TIME_FULL then
                        wielditem:set_name(modname .. ":eoaktiakouskou_2")
                    elseif wielditem:get_name() == modname .. ":eoaktiakouskou_1_enchanted" and minetest.get_us_time() - bow_load[name] >= BOW_CHARGE_TIME_FULL then
                        wielditem:set_name(modname .. ":eoaktiakouskou_2_enchanted")
                    end
                else
                    if wielditem:get_name() == modname .. ":eoaktiakouskou_0" or wielditem:get_name() == modname .. ":eoaktiakouskou_1" or wielditem:get_name() == modname .. ":eoaktiakouskou_2" then
                        wielditem:set_name(modname .. ":eoaktiakouskou")
                    elseif wielditem:get_name() == modname .. ":eoaktiakouskou_0_enchanted" or wielditem:get_name() == modname .. ":eoaktiakouskou_1_enchanted" or wielditem:get_name() == modname .. ":eoaktiakouskou_2_enchanted" then
                        wielditem:set_name(modname .. ":eoaktiakouskou_enchanted")
                    end
                end
                player:set_wielded_item(wielditem)
            else
                reset_bow_state(player, true)
            end
        end
    end)
end


if minetest.get_modpath("mcl_core") and minetest.get_modpath("mcl_mobitems") then
    minetest.register_craft({
        output = modname .. ":eoaktiakouskou",
        recipe = {
            { "",               "mcl_core:stick",       "mcl_lush_caves:cave_vines" },
            { "mcl_core:stick", "magikacia:rune_earth", "mcl_lush_caves:cave_vines" },
            { "",               "mcl_core:stick",       "mcl_lush_caves:cave_vines" },
        }
    })
    minetest.register_craft({
        output = modname .. ":eoaktiakouskou",
        recipe = {
            { "mcl_lush_caves:cave_vines", "mcl_core:stick",        "" },
            { "mcl_lush_caves:cave_vines", "magikacia:rune_earth", "mcl_core:stick" },
            { "mcl_lush_caves:cave_vines", "mcl_core:stick",        "" },
        }
    })
end
