local modname = "magikacia"
local vector = vector
local minetest = minetest


local S = minetest.get_translator(minetest.get_current_modname())
local F = minetest.formspec_escape
local C = minetest.colorize


function magikacia.safe_replace(pos, node_name, placer)
    if not pos then return end
    local node = minetest.get_node(pos)
    if node and (node.name == "air" or minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].buildable_to == true) and not minetest.is_protected(pos, placer:get_player_name()) then
        minetest.set_node(pos, { name = node_name })
    end
end

magikacia.spellbook_types = {
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
















magikacia.runes = {
    {
        name = "Earth",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Electric",
        description = "",
        spell_descriptions = {
            left = "Taser - Click to create a shocking burst! Burst range: 2 blocks",
            left_sneak = "",
            right = "Electric Bolt - Summon a lightning strike!",
        }
    },
    {
        name = "Fire",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Ice",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Telepathic",
        description = "",
        spell_descriptions = {
            left = "Teleport - Teleport to where you click!",
            left_sneak =
            "Entity Swap/Teleport - If pointing at an entity, swap places with it. Otherwise, teleport like normal!",
            right = "Evasion - Teleport to a random and nearby place!",
        }
    },
    {
        name = "Void",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Water",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Wind",
        description = "",
        spell_descriptions = {
            left = "Burst - Push mobs/players away! Range: 8 Blocks",
            left_sneak = "Cyclone - Suck entities upward in a whirlwind!",
            right = "Wind Riptide - Get a powerful jump in the direction you look!",
        }
    },
    {
        name = "Disguise",
        description = "Warning: Complicated use!",
        spell_descriptions = {
            left =
            "Save an mob/player's or node's look! Click on the same material to clear the save!\n    If a look is saved and you click on an mob/player, it be disguised with the look!",
            left_sneak = "Same as left click!",
            right = "If a look is saved, disguise yourself! If not, save your current look!",
        }
    },
    {
        name = "Resize",
        description = "",
        spell_descriptions = {
            left = "Growth - If looking at a mob/player, make it bigger! If not, then make yourself bigger!",
            left_sneak = "Same as left click!",
            right = "Shrink - If looking at a mob/player, make it smaller! If not, then make yourself smaller!",
        }
    },
    {
        name = "Poison",
        description = "",
        spell_descriptions = {
            left = "Silent But Deadly - Release a toxic cloud where you click! Range: 3 Blocks",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Healing",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Summoning",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Shield",
        description = "",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    },
    {
        name = "Absolute Solver",
        description = "The Solver of the Absolute Fabric. The Void. The Exponential End.",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "[NULL]",
        }
    },
    {
        name = "Protection",
        description = "After selecting an area, do \"/protect (area name)\" to protect it!",
        spell_descriptions = {
            left = "Position 1 - Select the first position!",
            left_sneak = "Same as left click!",
            right = "Position 2 - Select the second position!",
        }
    },
    {
        name = "Nature",
        description = "",
        spell_descriptions = {
            left = "Green Thumb - Bonemeal nearby blocks!",
            left_sneak = "Same as left click!",
            right = "",
        }
    },
    {
        name = "Bubble",
        description = "",
        spell_descriptions = {
            left = "Bubble Blower - Blow a wave of powerful bubbles! (Causes poison and knockback!)",
            left_sneak = "Same as left click!",
            right = "Bubble Block - Create a block of bubbles! No fall damage, but breaks if you stand on it!",
        }
    },
    {
        name = "Rope",
        description = "dont do anythin weird with it- o.o-",
        spell_descriptions = {
            left = "",
            left_sneak = "",
            right = "",
        }
    }
}
local color_list = {
    mcl_colors.DARK_GREEN,
    mcl_colors.RED,
    mcl_colors.AQUA,
}
local function c(color_id, text)
    return minetest.colorize(color_list[color_id], text)
end
for _, v in ipairs(magikacia.runes) do
    local formattedname = v.name:lower():gsub(" ", "_")
    local def = {
        description = table.concat({
            c(1, c(3, v.name .. " Rune")),
            c(1, "Description: ") .. c(3, v.description),
            c(1, "Left Click: ") .. c(3, v.spell_descriptions.left),
            c(1, "Sneak + Left Click: ") .. c(3, v.spell_descriptions.left_sneak),
            c(1, "Right Click: ") .. c(3, v.spell_descriptions.right),
            c(1, "Sneak + Right Click: ") .. c(3, "Open Spellbook Inventory"),
        }, "\n"),
        stack_size = 1,
    }
    local tex = magikacia.textures["rune_" .. formattedname]
    if tex and tex ~= "" then
        def.inventory_image = tex
    end
    minetest.register_craftitem(":" .. modname .. ":rune_" .. formattedname, def)
end


magikacia.cores = {
    {
        name = "Pacifist",
        description = "Attacks cause no direct damage! Oerfect for pranks or games!\n - Warning: Also cancels out damage from other cores!",
        modifiers = {
            damage = 0,
            physical_effect = 1,
            cooldown = 1,
            energy_cost = 1,
        },
    },
    {
        name = "Damage",
        description = "Deal more damage!",
        modifiers = {
            damage = 1.5,
            physical_effect = 1,
            cooldown = 1,
            energy_cost = 1,
        },
    },
    {
        name = "Behemoth",
        description = "Insane damage and effects, but long cooldown and high energy cost!",
        modifiers = {
            damage = 2,
            physical_effect = 2,
            cooldown = 2,
            energy_cost = 2,
        },
    },
    {
        name = "Jester",
        description = "Make bigger effects for a show, but takes more energy!",
        modifiers = {
            physical_effect = 3,
            energy_cost = 2,
        },
    },
    {
        name = "Absolutely Solved",
        description = "Attacks cause no direct damage! Perfect for pranks or games!\n - Warning: Also cancels out damage from other cores!",
        modifiers = {
            damage = 100,
            physical_effect = 100,
            cooldown = 0,
            energy_cost = 0,
        },
    },
}

local modifier_descriptions = {
    damage = "Damage: ",
    physical_effect = "Physical Effects (knockback, potion effects, etc.)",
    cooldown = "Cooldown (not added yet)",
    energy_cost = "Energy Cost (not added yet)",
}
for _, v in ipairs(magikacia.cores) do
    local formattedname = v.name:lower():gsub(" ", "_")
    local def = {
        description = table.concat({
            c(1, c(3, v.name .. " Core")),
            c(1, "Description: ") .. c(3, v.description),
            c(1, "Modifiers (multiplies original stats):"),
        }, "\n"),
        _magikacia_modifiers = v.modifiers,
        stack_size = 1,
    }
    local tex = magikacia.textures["core_" .. formattedname]
    if tex then
        def.inventory_image = tex
    end
    for _md, modifier_description in pairs(modifier_descriptions) do
        local modval = v.modifiers[_md]
        if modval then
            if modval < 1 and modval > 0 then
                def.description = def.description .. "\n - " .. c(1, modifier_description .. ": ") .. c(3, "÷" .. tostring(1 / v.modifiers[_md]))
            elseif modval ~= 1 then
                def.description = def.description .. "\n - " .. c(1, modifier_description .. ": ") .. c(3, "×" .. tostring(v.modifiers[_md]))
            end
        end
    end
    minetest.register_craftitem(":" .. modname .. ":core_" .. formattedname, def)
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
    "Arm_Right", --[[default bone]
    { x = 0, y = 2 / 16, z = 0 },   --[[default position]]
    { x = 0, y = 0, z = 0 }, --[[default rotation]]
    { x = 5, y = 5, z = 0.5 }, --[[visual size]]
}


local function sq_dist(a, b)
    local x = a.x - b.x
    local y = a.y - b.y
    local z = a.z - b.z
    return x * x + y * y + z * z
end



local wield3d_bone = "Arm_Right"
local wield3d_pos = { x = 0, y = 5.5, z = 3 }
local scale = { x = 0.25, y = 0.25 }
local wield3d_rx = -90
local wield3d_rz = 90

wield3d.location = {
    ["default:torch"] = { wield3d_bone, wield3d_pos, { x = wield3d_rx, y = 180, z = wield3d_rz }, scale },
    ["default:sapling"] = { wield3d_bone, wield3d_pos, { x = wield3d_rx, y = 180, z = wield3d_rz }, scale },
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

--[[:set_attach(parent[, bone, position, rotation, forced_visible])]]


function magic_circle_entity:on_step(dtime)
    --[[if self.wielder == nil then return end]]
    self.timer = self.timer + (dtime * 25)
    if self.timer > 360 then self.timer = self.timer - 360 end
    local player = minetest.get_player_by_name(self.wielder)
    if player == nil or not player:is_player() then
        self.object:remove()
        return
    end
    local wield = player_wielding[self.wielder]
    --[[local stack = player:get_wielded_item()
    local item = stack:get_name() or ""]]
    if self.object and wield then
        --[[if has_wieldview then
        		local def = minetest.registered_items[item] or {}
        		if def.inventory_image ~= "" then item = "" end
        	end
        	wield.item = item
        	if item == "" then item = modname .. ":magic_magic_circle" end
        	local loc = location
        	if loc[1] ~= wield.location[1] or not vector.equals(loc[2], wield.location[2]) or not vector.equals(loc[3], wield.location[3]) then
        if self.object:get_properties()._pos ~= player:get_pos() then
        -!	- self.object:set_attach(player, "", location[2], vector.add(location[3], {x=0, y=(self.timer), z=0}), true)
        self.object:set_properties({_pos = player:get_pos()})
        end
        wield.location = {loc[1], loc[2], loc[3]}
        	end
        	self.object:set_properties({
        		textures = {item},
        		visual_size = loc[4]
        	})]]
    end
    --[[self.timer = 0]]
end

minetest.register_entity(":" .. modname .. ":magic_magic_circle", magic_circle_entity)

--[[temp_magic_circle.png]]
local function add_magic_circle_entity(player)
    if not player or not player:is_player() then return end
    local name = player:get_player_name()
    local pos = player:get_pos()
    if name and pos and not player_wielding[name] then
        pos.y = pos.y + 0.5
        local object = minetest.add_entity(pos, modname .. ":magic_magic_circle", name)
        if object then
            object:set_attach(player, "", location[2], location[3], true)
            --[[object:set_properties({
            	- textures = {modname .. ":magic_magic_circle"},
            	- textures = {"magic_circle.png"},
            	textures = {
            		{
            			name = "magic_circle",
            			animation = {
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
            		{name = "blank.png"},
            	},
            	visual_size = location[4],
            })]]
            player_wielding[name] = {
                item = "",
                location = location
            }
            --[[object:set_properties({_pos = pos})]]
        end
    end
end

--[[minetest.register_item(modname .. ":magic_magic_circle", {
	type = "none",
	wield_image = "magic_circle.png",
	use_texture_alpha = "clip",
})

minetest.register_on_joinplayer(function(ObjectRef, last_login)
minetest.after(1, add_magic_circle_entity, ObjectRef)
end)]]



--[[pacman]]
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


    mcl_player.register_globalstep(function(player, dtime)
        if not player or not player:get_pos() then return end
        local pos = player:get_pos()
        local nunderpos = { x = pos.x, y = pos.y - 0.01, z = pos.z }
        local nodeunder = minetest.get_node(nunderpos)
        local meta = player:get_meta()
        local spell_earth_time = meta:get_float("magikacia:spell_earth_time_active") or 0
        local nunderdef = minetest.registered_nodes[nodeunder.name]
        if nunderdef and spell_earth_time > 0 then
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
                        obj:add_velocity({
                            x = v.x * 10 * spell_earth_time,
                            y = (v.y * 10 + 20) * spell_earth_time,
                            z = v
                                .z * 10 * spell_earth_time
                        })
                    end
                    if (obj:is_player() and obj:get_player_name() ~= player:get_player_name()) then
                        local v = vector.normalize(vector.subtract(obj:get_pos(), pos))
                        obj:add_velocity({
                            x = v.x * 10 * spell_earth_time,
                            y = (v.y * 1 + 10) * spell_earth_time,
                            z = v
                                .z * 10 * spell_earth_time
                        })
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











--[[
 OOP the texture is tiny its at the bottom of this text lol- (the eye has the colors of the arkacia flag lol)
Adminite
(it has the model of an endermite)
will walk around and has slightly fast speed kinda, abt the same walking speed as a player. Can be binded with commands to only attack certain mobs, or attack all mobs except that certain mob, (can be helpful to clean up spawn because mobs keep spawning and making it laggy)
command could be:
/adminite only mobs_mc_endermite
/\ only attack mobs_mc_endermite (can be replaced with any mob name)
/adminite except mobs_mc_endermite
/\ attack all mobs except mobs_mc_endermite (can be replcaed with any mob name)

maybe make it so that u hafta hold the specific spawn egg and all the spawn eggs in that current stack will be binded to the cmd-
also make it a special priv or smt- we dont want random players spawning them to kill everything XD
-
also wat if u can seperate the mob names with a comma , so u can do multiple than one mob to whitelist or blacklist XD
]]

mcl_mobs.register_mob(":magikacia:adminite", {
    description = "Adminite",
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
    reach = 3,
    owner_loyal = true,
    glow = 14,
    retaliates = true,
    follow_velocity = 5,
    stepheight = 1.1,
    runaway_from = { "player", "mobs_mc:cat" },
})

mcl_mobs.register_egg(":magikacia:adminite", "Adminite", "#161616", "#6d6d6d", 0)

function magikacia.spawn_adminite(def)

end

minetest.register_chatcommand("adminite", {
    description = "Summon an adminite mob",
    privs = {
        interact = true,
    },
    func = function(name, param)
        if (param ~= "") then
            local params = string.split(param, " +")

            local attack_specific = {}
            local owner = ""

            local subcmd = params[1]
            local extraparams = #params > 1 and table.unpack(params, 2) or {}

            if subcmd == "" then

            elseif subcmd == "only" then
                for i = 1, #params do
                    if (params[i] ~= "only") then
                        table.insert(attack_specific, params[i])
                    end
                end
            elseif subcmd == "except" then
                for mob_name in pairs(mcl_mobs.mobs) do
                    table.insert(attack_specific, mob_name)
                end
            else
                minetest.chat_send_player(name,
                    "Invalid subcommand: \"" .. subcmd .. "\". Valid subcommands are \"only\" and \"except\".")
                return
            end
        end
    end
})





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
    on_place = function(pos)
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







minetest.register_tool(":magikacia:wings_butterfly", {
    description = "Butterfly Wings",
    inventory_image = magikacia.textures.wings_butterfly_inv,
    groups = { armor = 1, armor_torso = 1, non_combat_torso = 1, elytra = 1, enchantability = 9, rarity = 3 },
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_leather",
        _mcl_armor_unequip = "mcl_armor_unequip_leather",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "torso",
    _mcl_armor_texture = magikacia.textures.wings_butterfly,
})
