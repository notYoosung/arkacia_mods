local n_skins = 32 local texture_list_default = {}
local texture_list_slim = {
    ["uzi_murder_drones_3def1f9e02aa86cb"] = "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",
    ["v_muder_drones_raines"] = "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",
    ["wedding_dress"] = "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",
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
    _mcl_diggroups = {
        handy = { speed = 1, level = 1, uses = 0 },
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
