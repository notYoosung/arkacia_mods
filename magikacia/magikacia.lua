local modname = "magikacia"
local vector = vector
local minetest = minetest


local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize

local spellbook_types = {
    "iron",
    "gold",
    "diamond",
    "netherite",
}


local max_text_length = 12800
local max_title_length = 128


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
        --[["textarea[0.75,0.1;7.25,9;text;;" .. minetest.formspec_escape(text) .. "]",
        "button[0.75,7.95;3,1;sign;" .. minetest.formspec_escape(S("Sign")) .. "]",
        "button_exit[4.25,7.95;3,1;ok;" .. minetest.formspec_escape(S("Done")) .. "]",]]
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
















local runes = {
    "earth",
    "electric",
    "fire",
    "ice",
    "telepathic",
    "void",
    "water",
    "wind",
    "disguise",
    "resize",
    "poison",
    "healing",
    "summoning",
    "shield",
    ""
}
for _, v in ipairs(runes) do
    minetest.register_craftitem(":" .. modname .. ":rune_" .. v, {
        description = "Rune: " .. v,
        inventory_image = magikacia.textures["rune_" .. v] or nil,
    })
end












local wield3d = {}

local player_wielding = {}
local update_time = minetest.settings:get("wield3d_update_time")
local verify_time = minetest.settings:get("wield3d_verify_time")
local wield_scale = minetest.settings:get("wield3d_scale")

update_time = update_time and tonumber(update_time) or 1
verify_time = verify_time and tonumber(verify_time) or 10
wield_scale = wield_scale and tonumber(wield_scale) or 0.25 --[[default scale]]

local location = {
    "Arm_Right",                    --[[default bone]
    { x = 0, y = 2 / 16, z = 0 },   --[[default position]]
    { x = 0, y = 0,      z = 0 },   --[[default rotation]]
    { x = 5, y = 5,      z = 0.5 }, --[[visual size]]
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
    --[[is_visible = false,]]
    visual = "cube",
    mesh = "flat_plane.obj",
    textures = {
        --[[{
        name =]]
        "temp_magic_circle.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        "blank.png",
        --[[ 	animation = {
        		type = "vertical_frames",
        		aspect_w = 210,
        		aspect_h = 210,
        		length = 75 * 0.06,
        	}
        },
        {name = "blank.png"},
        {name = "blank.png"},
        {name = "blank.png"},
        {name = "blank.png"},
        {name = "blank.png"},]]
    },
    wielder = nil,
    timer = 0,
    static_save = false,
    visual_size = { x = 10, y = 0, z = 10 },
    glow = 14,
    automatic_rotate = 0.25,
    --[[wield_image = "magic_circle.png",
    use_texture_alpha = true,
    _pos = vector.zero(),]]
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

                --[[The book copy counter. 0 = original, 1 = copy of original, 2 = copy of copy of original, …]]
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
        inv:set_size("spellbook_inv", 3)
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
            if (nunderdef.opaque or nunderdef.walkable == true) and nodeunder.name ~= "air" and player:get_velocity().y <= 0 and spell_earth_time > 1.2 then
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
                        --[[attached = player,]]
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
                        obj:add_velocity({ x = v.x * 10 * spell_earth_time, y = (v.y * 1 + 10) * spell_earth_time, z = v.z * 10 * spell_earth_time })
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














mcl_mobs.register_mob("mobs_mc:endermite", {
    description = "Endermite",
    type = "monster",
    spawn_class = "hostile",
    passive = false,
    hp_min = 8,
    hp_max = 8,
    xp_min = 3,
    xp_max = 3,
    armor = { fleshy = 100, arthropod = 100 },
    group_attack = true,
    collisionbox = { -0.2, -0.01, -0.2, 0.2, 0.29, 0.2 },
    visual = "mesh",
    mesh = "mobs_mc_endermite.b3d",
    textures = {
        { magikacia.textures.mobs_adminite },
    },
    visual_size = { x = 3, y = 3 },
    makes_footstep_sound = false,
    sounds = {
        random = "mobs_mc_endermite_random",
        damage = "mobs_mc_endermite_hurt",
        death = "mobs_mc_endermite_death",
        distance = 16,
    },
    walk_velocity = 2,
    run_velocity = 4,
    animation = {
        stand_start = 0,
        stand_end = 0,
        walk_start = 0,
        walk_end = 20,
        walk_speed = 55
    },
    jump = true,
    fear_height = 4,
    view_range = 16,
    damage = 2,
    reach = 1,
})

mcl_mobs.register_egg("mobs_mc:endermite", "Endermite", "#161616", "#6d6d6d", 0)
