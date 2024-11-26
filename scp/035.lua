mcl_util._scp_scp_035_activated = mcl_util._scp_scp_035_activated or false
mcl_death_messages.messages.scp_035 = { plain = "@1 was snuffed out by SCP-035." }
mcl_damage.types.scp_035 = { bypasses_armor = true, bypasses_magic = true, bypasses_invulnerability = true, bypasses_totem = false }
local dialogs = {
    intro = {
        [["Oh thank goodness! Someone actually found me." [Chuckles] ]],
        [["I can get us both safely out, just get to the lower floors and find the helicopter for me."]]
    },
    ambient = {
        [["Well, what are you waiting for?"]],
        [[[Sighs] "I'm starting to lose my patience here."]],
        [["What are you doing just standing there?"]],
        [["You know, the Mobile Task Force will be coming by any minute now, guess what they do to someone like us?"]],
        [[[Voice getting gradually more demonic] "Why haven't you escaped yet? Fine, good luck getting out all on your own."]],
        [["Are you even listening?"]],
    },
    hostile = {
        [["Go and find fresh flesh for us..." [Wheezes] "We are getting hungry..."]],
        [["ATTACK SOMEONE!"]],
        [["Please... I need you to kill someone... We are getting hungry..."]],
        [["Find me a victim. Kill them."]],
        [["PUNCH PUNCH PUNCH SOMEONE"]],
    },
    outro = {
        [["So, you chose to die here over wearing me? Very well."]],
        [["You shouldn't have taken me off. You're not getting out."]],
        [["You fool. There's no hope for for survival without me."]],
        [[[Harsh chuckle] "You are nothing without me. You might as well get rid of your face."]]
    }
}
local function valid_object_iterator(objects)
    local i = 0
    local function next_valid_object()
        i = i + 1
        local obj = objects[i]
        if obj == nil then return end
        if obj:get_pos() then return obj end
        return next_valid_object()
    end
    return next_valid_object
end

function mcl_util.connected_players(center, radius)
    local pls = minetest.get_connected_players()
    if not center then return valid_object_iterator(pls) end
    local rpls = {}
    for _, pl in pairs(pls) do if pl:get_pos() and vector.distance(center, pl:get_pos()) <= radius then table.insert(
            rpls, pl) end end
    return valid_object_iterator(rpls)
end

local function mask_say(player, text)
    minetest.chat_send_player(player:get_player_name(), minetest.colorize(mcl_colors.RED, tostring(text)))
end
local function mask_dialog_say(player, msgtype)
    local msg = "[SCP-035] "
    if msgtype == "hostile" then
        msg = msg ..  "[Aggressively] Attack someone- "
    end
    msg = msg .. table.random_element(dialogs[msgtype])
    mask_say(player, msg)
end
local function drop_mask(player)
    if not player or not player:is_player() or not player:get_pos() then return end
    if not minetest.registered_tools["scp:scp_035"] or not ItemStack("scp:scp_035") then return end
    local inv = player:get_inventory()
    if not inv then return end
    local armor_list = inv:get_list("armor")
    if not armor_list then return end
    if armor_list[2]:get_name() == "scp:scp_035" then
        minetest.add_item(vector.add(player:get_pos(), { x = 0, y = 1, z = 0 }), ItemStack("scp:scp_035"))
        inv:set_stack("armor", 2, ItemStack(""))
    elseif inv:contains_item("main", "scp:scp_035") then
        minetest.add_item(vector.add(player:get_pos(), { x = 0, y = 1, z = 0 }), ItemStack("scp:scp_035"))
        inv:remove_item("main", "scp:scp_035")
    end
    mcl_inventory.update_inventory(player)
    mcl_armor.update(player)
end
minetest.register_tool(":scp:scp_035", {
    description = core.colorize("#f00", "SCP-035"),
    _doc_items_longdesc = mcl_armor.longdesc,
    _doc_items_usagehelp = mcl_armor.usage,
    inventory_image =
    "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAdklEQVQ4jdWSSxKAIAxDG/c5Q0/C/Y8VNzgjtkUc3fhmWBCa8ClmvweZKElpMRDqg1CZq5BhcmfOQrYVw4wQAMCSq5b69ydwdyMZCiv9iiSptaYrJNUfeXjo0AUAVjXjWMv+wxDSdwljtc0D7i6Sz41nXgfM2AG8KkV9KPPvbgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    groups = { armor = 1, non_combat_armor = 1, armor_head = 1, non_combat_head = 1, mcl_armor_uses = 10 },
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_leather",
        _mcl_armor_unequip = "mcl_armor_unequip_leather",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "head",
    _mcl_armor_texture =
    "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAh0lEQVRoge3UTQqEMAyG4UTc9wzpCXr/y32zmZRBREEdOqPvA1n0DxKa1gwAADyVj05gjyRtrbv7qRqmM4fv4Kc7IG8/LzmbYWV8uI7Hd8A8OoEt7m6STJLVWvt8RFgppe+5rfcT0FJrTZ9ro/P8qix0La4o/i/+AEkWEf05ZAAAAAAAABzxAhJdUbq25Fm/AAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    _on_equip = function(obj, itemstack)
        mask_say(obj, "You have been possessed by SCP-035!")
        mask_say(obj,
            '[SCP-035] "Oh thank goodness! Someone actually found me." [Chuckles]\n[SCP-035] "I can get us both safely out, just get to the lower floors and find the helicopter for me."\n[SCP-035] "I crave for blood though... kill people before you die"')
    end,
    _on_unequip = function(obj, itemstack)
        mask_say(obj, "SCP-035 killed you because you toook it off!")
        mask_dialog_say(obj, "outro")
        mcl_util.deal_damage(obj, 1000, { type = "scp_035" })
    end,
    _on_break = function(obj)
    end,
    on_pickup = function(itemstack, picker, pointed_thing, time_from_last_punch, ...)
        mcl_armor.equip_on_use(itemstack, picker, pointed_thing)
        return ItemStack("")
    end,
})
if not mcl_util._scp_scp_035_activated then
    mcl_util._scp_scp_035_activated = true
    mcl_player.register_globalstep_slow(function(player)
        if not player or not player:get_pos() then return end
        if not minetest.registered_tools["scp:scp_035"] then return end
        local inv = player:get_inventory()
        local armor_list = inv and inv:get_list("armor")
        if not armor_list or not armor_list[2] then return end
        if armor_list[2]:get_name() == "scp:scp_035" then
            if math.random() < 0.1 then
                mask_dialog_say(player, "ambient")
                mcl_util.deal_damage(player, 1, { type = "scp_035" })
            end
            if math.random() < 0.1 then
                mask_dialog_say(player, "hostile")
                mcl_util.deal_damage(player, 1, { type = "scp_035" })
                local that = nil
                local players = {}
                for k, v in mcl_util.connected_players(player:get_pos(), 16) do
                    players[#players + 1] = v
                end
                that = table.random_element(players) or nil
                if not that or not that:get_pos() then return end
                local tp = that:get_pos()
                local sp = player:get_pos()
                player:set_look_horizontal(math.atan2(tp.z - sp.z, tp.x - sp.x))
            end
        end
    end)

    minetest.register_on_dieplayer(function(player, reason)
        pcall(function() drop_mask(player) end)
    end)
    minetest.register_on_leaveplayer(function(player)
        pcall(function() drop_mask(player) end)
    end)
end