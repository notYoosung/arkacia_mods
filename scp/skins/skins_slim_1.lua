local n_skins = 2 local texture_list_default = {}
local texture_list_slim = {
    [""] = "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",
    ["christmas_valkyra_f"] = "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",
    ["holly_jolly_christmas_d"] = "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",
    ["kinda_christmas_4"] = "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",
    ["happy_new_year_2021"] = "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",
    ["mother_nature_tinypaykitten"] = "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",
    ["nature_girl_exoticblue"] = "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",
    ["poinsettia_skinmas"] = "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",
    ["basically_me_abandoned23232"] = "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",
    ["pink_uniform_3ce30faa1ac401b2"] = "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",
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
