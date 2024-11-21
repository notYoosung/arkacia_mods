local n_skins = 32 local texture_list_default = {}
local texture_list_slim = {
    ["christmas_snow_girl"] = "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",
    ["christmas_valkyra_f"] = "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",
    ["christmas_aesthetic_girl"] = "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",
}
local function is_base64(str)
    return str:find("/") ~= nil and true or false
end
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
        index = n_skins,
		texture = "blank.png^[png:" .. v,
	})
    n_skins = n_skins + 1
end
for i, v in pairs(texture_list_slim) do
    mcl_skins.register_simple_skin({
        index = n_skins,
        texture = "blank.png^[png:" .. v,
        slim_arms = true
    })
    n_skins = n_skins + 1
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
