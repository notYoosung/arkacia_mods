local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize
local gauntlet_types = {
    "iron",
    "gold",
    "diamond",
    "netherite",
}
local inventorybags = {}
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

-- functions to handle upgrades (can be overridden)

-- called on bag_inv_add_item, bag_inv_remove_item and save_bag_inv_itemstack (called on on_move, on_put and on_take)
function inventorybags.on_change_bag_inv(bagstack, baginv)
    return bagstack, baginv
end

-- called on open bag
function inventorybags.on_open_bag(bagstack, baginv, player)
    return bagstack, baginv, player
end

-- called on close bag
function inventorybags.on_close_bag(player, fields, name, formname, sound)
    return player, fields, name, formname, sound
end

-- called before open bag
function inventorybags.before_open_bag(itemstack, user, width, height, sound)
    return itemstack, user, width, height, sound
end

-- called on use bag
function inventorybags.on_use_bag(itemstack, user, pointed_thing)
    return itemstack, user, pointed_thing
end

-- called on drop bag
function inventorybags.on_drop_bag(itemstack, dropper, pos)
    minetest.item_drop(itemstack, dropper, pos)
    return itemstack, dropper, pos
end
  
local function save_bag_inv_itemstack(inv, stack)
    stack, inv = inventorybags.on_change_bag_inv(stack, inv)
    local meta = stack:get_meta()
    meta:set_string("inventorybags_inv_content", minetest.serialize(inv_to_table(inv)))
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
        if meta:get_string("inventorybags_bag_identity") == bag_id then
            stack = save_bag_inv_itemstack(inv, stack)
            playerinv:set_stack(listname, i, stack)
        end
    end
end

local function create_invname(itemstack)
    inventorybags.counter = (inventorybags.counter or 0) + 1
    return itemstack:get_name() .. "_C_" .. inventorybags.counter
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
    itemstack, user, width, height, sound = inventorybags.before_open_bag(itemstack, user, width, height, sound)
    local allow_bag_input = false
    if minetest.get_item_group(itemstack:get_name(), "bag_bag") > 0 then
        allow_bag_input = true
    end
    local meta = itemstack:get_meta()
    local playername = user:get_player_name()
    local invname = meta:get_string("inventorybags_bag_identity")

    -- bag identity
    if invname == "" then
        local item_count = itemstack:get_count()
        if item_count > 1 then
            local newitemstack = itemstack:take_item(item_count - 1)
            minetest.after(0.01, stack_to_player_inv, newitemstack, user)
        end
        invname = create_invname(itemstack)
        meta:set_string("inventorybags_bag_identity", invname)
    end

    meta:set_int("inventorybags_width", width)
    meta:set_int("inventorybags_height", height)

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
            -- fix swap bug
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
    local invmetastring = meta:get_string("inventorybags_inv_content")
    if invmetastring ~= "" then
        table_to_inv(inv, minetest.deserialize(invmetastring))

        itemstack, inv, user = inventorybags.on_open_bag(itemstack, inv, user)
        save_bag_inv_itemstack(inv, itemstack)
    end

    if sound then
        minetest.sound_play(sound, { gain = 0.8, object = user, max_hear_distance = 5 })
    end
    minetest.show_formspec(playername, invname, get_formspec(invname, width, height))
    return itemstack
end

function inventorybags.bag_inv_add_item(bagstack, itemstack)
    local meta = bagstack:get_meta()
    local invname = meta:get_string("inventorybags_bag_identity")
    if not invname then
        return false
    end
    local inv = minetest.create_detached_inventory(invname, {})
    local width = meta:get_int("inventorybags_width")
    local height = meta:get_int("inventorybags_height")
    inv:set_size("main", width * height)
    local invmetastring = meta:get_string("inventorybags_inv_content")
    if invmetastring ~= "" then
        table_to_inv(inv, minetest.deserialize(invmetastring))

        bagstack, inv = inventorybags.on_change_bag_inv(bagstack, inv)
    end
    if inv:room_for_item("main", itemstack) then
        inv:add_item("main", itemstack)
        return save_bag_inv_itemstack(inv, bagstack)
    end
    return false
end

function inventorybags.bag_inv_remove_item(bagstack, itemstack)
    local meta = bagstack:get_meta()
    local invname = meta:get_string("inventorybags_bag_identity")
    if not invname then
        return false
    end
    local inv = minetest.create_detached_inventory(invname, {})
    local width = meta:get_int("inventorybags_width")
    local height = meta:get_int("inventorybags_height")
    inv:set_size("main", width * height)
    local invmetastring = meta:get_string("inventorybags_inv_content")
    if invmetastring ~= "" then
        table_to_inv(inv, minetest.deserialize(invmetastring))

        bagstack, inv = inventorybags.on_change_bag_inv(bagstack, inv)
    end
    if inv:contains_item("main", itemstack) then
        inv:remove_item("main", itemstack)
        return save_bag_inv_itemstack(inv, bagstack)
    end
    return false
end

function inventorybags.register_bag(name, bagtable)
    minetest.register_craftitem(":" .. name, {
        description = bagtable.description,
        inventory_image = bagtable.inventory_image,
        groups = { bag = 1 },

        on_secondary_use = function(itemstack, user)
            return open_bag(itemstack, user, bagtable.width, bagtable.height, bagtable.sound_open)
        end,
        on_place = function(itemstack, placer, pointed_thing)
            return open_bag(itemstack, placer, bagtable.width, bagtable.height, bagtable.sound_open)
        end,
        on_use = function(itemstack, user, pointed_thing)
            return inventorybags.on_use_bag(itemstack, user, pointed_thing)
        end,
        on_drop = function(itemstack, dropper, pos)
            return inventorybags.on_drop_bag(itemstack, dropper, pos)
        end
    })

    minetest.register_on_player_receive_fields(function(player, formname, fields)
        local nisformn = string.find(formname, name .. "_C_")
        if nisformn == 1 then
            if fields.quit then
                player, fields, name, formname, sound = inventorybags.on_close_bag(player, fields, name, formname,
                    bagtable.sound_close)
                if bagtable.sound_close then
                    minetest.sound_play(sound, { gain = 0.8, object = player, max_hear_distance = 5 })
                end
            end
        end
        return
    end)
end

for i, v in ipairs(gauntlet_types) do
    inventorybags.register_bag("magikacia:gauntlet_" .. v, {
        description = "Magic Gauntlet: " .. v,
        inventory_image = magikacia.textures["gauntlet_" .. v],
        width = math.pow(3, i - 1) / math.min(3, math.pow(3, i - 1)),
        height = math.min(3, math.pow(3, i - 1)),
        sound_open = "mcl_armor_equip_iron",
        sound_close = "mcl_armor_unequip_iron"
    })
end

-- special bags

minetest.register_craftitem(":inventorybags:bag_transporting_bag", {
    description = "Bag Transporting Bag",
    inventory_image = "inventorybags_bag_transporting_bag.png",
    groups = { bag = 1, bag_bag = 1 },

    on_secondary_use = function(itemstack, user)
        return open_bag(itemstack, user, 2, 2, "inventorybags_open_bag")
    end,
    on_place = function(itemstack, placer, pointed_thing)
        return open_bag(itemstack, placer, 2, 2, "inventorybags_open_bag")
    end,
    on_use = function(itemstack, user, pointed_thing)
        return inventorybags.on_use_bag(itemstack, user, pointed_thing)
    end,
    on_drop = function(itemstack, dropper, pos)
        return inventorybags.on_drop_bag(itemstack, dropper, pos)
    end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
    local nisformn = string.find(formname, "inventorybags:bag_transporting_bag_C_")
    if nisformn == 1 then
        if fields.quit then
            player, fields, name, formname, sound = inventorybags.on_close_bag(player, fields, name, formname,
                "inventorybags_close_bag")
            minetest.sound_play(sound, { gain = 0.8, object = player, max_hear_distance = 5 })
        end
    end
    return
end)

