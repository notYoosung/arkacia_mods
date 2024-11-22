
assert(minetest.get_modpath("mcl_autogroup"), "This mod requires the mod mcl_autogroup to function")

local groups_mtg2mcl = {
    ["choppy"] = { group = "axey", hardness = 2 },
    ["oddly_breakable_by_hand"] = { group = "handy", hardness = 0 },
    ["cracky"] = { group = "pickaxey", hardness = 1.5 },
    ["crumbly"] = { group = "shovely", hardness = 0.5 },
    ["snappy"] = { group = "swordy", hardness = 0.2 },
}

 
local function convert_mtg_groups(nname)
    local groups = table.copy(minetest.registered_nodes[nname].groups)
    local hardness = minetest.registered_nodes[nname]._mcl_hardness

    if not hardness then  
        for mtg, mcl in pairs(groups_mtg2mcl) do
            local g_mtg = minetest.get_item_group(nname, mtg)
            local g_mcl = minetest.get_item_group(nname, mcl.group)
            if g_mtg > 0 and g_mcl == 0 then
                groups[mcl.group] = g_mtg
                groups[mtg] = nil

                hardness = math.max(hardness or 0, g_mtg * mcl.hardness)
            end
        end
    end
    return groups, hardness
end

for nname, _ in pairs(minetest.registered_nodes) do
    local newgroups, newhardness = convert_mtg_groups(nname)

    minetest.override_item(nname, {
        groups = newgroups,
        _mcl_hardness = newhardness,
    })
end

 
 
local function get_hardness_values_for_groups()
    local maps = {}
    local values = {}
    for g, _ in pairs(mcl_autogroup.registered_diggroups) do
        maps[g] = {}
        values[g] = {}
    end

    for _, ndef in pairs(minetest.registered_nodes) do
        for g, _ in pairs(mcl_autogroup.registered_diggroups) do
            if ndef.groups[g] then
                maps[g][ndef._mcl_hardness or 0] = true
            end
        end
    end

    for g, map in pairs(maps) do
        for k, _ in pairs(map) do
            table.insert(values[g], k)
        end
    end

    for g, _ in pairs(mcl_autogroup.registered_diggroups) do
        table.sort(values[g])
    end
    return values
end

 
 
local function get_hardness_lookup_for_groups(hardness_values)
    local map = {}
    for g, values in pairs(hardness_values) do
        map[g] = {}
        for k, v in pairs(values) do
            map[g][v] = k
        end
    end
    return map
end

 
local hardness_values = get_hardness_values_for_groups()


 
 
 
 
 
 
 
 
local function get_digtimes(group, can_harvest, speed, efficiency)
    local speed = speed or 1
    if efficiency then
        speed = speed + efficiency * efficiency + 1
    end

    local digtimes = {}

    for _, hardness in pairs(hardness_values[group]) do
        local digtime = (hardness or 0) / speed
        if can_harvest then
            digtime = digtime * 1.5
        else
            digtime = digtime * 5
        end

        if digtime <= 0.05 then
            digtime = 0
        else
            digtime = math.ceil(digtime * 20) / 20
        end
        table.insert(digtimes, digtime)
    end

    return digtimes
end

 
local function get_groupcap(group, can_harvest, multiplier, efficiency, uses)
    return {
        times = get_digtimes(group, can_harvest, multiplier, efficiency),
        uses = uses,
        maxlevel = 0,
    }
end

 
 
local function add_groupcaps(toolname, groupcaps, groupcaps_def, efficiency)
    if not groupcaps_def then
        return
    end

    for g, capsdef in pairs(groupcaps_def) do
        local mult = capsdef.speed or 1
        local uses = capsdef.uses
        local def = mcl_autogroup.registered_diggroups[g]
        assert(def, toolname .. " has unknown diggroup '" .. dump(g) .. "'")
        local max_level = def.levels and #def.levels or 1

        assert(capsdef.level, toolname .. ' is missing level for ' .. g)
        local level = math.min(capsdef.level, max_level)

        if def.levels then
            groupcaps[g .. "_dig_default"] = get_groupcap(g, false, mult, efficiency, uses)
            if level > 0 then
                groupcaps[g .. "_dig_" .. def.levels[level]] = get_groupcap(g, true, mult, efficiency, uses)
            end
        else
            groupcaps[g .. "_dig"] = get_groupcap(g, level > 0, mult, efficiency, uses)
        end
    end
end

 
 
function mcl_autogroup.can_harvest(nodename, toolname, player)
    local ndef = minetest.registered_nodes[nodename]

    if not ndef then
        return false
    end

    if minetest.get_item_group(nodename, "dig_immediate") >= 2 then
        return true
    end

     
    local tdef = minetest.registered_tools[toolname]
    if tdef and tdef._mcl_diggroups then
        for g, gdef in pairs(tdef._mcl_diggroups) do
            if ndef.groups[g] then
                if ndef.groups[g] <= gdef.level then
                    return true
                end
            end
        end
    end

     
    if player and player:is_player() then
        local name = player:get_inventory():get_stack("hand", 1):get_name()
        tdef = minetest.registered_items[name]
    end
    if tdef and tdef._mcl_diggroups then
        for g, gdef in pairs(tdef._mcl_diggroups) do
            if ndef.groups[g] then
                if ndef.groups[g] <= gdef.level then
                    return true
                end
            end
        end
    end

    return false
end

 

 
 
local function get_tool_capabilities(tdef)
    if tdef.tool_capabilities then
        return tdef.tool_capabilities
    end

     
     
    local hand_toolcaps = mcl_meshhand.survival_hand_tool_caps
    return {
        full_punch_interval = hand_toolcaps.full_punch_interval,
        damage_groups = hand_toolcaps.damage_groups
    }
end

 
 
 
 
 
 
 
 
 
 
 
 
function mcl_autogroup.get_groupcaps(toolname, efficiency)
    local tdef = minetest.registered_items[toolname]
    local groupcaps = table.copy(get_tool_capabilities(tdef).groupcaps or {})
    add_groupcaps(toolname, groupcaps, tdef._mcl_diggroups, efficiency)
    return groupcaps
end

 
 
 
 
 
 
 
 
 
 
function mcl_autogroup.get_wear(toolname, diggroup)
    local tdef = minetest.registered_tools[toolname]
    local uses = tdef._mcl_diggroups[diggroup].uses
    return math.ceil(65535 / uses)
end

local function overwrite()
     
    hardness_values = get_hardness_values_for_groups()

     
     
    local hardness_lookup = get_hardness_lookup_for_groups(hardness_values)

    for nname, ndef in pairs(minetest.registered_nodes) do
        local newgroups = table.copy(ndef.groups)

        if (nname ~= "ignore" and ndef.diggable) then
             
            if (ndef.walkable == nil or ndef.walkable == true)
                and (ndef.collision_box == nil or ndef.collision_box.type == "regular")
                and (ndef.node_box == nil or ndef.node_box.type == "regular")
                and (ndef.groups.not_solid == 0 or ndef.groups.not_solid == nil) then
                newgroups.solid = 1
            end
             
            if (not (ndef.paramtype == "light" or ndef.sunlight_propagates)) and
                (ndef.groups.not_opaque == 0 or ndef.groups.not_opaque == nil) then
                newgroups.opaque = 1
            end

             
             
            for g, gdef in pairs(mcl_autogroup.registered_diggroups) do
                local index = hardness_lookup[g][ndef._mcl_hardness] or newgroups[g] or hardness_lookup[g][0]
                if newgroups[g] then
                    if gdef.levels then
                        newgroups[g .. "_dig_default"] = index

                        for i = newgroups[g], #gdef.levels do
                            newgroups[g .. "_dig_" .. gdef.levels[i]] = index
                        end
                    else
                        newgroups[g .. "_dig"] = index
                    end
                end
            end

             
             
             
            newgroups["creative_breakable"] = 1

            minetest.override_item(nname, {
                groups = newgroups,
            })
        end
    end

    for tname, tdef in pairs(minetest.registered_items) do
         
         
        if tdef._mcl_diggroups then
            local toolcaps = table.copy(get_tool_capabilities(tdef))
            toolcaps.groupcaps = mcl_autogroup.get_groupcaps(tname)

            minetest.override_item(tname, {
                tool_capabilities = toolcaps
            })
        end

        if tdef._mcl_burntime and tdef._mcl_burntime > 0 then
            minetest.register_craft({
                type = "fuel",
                recipe = tname,
                burntime = tdef._mcl_burntime,
                replacements = tdef._mcl_fuel_replacements
            })
        end

        if tdef._mcl_cooking_output and type(tdef._mcl_cooking_output) == "string" and tdef._mcl_cooking_output ~= "" then
            minetest.register_craft({
                type = "cooking",
                recipe = tname,
                output = tdef._mcl_cooking_output,
                cooktime = tdef._mcl_cooktime or 10,
                replacements = tdef._mcl_cooking_replacements
            })
        end
    end
end

overwrite()
