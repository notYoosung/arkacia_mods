local blank = "blank.png^[png:"
local textures = {
    kife = "iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAuxJREFUWAnFlk9LckEUxi8t+gYtxFWLAjcWkZkFLaKEojKQPkEWucjoE0SItGpVS3fV1qBtgbtc2aJALdD+UBopYtBblOTzcg7vuRzrXem9NSBnZpx7fs88M3PvGMbvFfwe2jAILr8f1SFQiT8GF+DXaLuAiLIa6XRaC7AdrmHIZDJNbTvpTaBGo4FisYhsNqv7beFrAKS8v7+jUCg0/WcHvQkgcIqVSgWXl5f6f0v5OrHmcv3z8xN3d3d6jGVwnfQbWDpeX19xf3+vx1oiQCcU1rf48fGBx8dHPbZtuE7GdaL29vZ+g5P1tPb6HdAu/WuyprYWQceuVqvh4eFBj2mXb344zKRdXV04ODhAR0cH94mIl5cXS+F/tI3kNdnr9/sxPz+PsbExDA8Po7Ozk0X09PTwut/e3ppC25m6CadZStne3sbS0hI3Y7EYAoEAixIRpVLJWvjT0xN8Ph+en58ZGolEsLa2hsPDQ3bg7e0NW1tb6O7u1mCpt2SAOXMinpycYGBgAEdHR1hfX8fZ2Rn6+vowNDQEsprK4uIinE6nQCW2BKeHOEG9XkcqlWJAKBSC2+3G7u4ut/f399Hf34/Z2VkEg0FMTk4KVMeWBHACoiSTSSwsLDAwGo2CRNDMd3Z2uI++cNRPomiZRPi/2DqcEuhC9obDYe6S5VhZWeE2nYhqtWoJXBRrNq8/rfPo6CimpqZ4I0p7ZmYG5XIZ19fXlgngl4pW4PV6uUk7fW5uDtSmiwWB4/E4b0IrrDdn73K5TLuJTDudbKZCcXV1lU/E8fHx/+DkRMuFbby4uOAzL3aPj4+Ddvzp6Skfv1wuh729PeTzeW17rWWqepAT0sWRLJ6enubZT0xMwOPxsPWDg4MYGRnB+fm55XDRwcmvrq5wc3OD5eVlPvubm5u80WjzfblcWDJzgVPkmRGcLCYgvffphbOxscE3WxljGIblcBHCIvQ9LpFIwOFw2Ga7gHXUMF3XY36kLnBbYX8BUSVJqUY9bkcAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg==",
}
for k, i in pairs(textures) do
    textures[k] = blank .. i
end

mcl_tools.commondefs = mcl_tools.commondefs or {
    ["axe"] = {
        longdesc = S("An axe is your tool of choice to cut down trees, wood-based blocks and other blocks. Axes deal a lot of damage as well, but they are rather slow. Axes can be used to strip bark and hyphae from trunks. They can also be used to scrape blocks made of copper, reducing their oxidation stage or removing wax from waxed variants."),
        usagehelp = S("To strip bark from trunks and hyphae, use the ax by right-clicking on them. To reduce an oxidation stage from a block made of copper or remove wax from waxed variants, right-click on them. Doors and trapdoors also require you to hold down the sneak key while using the axe."),
        groups = { axe = 1, tool = 1 },
        diggroups = { axey = {} },
        craft_shapes = {
            {
                { "material",       "material" },
                { "mcl_core:stick", "material" },
                { "mcl_core:stick", "" }
            },
            {
                { "material", "material" },
                { "material", "mcl_core:stick" },
                { "",         "mcl_core:stick" }
            }
        }
    },
    ["hoe"] = {
        longdesc = S("Hoes are essential tools for growing crops. They are used to create farmland in order to plant seeds on it. Hoes can also be used as very weak weapons in a pinch."),
        usagehelp = S("Use the hoe on a cultivatable block (by rightclicking it) to turn it into farmland. Dirt, grass blocks and grass paths are cultivatable blocks. Using a hoe on coarse dirt turns it into dirt."),
        groups = { hoe = 1, tool = 1 },
        diggroups = { hoey = {} },
        craft_shapes = {
            {
                { "material",       "material" },
                { "mcl_core:stick", "" },
                { "mcl_core:stick", "" }
            },
            {
                { "material", "material" },
                { "",         "mcl_core:stick" },
                { "",         "mcl_core:stick" }
            }
        }
    },
    ["pick"] = {
        longdesc = S("Pickaxes are mining tools to mine hard blocks, such as stone. A pickaxe can also be used as weapon, but it is rather inefficient."),
        groups = { pickaxe = 1, tool = 1 },
        diggroups = { pickaxey = {} },
        craft_shapes = {
            {
                { "material", "material",       "material" },
                { "",         "mcl_core:stick", "" },
                { "",         "mcl_core:stick", "" }
            }
        }
    },
    ["shovel"] = {
        longdesc = S("Shovels are tools for digging coarse blocks, such as dirt, sand and gravel. They can also be used to turn grass blocks to grass paths. Shovels can be used as weapons, but they are very weak."),
        usagehelp = S("To turn a grass block into a grass path, hold the shovel in your hand, then use (rightclick) the top or side of a grass block. This only works when there's air above the grass block."),
        groups = { shovel = 1, tool = 1 },
        diggroups = { shovely = {} },
        craft_shapes = {
            {
                { "material" },
                { "mcl_core:stick" },
                { "mcl_core:stick" }
            }
        }
    },
    ["sword"] = {
        longdesc = S("Swords are great in melee combat, as they are fast, deal high damage and can endure countless battles. Swords can also be used to cut down a few particular blocks, such as cobwebs."),
        groups = { sword = 1, weapon = 1 },
        diggroups = { swordy = {}, swordy_cobweb = {} },
        craft_shapes = {
            {
                { "material" },
                { "material" },
                { "mcl_core:stick" }
            }
        }
    }
}

local wield_scale = mcl_vars.tool_wield_scale

local function get_tool_diggroups(materialdefs, toolname)
	local diggroups = mcl_tools.commondefs[toolname].diggroups

	for _, diggroup in pairs(diggroups) do
		diggroup.speed = materialdefs.speed
		diggroup.level = materialdefs.level
		diggroup.uses = materialdefs.uses
	end

	return diggroups
end

local function replace_material_tag(shape, material)
	local recipe = table.copy(shape)

	for _, line in ipairs(recipe) do
		for count, tag in ipairs(line) do
			if tag == "material" then
				line[count] = material
			end
		end
	end

	return recipe
end

local function get_punch_uses(toolname, materialdefs)
	if toolname == "sword" then return materialdefs.uses end
	return materialdefs.uses / 2
end

local function register_tool(setname, materialdefs, toolname, tooldefs, overrides)
	local mod = "arkacia"
	local itemstring = ":" .. mod..":"..toolname.."_"..setname
	local commondefs = mcl_tools.commondefs[toolname]
	local tcs = table.copy(tooldefs.tool_capabilities or {})
	tooldefs.tool_capabilities = nil
	local tooldefs = table.merge({
		_doc_items_longdesc = commondefs.longdesc,
		_doc_items_usagehelp = commondefs.usagehelp,
		_mcl_diggroups = get_tool_diggroups(materialdefs, toolname),
		_mcl_toollike_wield = true,
		_repair_material = materialdefs.material,
		groups = table.merge(commondefs.groups, materialdefs.groups, { offhand_item = 1 }),
		tool_capabilities = table.merge(tcs, {
			max_drop_level = materialdefs.max_drop_level,
			punch_attack_uses = get_punch_uses(toolname, materialdefs)
		}),
		on_place = mcl_tools.tool_place_funcs[toolname],
		sound = { breaks = "default_tool_breaks" },
		wield_scale = wield_scale
	}, tooldefs, overrides or {})

	minetest.register_tool(itemstring, tooldefs)

	if materialdefs.craftable then
		for _, shapes in ipairs(mcl_tools.commondefs[toolname].craft_shapes) do
			local recipe = replace_material_tag(shapes, materialdefs.material)

			minetest.register_craft({
				output = itemstring,
				recipe = recipe
			})
		end
	end
end

register_tool("kife", {
    craftable = true,
    material = "group:wood",
    uses = 60,
    level = 1,
    speed = 2,
    max_drop_level = 1,
    groups = { dig_class_speed = 2, enchantability = 15 }
}, "sword", {
    description = "Kife",
    inventory_image = textures.kife,
    tool_capabilities = {
        full_punch_interval = 0.625,
        damage_groups = { fleshy = 4 }
    }
}, { _doc_items_hidden = false, _mcl_burntime = 10 })


