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


local max_text_length = 4500 -- TODO: Increase to 12800 when scroll bar was added to written book
local max_title_length = 64


-- local magic = {

-- }


local header = ""
if minetest.get_modpath("mcl_init") then
    header = "no_prepend[]" .. mcl_vars.gui_nonbg .. mcl_vars.gui_bg_color ..
        "style_type[button;border=false;bgimg=mcl_books_button9.png;bgimg_pressed=mcl_books_button9_pressed.png;bgimg_middle=2,2]"
end

-- Book
minetest.register_craftitem(":" .. modname .. ":book", {
    description = S("Book"),
    inventory_image = "default_book.png",
    groups = { book = 1, craftitem = 1, enchantability = 1 },
    _mcl_enchanting_enchanted_tool = modname .. ":book_selected",
})


local function make_description(title, author, generation)
    local desc
    if generation == 0 then
        desc = S("“@1”", title)
    elseif generation == 1 then
        desc = S("Copy of “@1”", title)
    elseif generation == 2 then
        desc = S("Copy of Copy of “@1”", title)
    else
        desc = S("Tattered Book")
    end
    desc = desc .. "\n" .. minetest.colorize(mcl_colors.GRAY, S("by @1", author))
    return desc
end

local function cap_text_length(text, max_length)
    return string.sub(text, 1, max_length)
end

local function write(itemstack, user, pointed_thing)
    local rc = mcl_util.call_on_rightclick(itemstack, user, pointed_thing)
    if rc then return rc end
    --.25/6
    -- 73x90
    local text = itemstack:get_meta():get_string("text")
    local formspec = table.concat({
        "formspec_version[4]",
        "size[14.6,9]",
        header,
        "background[-0.5,-0.5;9,10;z_magic_page_left.png]",
        "background[7.5,-0.5;9,10;z_magic_page_right.png]",
        "background[7.5,-0.5;9,10;z_magic_page_button_yes.png]",
        "background[7.5,-0.5;9,10;z_magic_page_button_no.png]",
        --"textarea[0.75,0.1;7.25,9;text;;" .. minetest.formspec_escape(text) .. "]",
        --"button[0.75,7.95;3,1;sign;" .. minetest.formspec_escape(S("Sign")) .. "]",
        --"button_exit[4.25,7.95;3,1;ok;" .. minetest.formspec_escape(S("Done")) .. "]",
        "button_exit[08.45,1.5;3.178,1.7;yes;" .. minetest.formspec_escape(" ") .. "]",
        "button_exit[12.054,1.8;3.178,1.7;no;" .. minetest.formspec_escape(" ") .. "]",
    })
    minetest.show_formspec(user:get_player_name(), modname .. ":writable_book", formspec)
end

local function read(itemstack, user, pointed_thing)
    local rc = mcl_util.call_on_rightclick(itemstack, user, pointed_thing)
    if rc then return rc end

    local text = itemstack:get_meta():get_string("text")
    local formspec = "size[8,9]" ..
        header ..
        "background[-0.5,-0.5;9,10;mcl_books_book_bg.png]" ..
        "textarea[0.75,0.1;7.25,9;;" .. minetest.formspec_escape(text) .. ";]" ..
        "button_exit[2.25,7.95;3,1;ok;" .. minetest.formspec_escape(S("Done")) .. "]"
    minetest.show_formspec(user:get_player_name(), modname .. ":written_book", formspec)
end

-- Book and Quill
minetest.register_craftitem(":" .. modname .. ":writable_book", {
    description = S("Book and Quill"),
    _tt_help = S("Write down some notes"),
    _doc_items_longdesc = S("This item can be used to write down some notes."),
    _doc_items_usagehelp = S(
            "Hold it in the hand, then rightclick to read the current notes and edit then. You can edit the text as often as you like. You can also sign the book which turns it into a written book which you can stack, but it can't be edited anymore.")
        .. "\n" ..
        S("A book can hold up to 4500 characters. The title length is limited to 64 characters."),
    inventory_image = "mcl_books_book_writable.png",
    groups = { book = 1 },
    stack_max = 1,
    on_place = write,
    on_secondary_use = write,
})


-- minetest.register_craft({
-- 	type = "fuel",
-- 	recipe = modname .. ":bookbookshelf",
-- 	burntime = 15,
-- })


--





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
        texture = "mcl_particles_bonemeal.png^[colorize:#00EE00:125", -- TODO: real MC color
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





local gauntlet_inv_formspec = table.concat({
    "formspec_version[4]",
    "size[11.75,10.425]",

    "label[4.125,0.375;" .. F(C(mcl_formspec.label_color, S("Magic Inventory"))) .. "]",

    mcl_formspec.get_itemslot_bg_v4(4.125, 0.75, 3, 1),
    "list[current_player;gauntlet_inv;4.125,0.75;3,1;]",

    "label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",

    mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
    "list[current_player;main;0.375,5.1;9,3;9]",

    mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
    "list[current_player;main;0.375,9.05;9,1;]",

    "listring[current_player;main]",
    "listring[current_player;gauntlet_inv]",
})


local function has_in_gauntlet(player, itemname)
    if not player or not player:is_player() or not player:get_pos() then return end
    local inv = player:get_inventory()
    if not inv then return end
    local armor_list = inv:get_list("gauntlet_inv")
    if not armor_list then return end
    if inv:contains_item("gauntlet_inv", itemname) then
        return true
    end
    return false
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
local function spawn_vortex(pos)
    minetest.add_particle({
        pos = pos,
        velocity = { x = 0, y = 0, z = 0 },
        acceleration = { x = 0, y = 0, z = 0 },
        expirationtime = 2,
        size = 20,
        collisiondetection = false,
        collision_removal = false,
        object_collision = false,
        vertical = false,
        texture = {
            name = magikacia.textures.vortex_blue,
            align_style = "world",
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
do
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



local gauntlet_use_primary = function(itemstack, placer, pointed_thing)
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
    local use_at_place = false
    local use_at_self = false
    if use_pos_above and has_in_gauntlet(placer, modname .. ":rune_fire") then
        for _, k in ipairs(around_circle_3_pos_list) do
            safe_replace({ x = use_pos_above.x + k[1], y = use_pos_above.y, z = use_pos_above.z + k[2] }, "mcl_fire:fire",
                placer)
        end
        use_success = true
        use_at_place = true
    end
    if use_pos_above and has_in_gauntlet(placer, modname .. ":rune_lightning") then
        mcl_lightning.strike(use_pos_above)
        use_success = true
        use_at_place = true
    end
    if use_pos_above and has_in_gauntlet(placer, modname .. ":rune_ender") then
        if pointed_thing.type == "node" then
            placer:set_pos({ x = use_pos_above.x, y = use_pos_above.y - 0.5, z = use_pos_above.z })
        else
            placer:set_pos(use_pos_above)
        end
        use_success = true
        use_at_place = true
    end
    local spell_earth_time_active = meta:get_float("magikacia:spell_earth_time_active")
    if has_in_gauntlet(placer, modname .. ":rune_earth") and spell_earth_time_active == 0 then
        meta:set_float("magikacia:spell_earth_time_active", spell_earth_time_active + 1)
        placer:add_velocity({ x = 0, y = 15, z = 0 })
        use_success = true
        use_at_self = true
    end
    if use_pos_above and has_in_gauntlet(placer, modname .. ":rune_nature") then
        bone_meal(itemstack, placer, pointed_thing)
        use_success = true
        use_at_place = true
    end
    if use_pos_above and has_in_gauntlet(placer, modname .. ":rune_wind") then
        for obj, _ in minetest.objects_inside_radius(use_pos_above, 8) do
            if not obj then goto continue end
            if (obj:get_luaentity() ~= nil
                    and obj:get_luaentity().name ~= "mcl_chests:chest"
                    and obj:get_luaentity().name ~= "mcl_itemframes:item"
                    and obj:get_luaentity().name ~= "mcl_enchanting:book")
                or obj:is_player()
            then
                local newvel = vector.offset(
                vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos_above)), 10), 0, 10, 0)
                obj:add_velocity(newvel)
            end
            ::continue::
        end
        use_success = true
        use_at_place = true
        -- placer:add_velocity({ x = 0, y = 10, z = 0 })
    end

    if use_at_place then
        spawn_vortex(use_pos_above)
    end
    if use_at_self then
        spawn_vortex(placer:get_pos())
    end

    if use_success then
        minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos_above, max_hear_distance = 64 }, true)
    end

    inventorybags.on_use_bag(itemstack, placer, pointed_thing)
    return nil
end

local gauntlet_use_secondary = function(itemstack, placer, pointed_thing, bagtable)
    if not placer then return nil end
    local meta = placer:get_meta()
    local use_pos = nil
    if pointed_thing.type == "node" then
        use_pos = pointed_thing.above
    elseif pointed_thing.type == "object" then
        use_pos = pointed_thing.ref:get_pos()
    end
    local use_success = false
    local use_at_place = false
    local use_at_self = false
    if placer:is_player() then
        local placer_name = placer:get_player_name()
        if controls.players[placer_name].sneak[1] then
            open_bag(itemstack, placer, bagtable.width, bagtable.height, bagtable.sound_open) --minetest.show_formspec(placer_name, "magic:gauntlet_inv", gauntlet_inv_formspec)
            return nil
        end
    end

    return nil
end

function inventorybags.register_bag(name, bagtable)
    minetest.register_craftitem(":" .. name, {
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
            return inventorybags.on_drop_bag(itemstack, dropper, pos)
        end,
        range = 32,
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


local runes = {
    "fire",
    "lightning",
    "ender",
    "earth",
    "nature",
    "protection",
    "wind",
}
for _, v in ipairs(runes) do
    minetest.register_craftitem(":" .. modname .. ":rune_" .. v, {
        description = "Rune: " .. v,
        inventory_image = magikacia.textures["rune_" .. v],
    })
end












local wield3d = {}

local player_wielding = {}
local update_time = minetest.settings:get("wield3d_update_time")
local verify_time = minetest.settings:get("wield3d_verify_time")
local wield_scale = minetest.settings:get("wield3d_scale")

update_time = update_time and tonumber(update_time) or 1
verify_time = verify_time and tonumber(verify_time) or 10
wield_scale = wield_scale and tonumber(wield_scale) or 0.25 -- default scale

local location = {
    "Arm_Right",                    -- default bone
    { x = 0, y = 2 / 16, z = 0 },   -- default position
    { x = 0, y = 0,      z = 0 },   -- default rotation
    { x = 5, y = 5,      z = 0.5 }, -- visual size
}


local function sq_dist(a, b)
    local x = a.x - b.x
    local y = a.y - b.y
    local z = a.z - b.z
    return x * x + y * y + z * z
end


local bone = "Arm_Right"
local pos = { x = 0, y = 5.5, z = 3 }
local scale = { x = 0.25, y = 0.25 }
local rx = -90
local rz = 90

wield3d.location = {
    ["default:torch"] = { bone, pos, { x = rx, y = 180, z = rz }, scale },
    ["default:sapling"] = { bone, pos, { x = rx, y = 180, z = rz }, scale },
}
local magic_circle_entity = {
    physical = false,
    pointable = false,
    collide_with_objects = false,
    collisionbox = { -0.125, -0.125, -0.125, 0.125, 0.125, 0.125 },
    -- is_visible = false,
    visual = "cube",
    mesh = "flat_plane.obj",
    textures = {
        -- {
        -- name =
        "temp_magic_circle.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        -- 	animation = {
        -- 		type = "vertical_frames",
        -- 		aspect_w = 210,
        -- 		aspect_h = 210,
        -- 		length = 75 * 0.06,
        -- 	}
        -- },
        -- {name = "blank.png"},
        -- {name = "blank.png"},
        -- {name = "blank.png"},
        -- {name = "blank.png"},
        -- {name = "blank.png"},
    },
    wielder = nil,
    timer = 0,
    static_save = false,
    visual_size = { x = 10, y = 0, z = 10 },
    glow = 14,
    automatic_rotate = 0.25,
    -- wield_image = "magic_circle.png",
    -- use_texture_alpha = true,
    -- _pos = vector.zero(),
}


function magic_circle_entity:on_activate(staticdata)
    if staticdata and staticdata ~= "" then
        self.wielder = staticdata
        return
    end
    self.object:remove()
end

--:set_attach(parent[, bone, position, rotation, forced_visible])


function magic_circle_entity:on_step(dtime)
    -- if self.wielder == nil then return end
    self.timer = self.timer + (dtime * 25)
    if self.timer > 360 then self.timer = self.timer - 360 end
    local player = minetest.get_player_by_name(self.wielder)
    if player == nil or not player:is_player() then
        self.object:remove()
        return
    end
    local wield = player_wielding[self.wielder]
    -- local stack = player:get_wielded_item()
    -- local item = stack:get_name() or ""
    if self.object and wield then
        -- if has_wieldview then
        -- 		local def = minetest.registered_items[item] or {}
        -- 		if def.inventory_image ~= "" then item = "" end
        -- 	end
        -- 	wield.item = item
        -- 	if item == "" then item = modname .. ":magic_magic_circle" end
        -- 	local loc = location
        -- 	if loc[1] ~= wield.location[1] or not vector.equals(loc[2], wield.location[2]) or not vector.equals(loc[3], wield.location[3]) then
        -- if self.object:get_properties()._pos ~= player:get_pos() then
        --------!	-- self.object:set_attach(player, "", location[2], vector.add(location[3], {x=0, y=(self.timer), z=0}), true)
        -- self.object:set_properties({_pos = player:get_pos()})
        -- end
        -- wield.location = {loc[1], loc[2], loc[3]}
        -- 	end
        -- 	self.object:set_properties({
        -- 		textures = {item},
        -- 		visual_size = loc[4]
        -- 	})
    end
    -- self.timer = 0
end

minetest.register_entity(":" .. modname .. ":magic_magic_circle", magic_circle_entity)

-- temp_magic_circle.png
local function add_magic_circle_entity(player)
    if not player or not player:is_player() then return end
    local name = player:get_player_name()
    local pos = player:get_pos()
    if name and pos and not player_wielding[name] then
        pos.y = pos.y + 0.5
        local object = minetest.add_entity(pos, modname .. ":magic_magic_circle", name)
        if object then
            object:set_attach(player, "", location[2], location[3], true)
            -- object:set_properties({
            -- 	-- textures = {modname .. ":magic_magic_circle"},
            -- 	-- textures = {"magic_circle.png"},
            -- 	textures = {
            -- 		{
            -- 			name = "magic_circle",
            -- 			animation = {
            -- 				type = "vertical_frames",
            -- 				aspect_w = 210,
            -- 				aspect_h = 210,
            -- 				length = 75 * 0.06,
            -- 			}
            -- 		},
            -- 		{name = "blank.png"},
            -- 		{name = "blank.png"},
            -- 		{name = "blank.png"},
            -- 		{name = "blank.png"},
            -- 		{name = "blank.png"},
            -- 	},
            -- 	visual_size = location[4],
            -- })
            player_wielding[name] = {
                item = "",
                location = location
            }
            -- object:set_properties({_pos = pos})
        end
    end
end

-- minetest.register_item(modname .. ":magic_magic_circle", {
-- 	type = "none",
-- 	wield_image = "magic_circle.png",
-- 	use_texture_alpha = "clip",
-- })

-- minetest.register_on_joinplayer(function(ObjectRef, last_login)
-- minetest.after(1, add_magic_circle_entity, ObjectRef)
-- end)



--pacman
local function craft_copy_book(itemstack, player, old_craft_grid, craft_inv)
    if itemstack:get_name() ~= modname .. ":written_book" then
        return
    end

    local original
    local index
    for i = 1, player:get_inventory():get_size("craft") do
        if old_craft_grid[i]:get_name() == modname .. ":written_book" then
            original = old_craft_grid[i]
            index = i
        end
    end
    if not original then
        return
    end

    local ometa = original:get_meta()
    local generation = ometa:get_int("generation")

    -- No copy of copy of copy of book allowed
    if generation >= 2 then
        return ItemStack("")
    end

    -- Copy metadata
    local imeta = itemstack:get_meta()
    imeta:from_table(ometa:to_table())
    imeta:set_string("title", cap_text_length(ometa:get_string("title"), max_title_length))
    imeta:set_string("text", cap_text_length(ometa:get_string("text"), max_text_length))

    -- Increase book generation and update description
    generation = generation + 1
    if generation < 1 then
        generation = 1
    end

    imeta:set_string("description",
        make_description(ometa:get_string("title"), ometa:get_string("author"), generation))
    imeta:set_int("generation", generation)
    return itemstack, original, index
end

-- Written Book
minetest.register_craftitem(":" .. modname .. ":written_book", {
    description = S("Written Book"),
    _doc_items_longdesc = S(
        "Written books contain some text written by someone. They can be read and copied, but not edited."
    ),
    _doc_items_usagehelp = S("Hold it in your hand, then rightclick to read the book.") ..
        "\n\n" ..
        S(
            "To copy the text of the written book, place it into the crafting grid together with a book and quill (or multiple of those) and craft. The written book will not be consumed. Copies of copies can not be copied."
        ),
    inventory_image = "mcl_books_book_written.png",
    groups = { not_in_creative_inventory = 1, book = 1, no_rename = 1 },
    stack_max = 16,
    on_place = read,
    on_secondary_use = read
})


mcl_util._magikacia_init_fields = mcl_util._magikacia_init_fields or false
if not mcl_util._magikacia_init_fields then
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if ((formname == modname .. ":writable_book") and fields and fields.text) then
            local stack = player:get_wielded_item()
            if (stack:get_name() and (stack:get_name() == modname .. ":writable_book")) then
                local meta = stack:get_meta()
                local text = cap_text_length(fields.text, max_text_length)
                if fields.ok then
                    meta:set_string("text", text)
                    player:set_wielded_item(stack)
                elseif fields.sign then
                    meta:set_string("text", text)
                    player:set_wielded_item(stack)

                    local name = player:get_player_name()
                    local formspec = "size[8,9]" ..
                        header ..
                        "background[-0.5,-0.5;9,10;mcl_books_book_bg.png]" ..
                        "field[0.75,1;7.25,1;title;" ..
                        minetest.formspec_escape(minetest.colorize("#000000", S("Enter book title:"))) .. ";]" ..
                        "label[0.75,1.5;" ..
                        minetest.formspec_escape(minetest.colorize("#404040", S("by @1", name))) .. "]" ..
                        "button_exit[0.75,7.95;3,1;sign;" .. minetest.formspec_escape(S("Sign and Close")) .. "]" ..
                        "tooltip[sign;" ..
                        minetest.formspec_escape(S("Note: The book will no longer be editable after signing")) .. "]" ..
                        "button[4.25,7.95;3,1;cancel;" .. minetest.formspec_escape(S("Cancel")) .. "]"
                    minetest.show_formspec(player:get_player_name(), modname .. ":signing", formspec)
                elseif fields.yes then
                    meta:set_string("text", text)
                    player:set_wielded_item(stack)
                elseif fields.no then
                    meta:set_string("text", text)
                    player:set_wielded_item(stack)
                end
            end
        elseif ((formname == modname .. ":signing") and fields and fields.sign and fields.title) then
            local newbook = ItemStack(modname .. ":written_book")
            local book = player:get_wielded_item()
            local name = player:get_player_name()
            if book:get_name() == modname .. ":writable_book" then
                local title = fields.title
                if string.len(title) == 0 then
                    title = S("Nameless Book")
                end
                title = cap_text_length(title, max_title_length)
                local meta = newbook:get_meta()
                local text = cap_text_length(book:get_meta():get_string("text"), max_text_length)
                meta:set_string("title", title)
                meta:set_string("author", name)
                meta:set_int("date", os.time())
                meta:set_string("text", text)
                meta:set_string("description", make_description(title, name, 0))

                -- The book copy counter. 0 = original, 1 = copy of original, 2 = copy of copy of original, …
                meta:set_int("generation", 0)

                player:set_wielded_item(newbook)
            else
                minetest.log("error", "[mcl_books] " .. name .. " failed to sign a book!")
            end
        elseif ((formname == modname .. ":signing") and fields and fields.cancel) then
            local book = player:get_wielded_item()
            if book:get_name() == modname .. ":writable_book" then
                write(book, player, { type = "nothing" })
            end
        end
    end)

    minetest.register_craft_predict(craft_copy_book)
    --This adds 8 recipes containing 1 written book and 1-8 writeable book
    for i = 1, 8 do
        local rc = {}
        table.insert(rc, modname .. ":written_book")
        for j = 1, i do table.insert(rc, modname .. ":writable_book") end

        minetest.register_craft({
            type = "shapeless",
            output = modname .. ":written_book " .. i,
            recipe = rc,
        })
    end
    minetest.register_craft({
        type = "shapeless",
        output = modname .. ":writable_book",
        recipe = { modname .. ":bookbook", "mcl_mobitems:ink_sac", "mcl_mobitems:feather" },
    })

    minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
        local _, original, index = craft_copy_book(itemstack, player, old_craft_grid, craft_inv)
        if original and index then craft_inv:set_stack("craft", index, original) end
    end)

    minetest.register_on_joinplayer(function(player)
        local inv = player:get_inventory()
        inv:set_size("gauntlet_inv", 3)
    end)

    mcl_player.register_globalstep(function(player, dtime)
        if not player or not player:get_pos() then return end
        local pos = player:get_pos()
        local nunderpos = { x = pos.x, y = pos.y - 0.01, z = pos.z }
        local nodeunder = minetest.get_node(nunderpos)
        local meta = player:get_meta()
        local spell_earth_time = meta:get_float("magikacia:spell_earth_time_active") or 0
        local nunderdef = minetest.registered_nodes[nodeunder.name]
        if spell_earth_time > 0 then
            if (nunderdef.opaque or nunderdef.walkable == true) and nodeunder.name ~= "air" and player:get_velocity().y <= 0 and spell_earth_time > 1.1 then
                if nunderdef and nunderdef.walkable then
                    minetest.add_particlespawner({
                        amount = 50,
                        time = 1,
                        minpos = vector.offset(pos, -0.5, 0.1, -0.5),
                        maxpos = vector.offset(pos, 0.5, 0.1, 0.5),
                        minvel = { x = 0, y = 5, z = 0 },
                        maxvel = { x = 0, y = 10, z = 0 },
                        minacc = { x = 0, y = -13, z = 0 },
                        maxacc = { x = 0, y = -13, z = 0 },
                        minexptime = 0.1,
                        maxexptime = 1,
                        minsize = 1,
                        maxsize = 3,
                        collisiondetection = true,
                        -- attached = player,
                        vertical = false,
                        node = nodeunder,
                    })
                end
                for obj, _ in minetest.objects_inside_radius(pos, 8) do
                    if not obj then goto continue end
                    if (obj:get_luaentity() ~= nil
                        and obj:get_luaentity().name ~= "mcl_chests:chest"
                        and obj:get_luaentity().name ~= "mcl_itemframes:item"
                        and obj:get_luaentity().name ~= "mcl_enchanting:book")
                    then
                        local v = vector.normalize(vector.subtract(obj:get_pos(), pos))
                        obj:add_velocity({ x = v.x * 10 * spell_earth_time, y = (v.y * 10 + 20) * spell_earth_time, z = v.z * 10 * spell_earth_time })
                    end
                    if (obj:is_player() and obj:get_player_name() ~= player:get_player_name()) then
                        local v = vector.normalize(vector.subtract(obj:get_pos(), pos))
                        obj:add_velocity({ x = v.x * 10 * spell_earth_time, y = (v.y * 10 + 10) * spell_earth_time, z = v.z * 10 * spell_earth_time })
                    end
                    ::continue::
                end
                meta:set_float("magikacia:spell_earth_time_active", 0)
            else
                meta:set_float("magikacia:spell_earth_time_active", spell_earth_time + dtime)
            end
        end
    end)
end
