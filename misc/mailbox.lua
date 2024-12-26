--[[local minetest = minetest]]

local blank = "blank.png^[png:"

local mailbox_letterbox_bottom = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEUvQF4tPlwzMf3lAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg=="
local mailbox_letterbox_side = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAG1BMVEVOa50/Vn47UXh9lb6ZrMxog7OVqMozRmYvQF6K75IXAAAAUklEQVR4AVSMVwEFIRADY2FyB//rAQkBBfi38nqd7VUfMNwRQD2TAj87vpsYOZMgQ1trIo70nV0CzjmD8OjZC3HH/w/N8w9PRGEodF1FBxi0AwBzbhAC9lRFogAAAABJRU5ErkJggg=="
local mailbox_letterbox_top = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEVOa51NaZrtWhnRAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg=="
local mailbox_letterbox = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAHlBMVEVOa50/Vn47UXhHYY6RpcgvQF4oN1EzRmbV3eqltdJLbBGlAAAAYUlEQVR4AUXLsQ2AMAwEwF/BBos6QgzACEhZwJEiNkhPwRAp2Rh/CnjpPine+CIqI5iAfQ2Ycz4I1lohGOAEbjUKfEPCUutF3JSxsf64dYmPiG8BpslNpfxjSXEehbuOnC/ThRT9T/U3PwAAAABJRU5ErkJggg=="
local mailbox_mailbox_bottom = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAHlBMVEVOa50/Vn47UXhHYY6RpcgvQF4oN1EzRmbV3eqltdJLbBGlAAAAYUlEQVR4AUXLsQ2AMAwEwF/BBos6QgzACEhZwJEiNkhPwRAp2Rh/CnjpPine+CIqI5iAfQ2Ycz4I1lohGOAEbjUKfEPCUutF3JSxsf64dYmPiG8BpslNpfxjSXEehbuOnC/ThRT9T/U3PwAAAABJRU5ErkJggg=="
local mailbox_mailbox_free_bottom = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEU1hRkzfxlPJp4WAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg=="
local mailbox_mailbox_free_side = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAG1BMVEVc0jxAqihApSV4zXGJ2YlqxF6K1og8giQ7cyMyIbFWAAAAUklEQVR4AVSMVwEFIRADY2FyB//rAQkBBfi38nqd7VUfMNwRQD2TAj87vpsYOZMgQ1trIo70nV0CzjmD8OjZC3HH/w/N8w9PRGEodF1FBxi0AwBzbhAC9lRFogAAAABJRU5ErkJggg=="
local mailbox_mailbox_free_top = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEVc0jxbyT21WvskAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg=="
local mailbox_mailbox_free = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAHlBMVEVc0jxAqihApSVQvjKl6407cyMsLCw8giTP49mcvq0puNODAAAAYUlEQVR4AUXLsQ2AMAwEwF/BBos6QgzACEhZwJEiNkhPwRAp2Rh/CnjpPine+CIqI5iAfQ2Ycz4I1lohGOAEbjUKfEPCUutF3JSxsf64dYmPiG8BpslNpfxjSXEehbuOnC/ThRT9T/U3PwAAAABJRU5ErkJggg=="
local mailbox_mailbox_side = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAG1BMVEXSUDyqPCikNyXNi3HZpYnEd17WooiBLCRzJyNBugL+AAAAUklEQVR4AVSMVwEFIRADY2FyB//rAQkBBfi38nqd7VUfMNwRQD2TAj87vpsYOZMgQ1trIo70nV0CzjmD8OjZC3HH/w/N8w9PRGEodF1FBxi0AwBzbhAC9lRFogAAAABJRU5ErkJggg=="
local mailbox_mailbox_top = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEXSUDzJUD0E0jCzAAAAKElEQVR4AWMAAgEgbmDgEGBgZARxHQIYGJlADEEWoBxIigUsrsgBJAA1HAIRYYuAVgAAAABJRU5ErkJggg=="
local mailbox_mailbox = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAHlBMVEXSUDyqPCikNyW+RjLrloxzJyMsLCyBLCTj4M6+uZt9fGUNAAAAYUlEQVR4AUXLsQ2AMAwEwF/BBos6QgzACEhZwJEiNkhPwRAp2Rh/CnjpPine+CIqI5iAfQ2Ycz4I1lohGOAEbjUKfEPCUutF3JSxsf64dYmPiG8BpslNpfxjSXEehbuOnC/ThRT9T/U3PwAAAABJRU5ErkJggg=="
local mailbox_unrent = blank ..
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAANUlEQVR4AWP4//8/RRiJM2rAhckMz2CYZAMQmhGYZAPIwSgGkGoQxS4gKQwgfASbyrEwmpQB3VLVC0w9SnEAAAAASUVORK5CYII="

local mailbox = {}
_G.mailbox = mailbox

local S = minetest.get_translator("mailbox")
local FS = function(...) return minetest.formspec_escape(S(...)) end

local formspec_bg = ""
local get_hotbar_bg = function(a, b) return "" end

local function noop() end

mailbox.UNRENT_FAIL_REASONS = {
    ERR_NOT_EMPTY = S("The mailbox isn't empty."),
    ERR_NO_PRIVILEGE = S("You are not allowed to unrent this mailbox."),
}

local function can_manage(pos, player)
    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("owner")
    local pname = player:get_player_name()
    if owner ~= ""
        and owner ~= pname
        and not minetest.check_player_privs(pname, { protection_bypass = true }) then
        return false
    end
    return true
end

local function can_set_owner(player)
    local pname = player:get_player_name()
    return minetest.check_player_privs(pname, { protection_bypass = true })
end

function mailbox.set_owner(pos, pname)
    local node = minetest.get_node(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("owner", pname)
    if pname == "" then
        meta:set_string("infotext", S("Free Mailbox, right-click to claim"))
        node.name = "mailbox:mailbox_free"
        minetest.swap_node(pos, node)
    else
        meta:set_string("infotext", S("@1's Mailbox", pname))
        if node.name == "mailbox:mailbox_free" then
            node.name = "mailbox:mailbox"
            minetest.swap_node(pos, node)
        end
    end
end

function mailbox.rent_mailbox(pos, player)
    return mailbox.set_owner(pos, player:get_player_name())
end

function mailbox.unrent(pos, player, force, drop_pos)
    local meta = minetest.get_meta(pos)
    if not can_manage(pos, player) then
        return false, "ERR_NO_PRIVILEGE"
    end

    local inv = meta:get_inventory()
    if not force then
        if not inv:is_empty("mailbox") then
            return false, "ERR_NOT_EMPTY"
        end
    end

    drop_pos = drop_pos or pos
    for _, stack in pairs(inv:get_list("mailbox")) do
        minetest.add_item(drop_pos, stack)
    end

    inv:set_list("mailbox", {})
    mailbox.set_owner(pos, "")

    return true
end

local on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    inv:set_size("mailbox", 8 * 4)
    inv:set_size("drop", 1)
end

local after_place_node = function(pos, player)
    local pname = player:get_player_name()
    mailbox.set_owner(pos, pname)
end

local show_formspec = function(pos, owner, pname, pl_can_manage)
    local spos = pos.x .. "," .. pos.y .. "," .. pos.z
    local formspec = "size[8,5.5]" .. formspec_bg .. get_hotbar_bg(0, 1.5) ..
        "label[0,0;" .. FS("Send your goods\nto @1", owner) .. " :]" ..
        "list[nodemeta:" .. spos .. ";drop;3.5,0;1,1;]" ..
        "list[current_player;main;0,1.5;8,1;]" ..
        "list[current_player;main;0,2.75;8,3;8]" ..
        "listring[nodemeta:" .. spos .. ";drop]" ..
        "listring[current_player;main]"
    if pl_can_manage then
        formspec = formspec .. "button_exit[6,0;2,1;manage;" .. FS("Manage") .. "]"
    end
    minetest.show_formspec(pname, "mailbox:mailbox_" .. spos, formspec)
end

local show_manage_formspec = function(pos, pname, selected)
    local spos = pos.x .. "," .. pos.y .. "," .. pos.z
    local formspec = "size[8,9.5]" .. formspec_bg .. get_hotbar_bg(0, 5.5) ..
        "checkbox[0,0;books_only;" .. FS("Only allow written books") .. ";" .. selected .. "]" ..
        "list[nodemeta:" .. spos .. ";mailbox;0,1;8,4;]" ..
        "list[current_player;main;0,5.5;8,1;]" ..
        "list[current_player;main;0,6.75;8,3;8]" ..
        "listring[nodemeta:" .. spos .. ";mailbox]" ..
        "listring[current_player;main]" ..
        "button_exit[5,0;2,1;unrent;" .. FS("Unrent") .. "]" ..
        "button_exit[7,0;1,1;exit;X]"
    minetest.show_formspec(pname, "mailbox:mailbox_" .. spos, formspec)
end

local show_change_owner_formspec = function(pos, pname)
    local spos = pos.x .. "," .. pos.y .. "," .. pos.z
    local formspec = "field[new_owner;" .. FS("New owner:") .. ";]"
    minetest.show_formspec(pname, "mailbox:mailbox_" .. spos, formspec)
end

local on_rightclick = function(pos, node, player, itemstack, pointed_thing)
    if not player:is_player() then return end

    local nodename = node.name
    if itemstack:get_name() == "mailbox:unrenter" then
        local drop_pos = pointed_thing.above
        mailbox.unrent(pos, player, true, drop_pos)
        return itemstack
    end

    local pname = player:get_player_name()
    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("owner")
    if owner == pname then
        local selected = nodename == "mailbox:letterbox" and "true" or "false"
        show_manage_formspec(pos, pname, selected)
    else
        show_formspec(pos, owner, pname, can_manage(pos, player))
    end
end

local on_punch = function(pos, node, player, pointed_thing)
    if not player:is_player() then
        return minetest.node_punch(pos, node, player, pointed_thing)
    end

    local wielded = player:get_wielded_item()
    if wielded:get_name() ~= "mailbox:unrenter" then
        return minetest.node_punch(pos, node, player, pointed_thing)
    end

    local pname = player:get_player_name()
    if not can_set_owner(player) then
        minetest.chat_send_player(pname, S("You cannot set owner of mailboxes for others."))
        return
    end

    show_change_owner_formspec(pos, pname)
end

local free_on_rightclick = function(pos, _, player, itemstack)
    if not player:is_player() then return end
    if itemstack:get_name() == "mailbox:unrenter" then return end

    mailbox.rent_mailbox(pos, player)
end

local can_dig = function(pos, player)
    if not can_manage(pos, player) then
        return false
    end

    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    return inv:is_empty("mailbox")
end

local allowed_books = {
    ["default:book_written"] = true,
    ["mcl_books:written_book"] = true,
}

local allow_metadata_inventory_put = function(pos, listname, _, stack, player)
    if listname == "mailbox" then
        return can_manage(pos, player) and stack:get_count() or 0
    elseif listname == "drop" then
        local node = minetest.get_node(pos)
        if node.name == "mailbox:letterbox" and not allowed_books[stack:get_name()] then
            minetest.chat_send_player(player:get_player_name(), S("Only written books are accepted."))
            return 0
        end
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        if inv:room_for_item("mailbox", stack) then
            return stack:get_count()
        else
            minetest.chat_send_player(player:get_player_name(), S("Mailbox full."))
        end
    end
    return 0
end

local on_metadata_inventory_put = function(pos, listname, _, stack)
    if listname == "drop" then
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_stack("drop", 1, inv:add_item("mailbox", stack))
    end
end

local allow_metadata_inventory_move = function(pos, from_list, _, to_list, _, count, player)
    if from_list ~= to_list then
        return 0
    elseif from_list == "mailbox" then
        return can_manage(pos, player) and count or 0
    elseif from_list == "drop" then
        return count
    end
    return 0
end

local allow_metadata_inventory_take = function(pos, listname, _, stack, player)
    if listname == "mailbox" then
        return can_manage(pos, player) and stack:get_count() or 0
    elseif listname == "drop" then
        return stack:get_count()
    end
    return 0
end

local after_dig_node = nil
local mail_pipeworks = nil
mcl_util._mailbox_activated = mcl_util._mailbox_activated or false
if not mcl_util._mailbox_activated then
    minetest.log("error", "mailbox_activated")
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if not formname:match("mailbox:mailbox_") then
            return
        end
        local pos = minetest.string_to_pos(formname:sub(17))
        local node = minetest.get_node(pos)
        local pname = player:get_player_name()
        local nodegroup = minetest.get_item_group(node.name, "mailbox")
        if fields.new_owner and nodegroup ~= 0 then
            if not can_set_owner(player) then
                minetest.chat_send_player(pname, S("You cannot set owner of mailboxes for others."))
                return true
            end

            mailbox.set_owner(pos, fields.new_owner)
        elseif nodegroup ~= 1 then
            minetest.chat_send_player(pname, S("The node you were working on is no longer a mailbox."))
        elseif fields.unrent then
            local status, reason = mailbox.unrent(pos, player)
            if not status then
                minetest.chat_send_player(pname, mailbox.UNRENT_FAIL_REASONS[reason])
            end
            return true
        elseif fields.books_only then
            if not can_manage(pos, player) then
                minetest.chat_send_player(pname, S("You can't manage this mailbox."))
                return true
            end
            node.name = node.name == "mailbox:mailbox" and "mailbox:letterbox" or "mailbox:mailbox"
            minetest.swap_node(pos, node)
        elseif fields.manage then
            if not can_manage(pos, player) then
                minetest.chat_send_player(pname, S("You can't manage this mailbox."))
                return true
            end
            local selected = node.name == "mailbox:letterbox" and "true" or "false"
            show_manage_formspec(pos, pname, selected)
        end
        return true
    end)
    mcl_util._mailbox_activated = true
end

minetest.register_node(":mailbox:mailbox", {
    description = S("Mailbox"),
    tiles = {
        mailbox_mailbox_top, mailbox_mailbox_bottom,
        mailbox_mailbox_side, mailbox_mailbox_side,
        mailbox_mailbox, mailbox_mailbox,
    },
    groups = {
        dig_immediate = 3,
        mailbox = 1,
        cracky = 3,
        oddly_breakable_by_hand = 1,
        tubedevice = 1,
        tubedevice_receiver = 1
    },
    on_rotate = minetest.global_exists("screwdriver") and screwdriver.rotate_simple or nil,
    sounds = mcl_sounds.node_sound_stone_defaults(),
    paramtype2 = "facedir",
    on_construct = on_construct,
    after_place_node = after_place_node,
    after_dig_node = after_dig_node,
    on_rightclick = on_rightclick,
    on_punch = on_punch,
    can_dig = can_dig,
    on_metadata_inventory_put = on_metadata_inventory_put,
    allow_metadata_inventory_put = allow_metadata_inventory_put,
    allow_metadata_inventory_take = allow_metadata_inventory_take,
    allow_metadata_inventory_move = allow_metadata_inventory_move,
    tube = mail_pipeworks,
    on_blast = noop,
})

minetest.register_node(":mailbox:mailbox_free", {
    description = S("Mailbox for Rent"),
    tiles = {
        mailbox_mailbox_free_top, mailbox_mailbox_free_bottom,
        mailbox_mailbox_free_side, mailbox_mailbox_free_side,
        mailbox_mailbox_free, mailbox_mailbox_free,
    },
    groups = {
        dig_immediate = 3,
        mailbox = 2,
        cracky = 3,
        oddly_breakable_by_hand = 1,
        tubedevice = 1,
        tubedevice_receiver = 1
    },
    on_rotate = minetest.global_exists("screwdriver") and screwdriver.rotate_simple or nil,
    sounds = mcl_sounds.node_sound_stone_defaults(),
    paramtype2 = "facedir",
    drop = "mailbox:mailbox",
    on_construct = on_construct,
    on_rightclick = free_on_rightclick,
})

minetest.register_node(":mailbox:letterbox", {
    tiles = {
        mailbox_letterbox_top, mailbox_letterbox_bottom,
        mailbox_letterbox_side, mailbox_letterbox_side,
        mailbox_letterbox, mailbox_letterbox,
    },
    groups = {
        dig_immediate = 3,
        mailbox = 1,
        cracky = 3,
        oddly_breakable_by_hand = 1,
        not_in_creative_inventory = 1,
        tubedevice = 1,
        tubedevice_receiver = 1
    },
    on_rotate = minetest.global_exists("screwdriver") and screwdriver.rotate_simple or nil,
    sounds = mcl_sounds.node_sound_stone_defaults(),
    paramtype2 = "facedir",
    drop = "mailbox:mailbox",
    on_construct = on_construct,
    after_place_node = after_place_node,
    after_dig_node = after_dig_node,
    on_rightclick = on_rightclick,
    on_punch = on_punch,
    can_dig = can_dig,
    on_metadata_inventory_put = on_metadata_inventory_put,
    allow_metadata_inventory_put = allow_metadata_inventory_put,
    allow_metadata_inventory_take = allow_metadata_inventory_take,
    allow_metadata_inventory_move = allow_metadata_inventory_move,
    tube = mail_pipeworks,
})

minetest.register_tool(":mailbox:unrenter", {
    short_description = S("Mailbox owner modifier"),
    description = table.concat({
        S("Mailbox owner modifier"),
        S("Punch: Change owner"),
        S("Right-click: Move owner out")
    }, "\n"),
    inventory_image = mailbox_unrent,
})


local materials = {
    sand = "mcl_core:sand",
    sandstone = "mcl_core:sandstone",
    gravel = "mcl_core:gravel",
    flint = "mcl_core:flint",
    copper_ingot = "mcl_copper:copper_ingot",
    steel_ingot = "mcl_core:iron_ingot",
    gold_ingot = "mcl_core:gold_ingot",
    tin_ingot = "mcl_core:iron_ingot",
    copper_block = "mcl_copper:copper_block",
    steel_block = "mcl_core:iron_block",
    gold_block = "mcl_core:gold_block",
    tin_block = "mcl_core:iron_block",
    axe_steel = "mcl_core:axe_steel",
    axe_diamond = "mcl_core:axe_diamond",
    axe_bronze = "mcl_core:axe_bronze",
    axe_stone = "mcl_core:axe_stone",
    axe_wood = "mcl_core:axe_wood",
    pick_steel = "mcl_core:pick_steel",
    mese = "mesecons_torch:redstoneblock",
    mese_crystal = "mesecons:redstone",
    mese_crystal_fragment = "mcl_core:iron_ingot",
    torch = "mcl_torches:torch",
    diamond = "mcl_core:diamond",
    clay_lump = "default:clay_lump",
    water_bucket = "mcl_buckets:bucket_water",
    empty_bucket = "mcl_buckets:bucket_empty",
    dye_dark_grey = "mcl_dyes:dark_grey",
    dye_black = "mcl_dyes:black",
    dye_white = "mcl_dyes:white",
    dye_green = "mcl_dyes:green",
    dye_red = "mcl_dyes:red",
    dye_yellow = "mcl_dyes:yellow",
    dye_brown = "mcl_dyes:brown",
    dye_blue = "mcl_dyes:blue",
    dye_violet = "mcl_dyes:violet",
    dye_grey = "mcl_dyes:grey",
    dye_dark_green = "mcl_dyes:dark_green",
    dye_orange = "mcl_dyes:orange",
    dye_pink = "mcl_dyes:pink",
    dye_cyan = "mcl_dyes:cyan",
    dye_magenta = "mcl_dyes:magenta",
    silicon = "mcl_core:iron_ingot",
    string = "mcl_mobitems:string",
    paper = "mcl_core:paper",
    book = "mcl_core:book",
    iron_lump = "mcl_core:stone_with_iron",
    wool_grey = "mcl_wool:grey",
    wool_green = "mcl_wool:green",
    wool_dark_green = "mcl_wool:dark_green",
    wool_brown = "mcl_wool:brown",
    wool_black = "mcl_wool:black",
    wool_white = "mcl_wool:white",
    slab_stone = "mcl_stairs:slab_stone",
    slab_wood = "mcl_stairs:slab_wood",
    glass = "mcl_core:glass",
    glass_block = "mcl_core:glass",
    glass_bottle = "mcl_core:glass_bottle",
    coal_lump = "mcl_core:coal",
    stone = "mcl_core:stone",
    desert_stone = "mcl_core:redsandstone",
    desert_sand = "mcl_core:sand",
    chest = "mcl_chests:chest",
    cobble = "mcl_core:cobble",
    brick = "mcl_core:brick",
    obsidian_glass = "",
    water_source = "mcl_core:water_source",
    water_flowing = "mcl_core:water_flowing",
    dirt = "mcl_core:dirt",
    dirt_with_grass = "mcl_core:dirt_with_grass",
    apple_leaves = "mcl_trees:leaves_oak",
    apple_log = "mcl_trees:tree_oak",
    apple_planks = "mcl_trees:wood_oak",
    birch_leaves = "mcl_trees:leaves_birch",
    birch_log = "mcl_trees:tree_birch",
    birch_planks = "mcl_trees:wood_birch",
    jungle_leaves = "mcl_trees:leaves_jungle",
    bowl = "mcl_core:bowl",
    stick = "mcl_core:stick",
}
minetest.register_craft({
    output = "mailbox:mailbox",
    recipe = {
        { materials.steel_ingot, materials.steel_ingot, materials.steel_ingot },
        { materials.book,        materials.chest,       materials.book },
        { materials.steel_ingot, materials.steel_ingot, materials.steel_ingot }
    }
})
