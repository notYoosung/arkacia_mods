local n_skins = 32 local texture_list_default = {}
local texture_list_slim = {
    ["kujou_alisa_alya_mikhailovna_28t235251_702_17574218"] = "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",
    ["bunny_slippers"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAJhJREFUaEPtmDEOgCAMRcvAafUMDp5BT8uAwYSE4NA40v9cWFj6+n4Bk4l/Sbx+AwAGiBMgAuICMASJABEQJ0AExAXgFCACRMAhUEup45aUcyhr3GIAgAHiEYg+JN0ZAIDgBDAgeIPd8jDARRR8AwbMDW5X33bf72twAb7/A+QAzI+dvx1f/XX4qj4WfeybnddtffWArA7gATb3LiG1F6T3AAAAAElFTkSuQmCC",
    ["endergirl_06b1970b248d1e43"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEYElEQVRoBdVY3UtUQRSf1V1NUdwyi8BKKV/sJTGyqESSIDCJHrIHoUf7D/oj+hN8N6geIkzwxQifMpKC8CnDPgyq7WNlxU3Xj/zNeoa5c8/MvXe9N+zC3Zn5nXN+c87cM3Pu3ZQIuJoyx7YCVJzipdKnlFMhQEjzV1dnPJobGyXP2DYImj9tM9Tx2pp6faj6q2srqp9kB8GnjQXAfGEXweVblUu4F2S24LEgZlZU4u+eX4BKgopiE2oLhCHM51941LLZc55x0gNzr9PZETTvrjNgoLlTmMFjUmCQJX0hcDN4zGnDTX92vQAmYdxjHHTrzIkP7J8dgjjtuTvuYG18tAgImm49+O76bl+p5jCOPxV2r3DGcWLmia4HiHmSkstDMKjOD7ScYmOdyM1JPMg+SG4rdR+n3kj+D49nRNuNHtHaV/Zj8fmcIAwKx/tPO98TbPxYZJkBnINIeVvg0ivtBwth44AaJwOOOWzOQU5738wGyHBRVnAvSZCTvUvOlkE4dqu1SyyvroFHjL28J1vzZ/jsXQlB98Hia2ugpl2U8a8/71Mj7de3louroqGuVppSf3ThSerAvhO+/R+F31oFEHxhrXx3tZ8XuOmiMclpoUgeR4und6GhTQwe7JfB3/86qb4p0MciQAYdetKVzMtmAIgQ3OelGck5NvpQTD96qvjvXLktem9eE8MjQxI72tSjZHF0EBCefKH2iHy64z+mZPB44sSPRehruijl0EUm2FKdbLjWtwBI/5OZFlEorSr9zqH+cn9/s2wRvMRGyjB0YTO/lou8DWh/k/MInrBCqah84Dq6nGw4HtgSTjw0D1sGEYx+vcqN60PVP9MyqProzJdynnGUAR1oCMR8s0NNn12ZVU8fvByGkq7z6PMTThgtmIcUwq3Ft1vZ9gHS87SlzaJY2cj5bHSlMO8VcMb2RMzgdW706dBDAFRdkLVBdiYPjX1bgASVtmb2mDy7yRKTC+Nv35+J3Xx4WasAN1lUDFvHtn2iciWln+gC2Jy+mu3wiTjMp8QAhw9dZtDwUIr2fH5hQlnZzgClsNOBDXRtaU9P3zwsiSfMdjAPL7KlQ4zG1JI+SiNhrjYtdkqbare11ff975+8LdnsSCkQWojGTN12GS2K5uZLUqO9KisIA0D6O+a+V1p6sUGQ5mEJG5KTvdlyNqYOjRPZAo2ZWrGwmZfOwxn0gbku3Wm9z9m45C4Zy0UnKLW6Esoed2Wq6jhYYY1pb5mDU8BsF+c0MFua23gqwdO2IEG2sVn+GHIR64uBNHddSh7uL30XVWyytB6AyWpbAJsNpbn8ait42YA1rvsjp0PLq10euWScfiWY80WouqqmEs7/ysa5AFEjce1zcAXJo84Xh34iVSAOx1wcrjLoknGcsWZAgfY4UzzwB4aSc55EwFwVgqsoLupEMmAy/843J4dByVXqXDLfBBUCsWbA9FI58N6mDjFT/OJxCX9dkdwj2B4gbc0nFzWVTc6w478s2+6BLq4SbgAAAABJRU5ErkJggg==",
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
