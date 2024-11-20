local n_skins = 22 local texture_list_default = {}
local texture_list_slim = {
    ["kinda_christmas_4"] = "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",
    ["happy_new_year_2021"] = "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",
    ["n_murder_drones"] = "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",
    ["kujou_alisa_alya_mikhailovna_28t235251_702_17574218"] = "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",
    ["v_muder_drones_raines"] = "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",
    ["christmas_aesthetic_girl"] = "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",
    ["christmas_snow_girl"] = "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",
    ["christmas_valkyra_f"] = "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",
    ["mother_nature_tinypaykitten"] = "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",
    ["holly_jolly_christmas_d"] = "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",
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
