local texture_list_default = {}
local texture_list_slim = {
    ["kinda_christmas_4"] = "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",
    ["happy_new_year_2021"] = "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",
    ["holly_jolly_christmas_d"] = "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",
}
function mcl_meshhand.update_player(player)
	local hand
	if mcl_skins_enabled then
		local node_id = mcl_skins.get_node_id_by_player(player)
		hand = ItemStack("mcl_meshhand:" .. minetest.registered_nodes[node_id].texture[0])
	else
		local creative = minetest.is_creative_enabled(player:get_player_name())
		hand = ItemStack("mcl_meshhand:hand" .. (creative and "_crea" or "_surv"))
	end
	player:get_inventory():set_stack("hand", 1, mcl_potions.hf_update_internal(hand, player))
end
function mcl_skins.get_node_id_by_player(player)
	local skin = mcl_skins.player_skins[player]
	local simple_skin = skin.simple_skins_id
	if simple_skin then skin = mcl_skins.texture_to_simple_skin[skin.simple_skins_id] end
	local creative = minetest.is_creative_enabled(player:get_player_name())
	local append = (skin.slim_arms and "_female" or "_male") .. (creative and "_crea" or "_surv")
	if simple_skin then
		return skin.texture:gsub(".png$", ""):gsub("[^a-zA-z0-9_]", "") .. append
	else
		return skin.base:gsub(".png$", "") .. minetest.colorspec_to_colorstring(skin.base_color):gsub("#", "") .. append
	end
end


for i, v in pairs(texture_list_default) do
	mcl_skins.register_simple_skin({
		texture = "blank.png^[png:" .. v,
	})
end
for i, v in pairs(texture_list_slim) do
    mcl_skins.register_simple_skin({
        texture = "blank.png^[png:" .. v,
        slim_arms = true
    })
end

local function make_texture(base, colorspec)
    local output = ""
    if mcl_skins.masks[base] then
        output = mcl_skins.masks[base] ..
            "^[colorize:" .. minetest.colorspec_to_colorstring(colorspec) .. ":alpha"
    end
    if #output > 0 then output = output .. "^" end
    output = output .. base
    return output
end
function mcl_skins.get_skin_list()
    local list = {}
    for _, game_mode in pairs({ "_crea", "_surv" }) do
        for _, base in pairs(mcl_skins.base) do
            for _, base_color in pairs(mcl_skins.base_color) do
                local id = base:gsub(".png$", "") .. minetest.colorspec_to_colorstring(base_color):gsub("#", "")
                local female = {
                    texture = make_texture(base, base_color),
                    slim_arms = true,
                    id = id .. "_female" .. game_mode,
                    creative = game_mode == "_crea"
                }
                table.insert(list, female)

                local male = {
                    texture = make_texture(base, base_color),
                    slim_arms = false,
                    id = id .. "_male" .. game_mode,
                    creative = game_mode == "_crea"
                }
                table.insert(list, male)
            end
        end
        for _, skin in pairs(mcl_skins.simple_skins) do
            table.insert(list, {
                texture = skin.texture,
                slim_arms = skin.slim_arms,
                id = skin.texture:gsub("%.png", ""):gsub("[^a-zA-Z0-9_]", "") .. (skin.slim_arms and "_female" or "_male") .. game_mode,
                creative = game_mode == "_crea"
            })
        end
    end
    return list
end


local node_def = {
    description = "",
    use_texture_alpha = minetest.features.use_texture_alpha_string_modes and "clip" or false,
    visual_scale = 1,
    wield_scale = { x = 1, y = 1, z = 1 },
    paramtype = "light",
    drawtype = "mesh",
    node_placement_prediction = "",
    drop = "",
    on_drop = function(_, _, _) return ItemStack() end,
    groups = {
        dig_immediate = 3,
        not_in_creative_inventory = 1,
        dig_speed_class = 1,
    },
    tool_capabilities = {
        full_punch_interval = 0.25,
        max_drop_level = 0,
        groupcaps = {},
        damage_groups = { fleshy = 1 },
    },
    _mcl_diggroups = {
        handy = { speed = 1, level = 1, uses = 0 },
        axey = { speed = 1, level = 1, uses = 0 },
        shovely = { speed = 1, level = 1, uses = 0 },
        hoey = { speed = 1, level = 1, uses = 0 },
        pickaxey = { speed = 1, level = 0, uses = 0 },
        swordy = { speed = 1, level = 0, uses = 0 },
        swordy_cobweb = { speed = 1, level = 0, uses = 0 },
        shearsy = { speed = 1, level = 0, uses = 0 },
        shearsy_wool = { speed = 1, level = 0, uses = 0 },
        shearsy_cobweb = { speed = 1, level = 0, uses = 0 },
    },
    range = tonumber(minetest.settings:get("mcl_hand_range")) or 4.5
}
local creative_hand_range = tonumber(minetest.settings:get("mcl_hand_range_creative")) or 10
local list = mcl_skins.get_skin_list()
for _, skin in pairs(list) do
    if skin.slim_arms then
        local female = table.copy(node_def)
        female._mcl_hand_id = skin.id
        female.mesh = "mcl_meshhand_female.b3d"
        female.tiles = { skin.texture }
        minetest.register_node(":mcl_meshhand:" .. skin.id, female)
    else
        local male = table.copy(node_def)
        male._mcl_hand_id = skin.id
        male.mesh = "mcl_meshhand.b3d"
        male.tiles = { skin.texture }
        minetest.register_node(":mcl_meshhand:" .. skin.id, male)
    end

    local node_def = table.copy(node_def)
    node_def._mcl_hand_id = skin.id
    node_def.tiles = { skin.texture }
    node_def.mesh = skin.slim_arms and "mcl_meshhand_female.b3d" or "mcl_meshhand.b3d"
    if skin.creative then
        node_def.range = creative_hand_range
        node_def.groups.dig_speed_class = 7
        node_def.tool_capabilities.groupcaps.creative_breakable = { times = { 0 }, uses = 0 }
    end
    minetest.register_node(":mcl_meshhand:" .. skin.id, node_def)
end
