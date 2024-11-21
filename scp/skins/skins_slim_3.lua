local n_skins = 22 local texture_list_default = {}
local texture_list_slim = {
    ["wedding_dress"] = "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",
    ["hu_tao_wqtermelcn_4febbfc99fc9fdf4"] = "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",
    ["strawberry_kitty_13486c32a706077"] = "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",
    ["polar_bear_5b235a5bf9a07429"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEi0lEQVRoBdVYW0tUURTeIzONV6aE0gfJghCKLkR3hG5EUYEE9tov6LV/1EsPPYSQUURpIKURUUaBRBRINSWKiJdJaTrf1m9cZ3n22WdmNMcDx3X/9l7r7L32HlPG80xOThbn5uZMLpcLeU5PT5vGxkYjbdBJP8gdHR2pUGCNCXW++cgEpS8S1TaZPHy1LOOT8mNjY0WXb5zNFaP13gLEJRFn0wPVquxdnjMzM84vkCSplpYW7xhJcDbKJ10t8JvHDyzEue7uENTg0FBIrlXBuwWSTFwnj5goXRKs/+3jLQA6uX6oI9X2rSR7twCOOp0odaBb/Un5zvkkCerjEDEoGgsUZ29tbU3xOOvq6opsmOPj45GN2HXH8OHJnFIAz77sN9samkzduR5pM4uLi1YOJmkWFhZMfX29lckHxbNyJpMJxf0d7DN/5mdN4cw1q3cdlygSirPj3YAdP991wsgiyESCMYvB+LZA5KWdE4Cufey1KQTjTx05b9USk36g8K3D5LJB8tnde62tubm55MPEmCgSx4uHOvpAx1hgARPYruThDxtWCYqPGNdEf4/02xWAxPEiljrw8gHGtpXxgc1VKH3Iw5bynfNYBe+fPWRMiB6+eN3IAoSMCQXcE7jE9ZLmF579+dVM/8qb3K42Mzc7YxZng6t5wDe177Gj6MK58KKmFNsEXWc8gQZXCnPsyg2qKqI6cYJ8fz9sWSR7/uat1NsXT+zXJ087/UldeLRL6j0GpfN68PpESYJ59Oxlu/dBu6/2lvgksT6fOjkhyfPrA6D39h37EkzL0ldigJcy40njbPQBLd67Wyz++BJ+A530qZQvHYMAQFNAV8bz+dVzS/HHdauT1919py9Yf4nBBkRMOGg7jkEbGPNn4P7dIpa9dInSSXtSPgSKIDQQdm5+oba2NouXz+e9v+8nJiZivwxOEeATmxOlzrd/2eCC5m2CBspw77xKjoqJbYLwZfIqrmqRRa4aqEoAbwHKxf8w8KgUcuDk8rb4OLK6nbBV8PW5PeiMbaJ1tG0k9Z4CWPZ4SMuZzM7MH4PX9cgl7PLZaH3pEiIH4vLU+5Q+UXbZNOnH5imbJW1smpB5xaaNlLdOypKiB7geFNbXSxibZjJUlEMRyyIhIV2Eqez2SDiZPB2y2SxZSwuFgqWu+cUVwBUTGmBFSLuqDzuT04EyRvpkmpZ/HuOqikcvcdo1nk4edujiVoDGqFT29oBKgHF11U+UTvtshmwLgAanm1xc9eNsm5FENWPaYzDqrJfLXA/gsnUeOmXvDR9erh57MvbkpZ41hYYd+11vA/YAGU9ebjvqKqV2BaTT634dMHK/Sz5qojp5+ETpGFtOk2OMi9rMl5aWXPay9N9Gh8230eC+37R6RZUAI0/7rIiVUivPhjRBJLf/1PItMF2cL/G1krScRxoNjXuazY0yHKP2G+30l4CaX0o1BCr3pUX7/2859P+AcgePKg4wOg8eXwMVpVvjtAkK2wP4JWVCktfzor/WY2/jB82n4ed22cvbGnXyfwOMR8fXmFxlcfNgvKblxPwDDrEKgHQXBuUAAAAASUVORK5CYII=",
    ["dehu_scarf_5faf56683e38a907"] = "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",
    ["adwrable_barbie_aca42161fdceca16"] = "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",
    ["n_murder_drones"] = "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",
    ["honey_bear_bee_b80558ff4b834410"] = "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",
    ["uzi_murder_drones_3def1f9e02aa86cb"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAGBUlEQVRoBe1YXWhcVRCetVubJdmQ2NTGKtikitHWWksaA7ZihKJVWn0yJbbBYkQarRR8EDVghSgIfahKm5eAohJMqeAPtkqhqVbQthJrTDVFYlrRmPqXJZtlo21Y73duvrtn7z333s0mShAnkDln5pvzM2dmzrkbkRBatvS6DCBLLq/MQQ7/MqL6t9Y3O/Ky+aWqnbgw5shef+uZiNMpoLGi5iY1f//AVznj+MmnO8Ul0zX4r+GjYRviyV9WsjAMKpVTmMRoNgJCjUIA7pMn3E9Ofb481AEcaHB4UNITE6obKyqS8tIy1UbYc+PE1pRXqebI+O8UzVmetwOw4XI7xT2b2fxQnUcGwZ6XDhnlc0kY6gAUO5w4Th8cxDZ4VbV/uOvFcC5tWl9LqAOy4Z5wwl6E7YQaK1o8T4pKbOdw8IlxO13Yn6s81AGrV90vyb/GpELbAdtVl/rkhIb9N5qPb30l8/IbO3KuyXznjZjueYY9Ng+CA0wUn3JA76n9Ki14YwDLdwLtdJ2uZ1rNVlXnfHwnsO8en3pjBGTDnubB3L4R7HQIRnq1vE28mplJwsalPuo+GUxrX3cJsS+z8IWMjiWUjX5LmMblW+IP63qk/tiJj0ND94XtXRlcqbhuy0rjzoJaX9zoaxs2LvWeCMBm7ln3mJpsYHRITbbr4S3OpPFFMae9a3e3ajc1PClY4JGTnVqhdGBOAxsvhLhp8BKr2JaVxCUxnixkKI9NlPmuX224vmpKl0pvz35l8ICV40FUf2+7wFmMHH0s2CGlKEOfbRsPiZlw8tAkxpLKwWw3d6yPQEf90x1NvpFgHjkrjWbzPSGt1kZAn5/rU5MS1nJfhxURMWl/80ElatvymrWgtHS+s131sUDQE427Fd/3bttUJNh1gTWCeee+RpWR4Z/+knRXeWwa1d9gNi1R9I41LcoAp86NQIDJueC3jzwlj27c4/TFmhYy6rlQ2uP24JchxvryzAEwD2Hu/oEdHrlb4N489X5y6vPhkebNzzte5KLdL7j2Z5uMD52257py5vCzJ8ikz+dzeSb3POf2457cqVx8Vebaq5fJd+cGBRxFkYScHTx7xmNDPTjswYtjxZJKpxRHH23SLcvrpP/707KierkSsX389AkZOf9j4Ph8t2C8vi9OKvvx8ymprr0m0I5zu7nnFnADwgqVG6/34YTZJt2RfG4nf00XPE2oA/hSwwzTdcbhAx8IvhMaNtxV8ALdhnQqHMHvj/iiSTcs7/7/vwgxZ/1cxkoPPV561gsuw/oAXggh10HkaKMO4HSxHtYPyNnmyUNGWlm7hs2c2gNhWK2iYeSHb4cyF1OTKlQpRMgixEyTAkNdz6EPpe72dTRzOOyy7wtRhRTpo+evA7YaOh5OrShfqNINeL0g0waF+bdR86sStjg0PnVp48ejyKMJ64/5BOBnx44qPKqriUoWBxc3ffOwt6Mo4esAHQ9nAJ+esH91hj1k2DSjEdzPAcTALh+Kdu0dkqHRtFSVZ9/4NITcRCasjjMtYrqLhlMYMbqD9Hlmox2tLLY3Tp7PoGHY97pflXQyLY0trWq47s59EovH5Pr62wKHx9ci6wodhm8VOCLfG8j9O0TghJYyOpJKqwgwAf0iQMciPN20qXGbwAk9n3bJvPlLJHF2SCAzYWmLhXPx4PhcBh5cD3/g9ccZ7ckZLVYRpCiQ/yMRgBnjVy6QVSvvVnn7yfGjgYuAkr8PYPN4IfLT+ZGtOyWZuijx4twnC2QmIs4qgia1Rxbd+/5Oj4eJ8vO0KcdpQ5786U851XfQiQDK8+HcPLClFQuUCXmYfb44jpPrVkqnuF/e6b/8uExUlzVg09ptqo8aAFltwwYTPEfGSKCwfu3Ngievfkuhj6vbRKZfqE04ygIdQFAQZ6XWMch3nVgMTVgd52774eGM8ZT5itYd5R7P1J+xA3oPf+QZ94obb5DJC8Mq/KFk++evv/FgIQjC87TxViHh9IM+gBAF+VIUeW6HevazN8xYrw2r19/pgQd97nrAliAIj09e90NNSnJHgTP4W2XYIy3XUuRvjpGkNCXEUrcAAAAASUVORK5CYII=",
    ["flower_crown_pant_tears_c88a8be708bcaa05"] = "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",
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
