local n_skins = 32 local texture_list_default = {}
local texture_list_slim = {
    ["christmas_aesthetic_girl"] = "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",
    ["christmas_snow_girl"] = "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",
    ["v_muder_drones_raines"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAHQklEQVRoBc1ZaWxUVRQ+b5zSduhMgbIVW6BaqEBijEESTAgW/hAhxGgIEAIoS0SNAmlFUaBhUQRpAAm4FVIXJGDCD4zGxCAaEk2QEDRhqaCFtrYSWTule/u8331zHve9d+fNlKHGk3TOuWe795y7nftqUALY9O77pp/KtX+uSnFj402HWiTST7a3b11rOAS91Fi8rMQxzr0flCfVb7An4+FgcwYN9JhxwB7Bf8RINmD3cAJuhl+7b1YW4a+1pdVW45lnGWMosMxWTpFYuWqjY5bhzj3zahd+MtZLuAL2V+yl5uYo6ztwKBSmx4snO3i90RiRXyQDP3zgc2Ia/VyurUpqmfuNKWECYIxAE0HpkhUOlfU7Njnad9sYUzTePPt1AY2dXk3AAKbHTg97VkRP+0mYgHC4f0KfZSvWUGa2Uw28kg2lTuZdtM5VnTSMwpOWZf9SGfC5qjk2T6zAlJKQMAEzZz9tDxt7/3ZTk2zzQcgHo62kEPf6YDRy5niWvN/h5yfjYfboEMzIzCAEzsHDiXrQ9QkR4Y9BlTGvN7DucNTxdH0b6j2PAw+AZa/OvM7QzTty8DBFozcke96SxW5x3PaaV19wzCr2PJZ9XAMfwd3YyhUQjkSkW/W0Zx4EuNqG5d3v+AOPQdVlHypPpXU2zMMJzwcd83qCYaveEsnYyjMg2tho6yIAzCB4fN8jeDcEAgFbDhlWzMfv7bDVVJ9McyLQZh4b7Pxwv7n8+XnicKtilo0hC0esmyjaGCXQi+bO9KwSo/BLyWNftgNB7DtwxIQt+lD5QQSJvQ08f+kySbMCH3ho19f9RZvLXpai1et3iUFE7AMR9oClr6yQflSf4LPcHTQnGDoAnj3d/Y7+OYGgdUGyveXN+YvgdWCs2bDdxAB59jgI8Kr/uChtjhza7bFtbu2kOQuWS37Bg4UycJ0fKIDPSUGbaeBN61Y6ZgRyBhxkfdLT5YzzWcFnFgfU3tZGqbw3ZALQIWab9zXTDfV1ciwVpTUSFzzxjcTVPzwp8ZJtwyXOHZantZfC2A/7RFOlWQeJwGSgzTT0kIAtG1eB7U6U+drarYQEYNxso9qDZognD6ATgHplqTRkgyd8RdT/GRo6KEP+gZY8CGOg2jAN337+WcaYfQEzDwEKcAcveTGZrQsmA9ujrdJuucH3JQ+aFVDEMK983TZZ6fEd395M1HKL7EpP1VXtmQZmX8zjIomXr/vhohYxGCPrsb2b52cPm3hyT2ZNATC41WAFOWnaFDRtuHj5mMfGFgoiL3e0+fqLT1FW/miiQBpRdwcZ3W0UrW+gd3Yfol++r5LJRAJVQCkNXu4Yw9f/2KKJZkdHG7W0NFFtvXVj/H0+sZ3al0onLIVV5WTp+9KtcnDh/AXSBCumsqI8WXNfvaxwFjWJAx0JoOsHiQbM9tVPJOxRKZzIGcsDGdk0d5azGjTSMln8v8K9kgBdhN1d3Tp2j3lN0SbCFpCQ4uzDR7BwRLF54ehAGjX1Kkk8corEM+YH6GiJVTycKc+kcSUtZOFiE3hqeZiOf9ZN+ZN+tQaj/HZ1diktJ/nYlCInQ7SCwTRaXfocpWf3o8rKCrO9uY3e3ryHOjs7KBLJISx7AIJXIX/YHV84eyDLzMyitLR0Olv1s+cs+WTfbnPhopccfMOvelI7i0d3dXqf42+ULqZQTo5jG3y0cz1t2fWF1g0SgEFf+PMUjXrgUamDWY6XAD4Edc78EiD0ebB2EoK6rz38oNF1oPJg6y5vId+641OphtO/rGyPpJc/O0Ni3U/16bUk3vp28JwIJOBegXlxlslvBeETiZBJMPCE9OtElww1aboEYEYBCIBpbkuB66f21FJRrZygcdOtyhNisYRxpcot4FIX3ygbpW83H230FwpFHFvArHtTxmjkvWXPPNsG433y4rc9K7ox2+kSAF0saSQAGGAfXLKl+RkkkkBlGkHqLF3g7FXWAfzcxStLBd3sq3I/GoHjrk4mAQUTKulS7RkSRY50qSbrzPmfPN2g8PGDoQ+J9e1fT9nmKRdCdQ2/286YwOpoabdukGs3raQimfFWFfSHDBlOqi586XyDz1UjaDe4P86yXPh3bPUrV2rkdkg5AUMG53MfNs4QlSDOCXubiE9lGX0yKSSuKB249U+c/A7fBqi1TZSQ9wg44Jg7OxkpJ+D0jzWeIT4yebjnfwkIRqcLY7e+OJjp+o0rcfU9HabAkAlw730sVb/9zzLMsG7J1VTXOL4OY3z8gtSN1U9/VKwwswu1WME2flqscOMCjvFEi6/rJ8bD7Nu3geGpBGOORhb/RpeOPXynQuQOBO7orpe+IL8VOqTtC4lxP59ZMTvXovDiZIB+el9rXG23TfkyhIx1WQ8YybzuXXhSZYD4RoN+xSFoB6nauumgowxWgowXvKVPVtks9I9/63ZpHVLuASJAfgIzZkvIoN9wztqaoFlfJgCvPkCs9ufEWkznr5/MqWm1/gXj+HOqLy5baQAAAABJRU5ErkJggg==",
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
