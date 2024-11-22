local n_skins = 22 local texture_list_default = {}
local texture_list_slim = {
    ["n_murder_drones"] = "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",
    ["nature_girl_exoticblue"] = "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",
    ["pink_uniform_3ce30faa1ac401b2"] = "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",
    ["poinsettia_skinmas"] = "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",
    ["polar_bear_5b235a5bf9a07429"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEi0lEQVRoBdVYW0tUURTeIzONV6aE0gfJghCKLkR3hG5EUYEE9tov6LV/1EsPPYSQUURpIKURUUaBRBRINSWKiJdJaTrf1m9cZ3n22WdmNMcDx3X/9l7r7L32HlPG80xOThbn5uZMLpcLeU5PT5vGxkYjbdBJP8gdHR2pUGCNCXW++cgEpS8S1TaZPHy1LOOT8mNjY0WXb5zNFaP13gLEJRFn0wPVquxdnjMzM84vkCSplpYW7xhJcDbKJ10t8JvHDyzEue7uENTg0FBIrlXBuwWSTFwnj5goXRKs/+3jLQA6uX6oI9X2rSR7twCOOp0odaBb/Un5zvkkCerjEDEoGgsUZ29tbU3xOOvq6opsmOPj45GN2HXH8OHJnFIAz77sN9samkzduR5pM4uLi1YOJmkWFhZMfX29lckHxbNyJpMJxf0d7DN/5mdN4cw1q3cdlygSirPj3YAdP991wsgiyESCMYvB+LZA5KWdE4Cufey1KQTjTx05b9USk36g8K3D5LJB8tnde62tubm55MPEmCgSx4uHOvpAx1hgARPYruThDxtWCYqPGNdEf4/02xWAxPEiljrw8gHGtpXxgc1VKH3Iw5bynfNYBe+fPWRMiB6+eN3IAoSMCQXcE7jE9ZLmF579+dVM/8qb3K42Mzc7YxZng6t5wDe177Gj6MK58KKmFNsEXWc8gQZXCnPsyg2qKqI6cYJ8fz9sWSR7/uat1NsXT+zXJ087/UldeLRL6j0GpfN68PpESYJ59Oxlu/dBu6/2lvgksT6fOjkhyfPrA6D39h37EkzL0ldigJcy40njbPQBLd67Wyz++BJ+A530qZQvHYMAQFNAV8bz+dVzS/HHdauT1919py9Yf4nBBkRMOGg7jkEbGPNn4P7dIpa9dInSSXtSPgSKIDQQdm5+oba2NouXz+e9v+8nJiZivwxOEeATmxOlzrd/2eCC5m2CBspw77xKjoqJbYLwZfIqrmqRRa4aqEoAbwHKxf8w8KgUcuDk8rb4OLK6nbBV8PW5PeiMbaJ1tG0k9Z4CWPZ4SMuZzM7MH4PX9cgl7PLZaH3pEiIH4vLU+5Q+UXbZNOnH5imbJW1smpB5xaaNlLdOypKiB7geFNbXSxibZjJUlEMRyyIhIV2Eqez2SDiZPB2y2SxZSwuFgqWu+cUVwBUTGmBFSLuqDzuT04EyRvpkmpZ/HuOqikcvcdo1nk4edujiVoDGqFT29oBKgHF11U+UTvtshmwLgAanm1xc9eNsm5FENWPaYzDqrJfLXA/gsnUeOmXvDR9erh57MvbkpZ41hYYd+11vA/YAGU9ebjvqKqV2BaTT634dMHK/Sz5qojp5+ETpGFtOk2OMi9rMl5aWXPay9N9Gh8230eC+37R6RZUAI0/7rIiVUivPhjRBJLf/1PItMF2cL/G1krScRxoNjXuazY0yHKP2G+30l4CaX0o1BCr3pUX7/2859P+AcgePKg4wOg8eXwMVpVvjtAkK2wP4JWVCktfzor/WY2/jB82n4ed22cvbGnXyfwOMR8fXmFxlcfNgvKblxPwDDrEKgHQXBuUAAAAASUVORK5CYII=",
    ["reindeer_girl_6456005"] = "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",
    ["robin213"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAABrdJREFUaEPdWWtsFFUU/qasu3QLC4a2sCGoKGKRpC/lGWxCCT8sAoKGRomJsYh/lBCNwYYEQpVU4yNEE38Q0EQTpARpEINRQluxUOTVUkJoIlKiqa1tQVpoabe7O3Lu7JnevTs7M7U1Ys+fu/femTtzvvOd7547q8HBVmTn6nRJRvq96Oj8y2z5NnVc7X/T2KA5PeO/nHd8uZLCxTo5nps1HQ1NzWbr5DjP/+8B2LJmld7SeQNT0ydCbQkQcpSNGSL3RwUAKkVlIJzou7uq2pFlTmv8m/OOLyczgF9EBaC8/E20Xr4S957BGQ+itPR9jAoA5NwnLbACoKu9Fb3dtwUI/kAqJmQGRwcAqgiyuLEoUp8YQEYgkJHzZKOCAQwAO261/ZWvfx2YPiY+VZsjKN350d2fAk4Oyg7LHpLiq5Zsa0xWM9C4211C1iJKSbf3OQmoRgtb7e9McS6CrBZiEOS0IH0gk2sHNW3k9HEjkhQkeRvm9y3bV+ko4q4AsNrfWeycFmBH7WoFVThlZ5yckDWInyEHbLhMEAyw2t74JWluQ8kzljh8vPtrMS47ZLcWXaeaGwB2V1WL20oKF4tnle2rFP0V2bnDTgUBgBo92Qn6feTyVTF0qPwN0S4v/VC0S2c8kABAMiYke4YTAAB0cpRYxI4DEO8d6w8rDUwN4JJWzbWGG12oOPgdirYsx6n1bwmH5+58F4fLDqF45ZMCBKv8ZC1QGaIC4QQApQAzgByPBUewlhjhRkPs0lhTdwFZoLi23/xVBbJX5qF+c5lYK2/7FjQerMf254pNBvC5wOo8YLUma4dLACyjTCfVYWsAA8AoWe33dvu8fER2e0KUn+UUwZFw0pYB6uT8Ofl6d/ctMRwIjBOtP9Uv2t7bvTh5+pxtzhGgdg+8eLPLXE++jtYmc1o/qn9urh8Kh9B9bhounfhZ3DsxMwM5a18dkiYkXPzoIzPjHJgyOTPOn6pjtY4AyDsI38xjzeEBtP3ZbokRPctpfV3/UgfO3Smh8qGjDj/tyEBX2zWx3vzVRcicV3R3ALD//EWTQcSoZ3Nmi0PUyABg4KcjjM5Tk00GzFo4b/gAjFQKENVlmz1+gujyOKeVmgbuUuA0gDnoDR3D2U/vMxlwf3bW0FOAHLbLWdYDvoZ1gfvf17wIn9cnuh6PB6tzPhFfiepaWuIYsGDqVFEeHzj/GiKRMHQd6A/1i3u9Hi80eMzXoMi6MdKAZEZrkmkwiigr07QvNI0AkEWOLpT7BAA7zb/l+ZoTryAcPYlU7xNIwQWszKkWRcu2itWYnfW2EfWmZVi3pEH83nX0JURRh4FwjrjP7y2AhkaR05zbco5TpHmecp76gMEAakPhHHg955P2NZCgT7tTNfye0I4YABTJNH8axsCLdUs+E4URASDb1uIDQgMIACCKvoFeaFpKQvTVSBEbmB38W2YIscDnMXYpsv5wr1jTiD6x6og7ANLGpaHnVo+4kX6TUV9VbFJqvpa2LmJA960qjPUuwnj/FRFpVvxdR3NFZBmUQQBIxfPQE6q2ZQAxQUd2HAM0LBDqLzPA52kyGdQfzjIZYTCHdggbBhQWLNJlh90CwAAdPvqCyGUyymefJxVbiyulaMMCALpaR3/Y+IQmR3AoDGAN4IjTvfKYKwYsnJevj/UNFjr/VAM8KfOBlDPwpRRgkO4GAyiSW4uvYlsFHZ6ofwYRZKMvVAu6T46gqgVWDGCN6AlViftVDSBtSfMWxjTFgQEsgsSCjo4OBMYHkJrmRzQSESlANJdFT9OAYDCIvr4BXL/eKVKAIxBFVOiAvUWhI2pGitgT8A/+t2DFADmqdspv9Vyf57izBti9sNM2aABgqHB/5DjGjikAUG+h6nki8sBjdw7UZ0XbE6qJMeBi3DjPU9u4Z2bc69EXZ9noS7Q8pvZnPPWjPQB7d+7QH8p6WKz5a9MvopX73Te7EIgVMfxbnl/zslHgyEa1KBcXWuwEq5sjDgRRpi/s6QH9x0BG/z3wJ3fq86d4nlevoXlHAIqLliYUQsGgUf+3tlrX7PI7rnp6mQkYjdefpigDeXMeN0El4HjMCmSa42sIbAaYxid2tZmf2dXP7iMCwMaStQkApKdPEi/c2XktAQQGh0H4oZaKkuRGRZSaRkPhwMEPNuGPy7+B6nw+9fHhZ9aiPPFnjBUDLtXWY8KUSSjY2GyfAu9s2mBbChMIsjE4PPZtVW2cSN7j9WEgti3Kx2pZSNXKk9ZSzwZ8PH7v+eWi1idnySk68cnHXzkl5LS40d4hQMuYuzcp3lQJ/g0BveJdEfzUfwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    ["robin_cerulean"] = "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",
    ["strawberry_kitty_13486c32a706077"] = "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",
    ["tnt_lover_18292693"] = "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",
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
