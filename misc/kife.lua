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
    inventory_image = "default_tool_woodsword.png",
    tool_capabilities = {
        full_punch_interval = 0.625,
        damage_groups = { fleshy = 4 }
    }
}, { _doc_items_hidden = false, _mcl_burntime = 10 })


