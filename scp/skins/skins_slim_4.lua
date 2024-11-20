local n_skins = 32 local texture_list_default = {}
local texture_list_slim = {
    ["polar_bear_5b235a5bf9a07429"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEi0lEQVRoBdVYW0tUURTeIzONV6aE0gfJghCKLkR3hG5EUYEE9tov6LV/1EsPPYSQUURpIKURUUaBRBRINSWKiJdJaTrf1m9cZ3n22WdmNMcDx3X/9l7r7L32HlPG80xOThbn5uZMLpcLeU5PT5vGxkYjbdBJP8gdHR2pUGCNCXW++cgEpS8S1TaZPHy1LOOT8mNjY0WXb5zNFaP13gLEJRFn0wPVquxdnjMzM84vkCSplpYW7xhJcDbKJ10t8JvHDyzEue7uENTg0FBIrlXBuwWSTFwnj5goXRKs/+3jLQA6uX6oI9X2rSR7twCOOp0odaBb/Un5zvkkCerjEDEoGgsUZ29tbU3xOOvq6opsmOPj45GN2HXH8OHJnFIAz77sN9samkzduR5pM4uLi1YOJmkWFhZMfX29lckHxbNyJpMJxf0d7DN/5mdN4cw1q3cdlygSirPj3YAdP991wsgiyESCMYvB+LZA5KWdE4Cufey1KQTjTx05b9USk36g8K3D5LJB8tnde62tubm55MPEmCgSx4uHOvpAx1hgARPYruThDxtWCYqPGNdEf4/02xWAxPEiljrw8gHGtpXxgc1VKH3Iw5bynfNYBe+fPWRMiB6+eN3IAoSMCQXcE7jE9ZLmF579+dVM/8qb3K42Mzc7YxZng6t5wDe177Gj6MK58KKmFNsEXWc8gQZXCnPsyg2qKqI6cYJ8fz9sWSR7/uat1NsXT+zXJ087/UldeLRL6j0GpfN68PpESYJ59Oxlu/dBu6/2lvgksT6fOjkhyfPrA6D39h37EkzL0ldigJcy40njbPQBLd67Wyz++BJ+A530qZQvHYMAQFNAV8bz+dVzS/HHdauT1919py9Yf4nBBkRMOGg7jkEbGPNn4P7dIpa9dInSSXtSPgSKIDQQdm5+oba2NouXz+e9v+8nJiZivwxOEeATmxOlzrd/2eCC5m2CBspw77xKjoqJbYLwZfIqrmqRRa4aqEoAbwHKxf8w8KgUcuDk8rb4OLK6nbBV8PW5PeiMbaJ1tG0k9Z4CWPZ4SMuZzM7MH4PX9cgl7PLZaH3pEiIH4vLU+5Q+UXbZNOnH5imbJW1smpB5xaaNlLdOypKiB7geFNbXSxibZjJUlEMRyyIhIV2Eqez2SDiZPB2y2SxZSwuFgqWu+cUVwBUTGmBFSLuqDzuT04EyRvpkmpZ/HuOqikcvcdo1nk4edujiVoDGqFT29oBKgHF11U+UTvtshmwLgAanm1xc9eNsm5FENWPaYzDqrJfLXA/gsnUeOmXvDR9erh57MvbkpZ41hYYd+11vA/YAGU9ebjvqKqV2BaTT634dMHK/Sz5qojp5+ETpGFtOk2OMi9rMl5aWXPay9N9Gh8230eC+37R6RZUAI0/7rIiVUivPhjRBJLf/1PItMF2cL/G1krScRxoNjXuazY0yHKP2G+30l4CaX0o1BCr3pUX7/2859P+AcgePKg4wOg8eXwMVpVvjtAkK2wP4JWVCktfzor/WY2/jB82n4ed22cvbGnXyfwOMR8fXmFxlcfNgvKblxPwDDrEKgHQXBuUAAAAASUVORK5CYII=",
    ["dehu_scarf_5faf56683e38a907"] = "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",
    ["tnt_lover_18292693"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAGb0lEQVRoBdVZDUzUZRh/zg7HwFMx+ZDQEp2D5gqck7Jhc5lzipEzstSStqhcY67wY4kfK8XpkhpR6SZOtqxmjilqtvmRSycNtlJbU/sQSc9TNA8QNJLL637v6/P3/f/vvf/dBRY92/+e7+f9ft6Pc1AY2LGj3g+TvLxsk+WePccEPz5rlMB1x38mHZ08PMFhcoyS6eq6KcqPielrihNKHmV4ckbq4HTGRGr6v7Iz9aqu5uhpbrzX0y5MBqW6BPb5uohnAgTqDBAGgZ8ZM3LClsG2/wUOWznuADR+y/Z9oo4vFUwmdAI6wOu+blvv7i4B2+A9oIx4CfRPiqUR9w8VRYK2wt7dR0yiqdNzTXxvZSLuACyDtNTBoh28JMAg+U0e1o9mzRpjaqPf7aF95zpMst7IRNwBqHx6WmJQG8S693qC5BBwTtAqe4mwTyT1wFrHh6mPj3n4nrvsDRnCThfSKYRi7cez/chH/Klm/gCoPGidzGoD3hlqn7cal28qpJKiaquYssbIvGBV7Km7EBB1UKj4vHvw+cK6z1vj2fGOAFj1GCR0Fsut8VkX0QxAkCb3LSpe+SLH+1cxKhsfew+pjeAGdLcijqsXrole0mV2BMfIo/GL51UElTU0PSFIxoJrlzuZFNgan/X33tc/aPTYEdMeNBo/7bH1NHxUklBhS0Y8tUPYJ1rsUHuSszumjwoY+ZyU2apI0HPnTzHJQvmzkU5v1wiuG9vwut65s8F0NGc9lxMNNpYAjwicVRr8gW0/UVnFSpACQKs8hKqPSkuP8HrYoYEA9mHccrHdPzr9EUO+vGQBdfz+J6sNLL2D/dlApxfbIEam0X1enO5gHHv9Mt08SzSpoET4PjfjdTq0v4aecg0QfFW/FJr45EyaMLZA8Ae2l5M8GskjcqP7Co1NTRe7BQys8a16EUTzwzMmYYi8CKm5LmGIK+JMrwltiMQMwJT/5ttjxvaWnJ1LnUeRxSUsXTSFvvr8PYrPzxQfaMgYYAsf3h45Fuut8a16tkM2B4wckW2MNuvCYfhI7+AdgX11ekfz2RZRmO46y/v4g85OcqTJ0edgfncbnfTJcR+WNEicCPngo8Zie1Wm0pHcFTB1UXmOBayTqfpIaVNQOOl6v71d3gKvet2BUe4M8lELs+tQ2BW9PY+Wz38/6FSJZbFqwxu0q3qXbfwbzW7/Q+On04kvtlJJzSp6IK0P1TV0hPVT66jSUR2FVcfu0JtrS6m19SYNHNhXhFHpaOKi8cU5pYEOeCsaN5Ntj3fAJ7UHjQImDZZL5Mxv5wlfbwRjG7wblcsuLCR8dwtwQKusL+tW+H+UcdUSjx74WrDqyLN+Y6Ws3GvFpSwy8Av5Txg0CDUxqrQrLvjBhXOAKcBt5uFn59IPdbspLjnNNpewrxPGOkCW/2yffPi06mdPzjZ2hZhB8VS0ZI4wyc9dKPCEcZnUt/EsvVpdLfg5m5fTlrKtdLjhlOBrj6ynJZXbaNO6TwWPnzO1543TnUp3eYM7wHDqAcKJ3rTCiqXL6J01q6m17YpVJfh1VYnENqdO11PGyBgh5wcTnNNXbF1LF5t9NCTZSePH9RNnd9azPQfHgefxR7PFgQkypq1HcrZvajrNZBC202HrhIO6pYacAc/k7SbMAh3wmQA2KqgPJgNcDkpNlEmQbVh/8DuWSIyGsg4S0Nz4NysWUsIAOZtb2uT5aNGap+n5Sn3mhw4+kUKP7gJ848vMyBHlLygdLXBF2Y9UUZZDmC2hgH2hV2lsdQzoVIbU1DgmTRg2qp1JqWGcH9QsFtdd6LgwZFfQe79s1rgQTZ2WLHxgoz6S8NkdTpcuXaLrnZnCH3RKSoq4WmsD3hbyqNvZdEeni9+jM4Ar98uv39O6DXNo9aJDQrTs3Yms6nXY+WGZPtOjpq2trdoKNx6/8whaUqQ1MRoPLTqit3aCMzbWnKjU5vj+Mr/qsM7Oh20w5V8ukUugqlxuf6yLBuM1SA+3tOLQ9lpz+/8Gfb4/9F6KFI8fLTdkdmYx1trM+RmGXKXZBpgfTtSkp9Orsp6mtTmAb3+hCmO9y+UKPKRcoYS4O9kZPmiYVaaLBV9AVpL+ZRn6/YfbiDO+x3ND2IM/eUJ/RiFKJLYTxmF+tB0QxsekxhWWwZsvr82lH72ive1ZK1bXIH3trsdoLO9ORHLrA+/xxHOxJixt9Vuk7u3wb9QQznFQ1lmHAAAAAElFTkSuQmCC",
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
