local S = minetest.get_translator(minetest.get_current_modname())
local C = minetest.colorize
local F = minetest.formspec_escape

local dispenser_formspec = table.concat({
    "formspec_version[4]",
    "size[11.75,10.425]",

    "label[4.125,0.375;" .. F(C(mcl_formspec.label_color, S("Placer/Breaker"))) .. "]",

    mcl_formspec.get_itemslot_bg_v4(4.125, 0.75, 1, 1),
    "list[context;main;4.125,0.75;3,3;]",

    "label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",

    mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
    "list[current_player;main;0.375,5.1;9,3;9]",

    mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
    "list[current_player;main;0.375,9.05;9,1;]",

    "listring[context;main]",
    "listring[current_player;main]",
})

local function setup_dispenser(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("formspec", dispenser_formspec)
    local inv = meta:get_inventory()
    inv:set_size("main", 1)
end

local function orientate_dispenser(pos, placer)
    if not placer then return end

    local pitch = placer:get_look_vertical() * (180 / math.pi)

    local node = minetest.get_node(pos)
    if pitch > 55 then
        minetest.swap_node(pos, { name = "arkacia:placer_up", param2 = node.param2 })
    elseif pitch < -55 then
        minetest.swap_node(pos, { name = "arkacia:placer_down", param2 = node.param2 })
    end
end

local on_rotate
if minetest.get_modpath("screwdriver") then
    on_rotate = screwdriver.rotate_simple
end

local dispenserdef = {
    is_ground_content = false,
    sounds = mcl_sounds.node_sound_stone_defaults(),
    allow_metadata_inventory_move = function(pos, _, _, _, _, count, player)
        local name = player:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return 0
        else
            return count
        end
    end,
    allow_metadata_inventory_take = function(pos, _, _, stack, player)
        local name = player:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return 0
        else
            return stack:get_count()
        end
    end,
    allow_metadata_inventory_put = function(pos, _, _, stack, player)
        local name = player:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return 0
        else
            return stack:get_count()
        end
    end,
    after_dig_node = mcl_util.drop_items_from_meta_container({ "main" }),

    _mcl_blast_resistance = 3.5,
    _mcl_hardness = 3.5,
    mesecons = {
        effector = {
            action_on = function(pos, node)
                local meta = minetest.get_meta(pos)
                local inv = meta:get_inventory()
                local droppos, dropdir
                if node.name == "arkacia:placer" then
                    dropdir = vector.multiply(minetest.facedir_to_dir(node.param2), -1)
                    droppos = vector.add(pos, dropdir)
                elseif node.name == "arkacia:placer_up" then
                    dropdir = vector.new(0, 1, 0)
                    droppos = vector.offset(pos, 0, 1, 0)
                elseif node.name == "arkacia:placer_down" then
                    dropdir = vector.new(0, -1, 0)
                    droppos = vector.offset(pos, 0, -1, 0)
                end
                local dropnode = minetest.get_node(droppos)
                local dropnodedef = minetest.registered_nodes[dropnode.name]
                local stacks = {}
                for i = 1, inv:get_size("main") do
                    local stack = inv:get_stack("main", i)
                    if not stack:is_empty() then
                        table.insert(stacks, { stack = stack, stackpos = i })
                    end
                end
                if #stacks >= 1 then
                    local r = math.random(1, #stacks)
                    local stack = stacks[r].stack
                    local dropitem = ItemStack(stack)
                    dropitem:set_count(1)
                    local stack_id = stacks[r].stackpos
                    local stackdef = stack:get_definition()

                    if not stackdef then
                        return
                    end

                    local iname = stack:get_name()
                    local igroups = stackdef.groups

                    if dropnode then
                        if minetest.registered_nodes[iname] and dropnode.name == "air" then
                            minetest.set_node(droppos, {name = iname})
                            stack:take_item()
                            inv:set_stack("main", stack_id, stack)
                        else
                            if dropnode.name ~= "air" and dropnode.name == stack:get_name() then
                                minetest.dig_node(droppos)
                                stack:add_item(ItemStack(stack))
                            end
                        end
                    end
                end
            end,
            rules = mesecon.rules.alldirs,
        },
    },
    on_rotate = on_rotate,
}


local horizontal_def = table.copy(dispenserdef)
horizontal_def.description = S("Placer/Breaker")
horizontal_def._tt_help = S("9 inventory slots") .. "\n" .. S("Launches item when powered by redstone power")
horizontal_def._doc_items_longdesc = S(
"A dispenser is a block which acts as a redstone component which, when powered with redstone power, dispenses an item. It has a container with 9 inventory slots.")
horizontal_def._doc_items_usagehelp = S(
    "Place the dispenser in one of 6 possible directions. The “hole” is where items will fly out of the dispenser. Use the dispenser to access its inventory. Insert the items you wish to dispense. Supply the dispenser with redstone energy once to dispense a random item.")
    .. "\n\n" ..

    S("The dispenser will do different things, depending on the dispensed item:") .. "\n\n" ..
    S("• Arrows: Are launched") .. "\n" ..
    S("• Eggs and snowballs: Are thrown") .. "\n" ..
    S("• Fire charges: Are fired in a straight line") .. "\n" ..
    S("• Armor: Will be equipped to players and armor stands") .. "\n" ..
    S("• Boats: Are placed on water or are dropped") .. "\n" ..
    S("• Minecart: Are placed on rails or are dropped") .. "\n" ..
    S("• Bone meal: Is applied on the block it is facing") .. "\n" ..
    S("• Empty buckets: Are used to collect a liquid source") .. "\n" ..
    S("• Filled buckets: Are used to place a liquid source") .. "\n" ..
    S("• Heads, pumpkins: Equipped to players and armor stands, or placed as a block") .. "\n" ..
    S("• Shulker boxes: Are placed as a block") .. "\n" ..
    S("• TNT: Is placed and ignited") .. "\n" ..
    S("• Flint and steel: Is used to ignite a fire in air and to ignite TNT") .. "\n" ..
    S("• Spawn eggs: Will summon the mob they contain") .. "\n" ..
    S("• Other items: Are simply dropped")

function horizontal_def.after_place_node(pos, placer, _, _)
    setup_dispenser(pos)
    orientate_dispenser(pos, placer)
end

horizontal_def.tiles = {
    "default_furnace_top.png", "default_furnace_bottom.png",
    "default_furnace_side.png", "default_furnace_side.png",
    "default_furnace_side.png", "mcl_dispensers_dispenser_front_horizontal.png"
}
horizontal_def.paramtype2 = "facedir"
horizontal_def.groups = { pickaxey = 1, container = 2, material_stone = 1, dig_immediate = 3 }

minetest.register_node(":arkacia:placer", horizontal_def)

local down_def = table.copy(dispenserdef)
down_def.description = S("Downwards-Facing Placer/Breaker")
down_def.after_place_node = setup_dispenser
down_def.tiles = {
    "default_furnace_top.png", "mcl_dispensers_dispenser_front_vertical.png",
    "default_furnace_side.png", "default_furnace_side.png",
    "default_furnace_side.png", "default_furnace_side.png"
}
down_def.groups = { pickaxey = 1, container = 2, not_in_creative_inventory = 1, material_stone = 1, dig_immediate = 3 }
down_def._doc_items_create_entry = false
down_def.drop = "arkacia:placer"
minetest.register_node(":arkacia:placer_down", down_def)

local up_def = table.copy(down_def)
up_def.description = S("Upwards-Facing Placer/Breaker")
up_def.tiles = {
    "mcl_dispensers_dispenser_front_vertical.png", "default_furnace_bottom.png",
    "default_furnace_side.png", "default_furnace_side.png",
    "default_furnace_side.png", "default_furnace_side.png"
}
minetest.register_node(":arkacia:placer_up", up_def)


