local modname = "magikacia"
local vector = vector
local minetest = minetest


local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local max_text_length = 4500  
local max_title_length = 64


 

 


local header = ""
if minetest.get_modpath("mcl_init") then
    header = "no_prepend[]" .. mcl_vars.gui_nonbg .. mcl_vars.gui_bg_color ..
        "style_type[button;border=false;bgimg=mcl_books_button9.png;bgimg_pressed=mcl_books_button9_pressed.png;bgimg_middle=2,2]"
end

 
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
     
     
    local text = itemstack:get_meta():get_string("text")
    local formspec = table.concat({
        "formspec_version[4]",
        "size[14.6,9]",
        header,
        "background[-0.5,-0.5;9,10;z_magic_page_left.png]",
        "background[7.5,-0.5;9,10;z_magic_page_right.png]",
        "background[7.5,-0.5;9,10;z_magic_page_button_yes.png]",
        "background[7.5,-0.5;9,10;z_magic_page_button_no.png]",
         
         
         
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
local gauntlet_use_primary = function(itemstack, placer, pointed_thing)
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
    if use_pos and has_in_gauntlet(placer, modname .. ":rune_fire") then
        for _, k in ipairs(around_circle_3_pos_list) do
            safe_replace({ x = use_pos.x + k[1], y = use_pos.y, z = use_pos.z + k[2] }, "mcl_fire:fire", placer)
        end
        use_success = true
        use_at_place = true
    end
    if use_pos and has_in_gauntlet(placer, modname .. ":rune_lightning") then
        mcl_lightning.strike(use_pos)
        use_success = true
        use_at_place = true
    end
    if use_pos and has_in_gauntlet(placer, modname .. ":rune_ender") then
        if pointed_thing.type == "node" then
            placer:set_pos({ x = use_pos.x, y = use_pos.y - 0.5, z = use_pos.z })
        else
            placer:set_pos(use_pos)
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
    if use_pos and has_in_gauntlet(placer, modname .. ":rune_wind_blast") then
        for obj, _ in minetest.objects_inside_radius(use_pos, 8) do
            if not obj then goto continue end
            if (obj:get_luaentity() ~= nil
                    and obj:get_luaentity().name ~= "mcl_chests:chest"
                    and obj:get_luaentity().name ~= "mcl_itemframes:item"
                    and obj:get_luaentity().name ~= "mcl_enchanting:book")
                or obj:is_player()
            then
                local newvel = vector.offset(
                    vector.multiply(vector.normalize(vector.subtract(obj:get_pos(), use_pos)), 10), 0, 10, 0)
                obj:add_velocity(newvel)
            end
            ::continue::
        end
        use_success = true
        use_at_place = true
         
    end

    if use_at_place then
        minetest.add_particle({
            pos = use_pos,
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
    if use_at_self then
        minetest.add_particle({
            pos = placer:get_pos(),
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

    if use_success then
        minetest.sound_play("mcl_enchanting_enchant", { pos = use_pos, max_hear_distance = 64 }, true)
    end
    return nil
end

local gauntlet_use_secondary = function(itemstack, placer, pointed_thing)
    if not placer:is_player() then return end
    local placer_name = placer:get_player_name()
    if controls.players[placer_name].sneak[1] then
        minetest.show_formspec(placer_name, "magic:gauntlet_inv", gauntlet_inv_formspec)
    end
    return nil
end

minetest.register_tool(":" .. modname .. ":gauntlet", {
    description = "Magic Gauntlet",
    inventory_image = magikacia.textures.gauntlet,
    on_secondary_use = gauntlet_use_secondary,
    on_place = gauntlet_use_secondary,
    on_use = gauntlet_use_primary,
    range = 32,
})



local runes = {
    "fire",
    "lightning",
    "ender",
    "earth",
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
wield_scale = wield_scale and tonumber(wield_scale) or 0.25  

local location = {
    "Arm_Right",                     
    { x = 0, y = 2 / 16, z = 0 },    
    { x = 0, y = 0,      z = 0 },    
    { x = 5, y = 5,      z = 0.5 },  
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
     
    visual = "cube",
    mesh = "flat_plane.obj",
    textures = {
         
         
        "temp_magic_circle.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
         
         
         
         
         
         
         
         
         
         
         
         
    },
    wielder = nil,
    timer = 0,
    static_save = false,
    visual_size = { x = 10, y = 0, z = 10 },
    glow = 14,
    automatic_rotate = 0.25,
     
     
     
}


function magic_circle_entity:on_activate(staticdata)
    if staticdata and staticdata ~= "" then
        self.wielder = staticdata
        return
    end
    self.object:remove()
end

 


function magic_circle_entity:on_step(dtime)
     
    self.timer = self.timer + (dtime * 25)
    if self.timer > 360 then self.timer = self.timer - 360 end
    local player = minetest.get_player_by_name(self.wielder)
    if player == nil or not player:is_player() then
        self.object:remove()
        return
    end
    local wield = player_wielding[self.wielder]
     
     
    if self.object and wield then
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
    end
     
end

minetest.register_entity(":" .. modname .. ":magic_magic_circle", magic_circle_entity)

 
local function add_magic_circle_entity(player)
    if not player or not player:is_player() then return end
    local name = player:get_player_name()
    local pos = player:get_pos()
    if name and pos and not player_wielding[name] then
        pos.y = pos.y + 0.5
        local object = minetest.add_entity(pos, modname .. ":magic_magic_circle", name)
        if object then
            object:set_attach(player, "", location[2], location[3], true)
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
             
            player_wielding[name] = {
                item = "",
                location = location
            }
             
        end
    end
end

 
 
 
 
 

 
 
 



 
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

     
    if generation >= 2 then
        return ItemStack("")
    end

     
    local imeta = itemstack:get_meta()
    imeta:from_table(ometa:to_table())
    imeta:set_string("title", cap_text_length(ometa:get_string("title"), max_title_length))
    imeta:set_string("text", cap_text_length(ometa:get_string("text"), max_text_length))

     
    generation = generation + 1
    if generation < 1 then
        generation = 1
    end

    imeta:set_string("description",
        make_description(ometa:get_string("title"), ometa:get_string("author"), generation))
    imeta:set_int("generation", generation)
    return itemstack, original, index
end

 
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
                        obj:add_velocity({ x = v.x * 10 * spell_earth_time, y = (v.y * 10 + 20) * spell_earth_time, z = v
                        .z * 10 * spell_earth_time })
                    end
                    if (obj:is_player() and obj:get_player_name() ~= player:get_player_name()) then
                        local v = vector.normalize(vector.subtract(obj:get_pos(), pos))
                        obj:add_velocity({ x = v.x * 10 * spell_earth_time, y = (v.y * 10 + 10) * spell_earth_time, z = v
                        .z * 10 * spell_earth_time })
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
