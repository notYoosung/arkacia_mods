local n_skins = 12 local texture_list_default = {}
local texture_list_slim = {
    ["tnt_lover_18292693"] = "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",
    ["basically_me_abandoned23232"] = "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",
    ["polar_bear_5b235a5bf9a07429"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEi0lEQVRoBdVYW0tUURTeIzONV6aE0gfJghCKLkR3hG5EUYEE9tov6LV/1EsPPYSQUURpIKURUUaBRBRINSWKiJdJaTrf1m9cZ3n22WdmNMcDx3X/9l7r7L32HlPG80xOThbn5uZMLpcLeU5PT5vGxkYjbdBJP8gdHR2pUGCNCXW++cgEpS8S1TaZPHy1LOOT8mNjY0WXb5zNFaP13gLEJRFn0wPVquxdnjMzM84vkCSplpYW7xhJcDbKJ10t8JvHDyzEue7uENTg0FBIrlXBuwWSTFwnj5goXRKs/+3jLQA6uX6oI9X2rSR7twCOOp0odaBb/Un5zvkkCerjEDEoGgsUZ29tbU3xOOvq6opsmOPj45GN2HXH8OHJnFIAz77sN9samkzduR5pM4uLi1YOJmkWFhZMfX29lckHxbNyJpMJxf0d7DN/5mdN4cw1q3cdlygSirPj3YAdP991wsgiyESCMYvB+LZA5KWdE4Cufey1KQTjTx05b9USk36g8K3D5LJB8tnde62tubm55MPEmCgSx4uHOvpAx1hgARPYruThDxtWCYqPGNdEf4/02xWAxPEiljrw8gHGtpXxgc1VKH3Iw5bynfNYBe+fPWRMiB6+eN3IAoSMCQXcE7jE9ZLmF579+dVM/8qb3K42Mzc7YxZng6t5wDe177Gj6MK58KKmFNsEXWc8gQZXCnPsyg2qKqI6cYJ8fz9sWSR7/uat1NsXT+zXJ087/UldeLRL6j0GpfN68PpESYJ59Oxlu/dBu6/2lvgksT6fOjkhyfPrA6D39h37EkzL0ldigJcy40njbPQBLd67Wyz++BJ+A530qZQvHYMAQFNAV8bz+dVzS/HHdauT1919py9Yf4nBBkRMOGg7jkEbGPNn4P7dIpa9dInSSXtSPgSKIDQQdm5+oba2NouXz+e9v+8nJiZivwxOEeATmxOlzrd/2eCC5m2CBspw77xKjoqJbYLwZfIqrmqRRa4aqEoAbwHKxf8w8KgUcuDk8rb4OLK6nbBV8PW5PeiMbaJ1tG0k9Z4CWPZ4SMuZzM7MH4PX9cgl7PLZaH3pEiIH4vLU+5Q+UXbZNOnH5imbJW1smpB5xaaNlLdOypKiB7geFNbXSxibZjJUlEMRyyIhIV2Eqez2SDiZPB2y2SxZSwuFgqWu+cUVwBUTGmBFSLuqDzuT04EyRvpkmpZ/HuOqikcvcdo1nk4edujiVoDGqFT29oBKgHF11U+UTvtshmwLgAanm1xc9eNsm5FENWPaYzDqrJfLXA/gsnUeOmXvDR9erh57MvbkpZ41hYYd+11vA/YAGU9ebjvqKqV2BaTT634dMHK/Sz5qojp5+ETpGFtOk2OMi9rMl5aWXPay9N9Gh8230eC+37R6RZUAI0/7rIiVUivPhjRBJLf/1PItMF2cL/G1krScRxoNjXuazY0yHKP2G+30l4CaX0o1BCr3pUX7/2859P+AcgePKg4wOg8eXwMVpVvjtAkK2wP4JWVCktfzor/WY2/jB82n4ed22cvbGnXyfwOMR8fXmFxlcfNgvKblxPwDDrEKgHQXBuUAAAAASUVORK5CYII=",
    ["egg_girl"] = "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",
    ["dehu_scarf_5faf56683e38a907"] = "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",
    ["reindeer_girl_6456005"] = "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",
    ["adwrable_barbie_aca42161fdceca16"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAFe0lEQVRoBeVY7WscRRif3b3LJX3RolZEaEFFPwbyh1ixUjQIfm2qd3m1UcEPFQQlNU2aRJtAPgkSStqC/in56Ae/iFJ8o9qW3OXudp3fs/fbm52b3dtwVxLxgdl55ve8zPPMzM7OrKf60Pr1lShPpdGoq6BUUu1WS2roCh9orN1SH376iZdn30+2vrQq/dcWZ1N+THzly+vR3MdXU3IX5uqr5AJtLAwjFUbtFOz7vvI9P0k6Jew0Aj0Iw6AwCnvcAEP/IDv5LEyUrUehCJE8ZjVFetb9zsyn8E4Dsz8MsmeePmc+mk/NOPHD1oUGALOtjGSx5AXTswDeJhdm6xyXdm/0jsjCMEytAFkNGIQgXoIwma29n7JcXf8m1T6ujW4GORFits1ZTVaAtsFgIPmo7KcKsJ7XJqePoxIVGgDXCgAGMgfGTiJPZuseVbvQAJT0bl6pjKYKMFDeLOfJhpnwV59/0fOpdmGuPj1+5yMV+/CUY3ONNOb19JHyB3unbUrL0YBvTVm7vcOiEMRzApVt/5TLCiiXyxL8SHlEgQexBl+tTaFKUbV6JWnTHjXtUHNQBdPfbFtOB+VKQNZZt365L6O/eXM92lzdEJ6Y00CDpk+Tpz6xvq8AEt3YuEW7pAZmDkIiMJjMFdE5wIiqXllTMzXHsosdIdHtO7uG15jd3r2j8gZBfGLV5q1cLfNuLi1HlZGKajabyeyRbxw0ko6vTL2X8GBubX6btF32WE31g7roTF+6pNQ/jxJ9YZ46pdZ248RmFhcyBwC6mPlG40ChH9B+fV+NjY6pqdlqrh1yg/705CSMlPfay6If/fhTpB2otZ0d5eHMDGdIlh2QR0egvb09qbc2b0h9eWpe6vHxcakz7fdj+9l33o7tv/8htn/jgtSrt287j7Ei1A/EBt5XesPVs+X7cb61q3MycfwSuY7C9IG6/dsfka8H0Dv3YjwAP/8ahZURFTz/nOdjp27pAmetVjPFI3GUa9c+UyfGTiQ+wQOjvGtv+mrJZQhH4q/v3hNb8a9XGggY+s7brSE3vyRIHAX2WDW2HLhJ8I2CRJEwiclDJt+ydhif9eV4q7XgmDyMzr/6kpqYmFCl0VPiAzwwUlMPnBmoyUMH/uO6e6khJoICj2Gd/dEVBoRdejJC+liLoHlwIc9EFuam5ZRHI9ReM1TLK2sCwY42AMjTPk9e5LqMGG09FybBOB6uqzGxZCRoFx7sy3uHNpLEEZeEtnfyZI8N5aj7DejC5Ltq495d0yThqxffUt4r53P9Mz4ztiJxJZ1YTKHLkGUzcBOJHhfqTu8TiGhmvqpQjjM90QFwJZ61/KGbJ3P5GgZW4juV5Qzvl0nR48eRuS/cWFo1xX15/ENc3vkupWdukticzE10fnE2pWs2zNgQF2SMzR8Zy91L6GcoKwBBmoHiE2q2wZufVZc+AoIO9Vgz0EFqnghNH8SGsgmGv/9t+paflS6MSi4ZVgF/cpo8bXrq+3/2QAKcO9uD86jNmy8OU8QGXgEIlgQeBZek4JkzhIUXrCOngPq4JWLGeVskDzkGy1XUC88qV6Eu+0DNG6R5kiTWjd60OARvLlWTh4vgdHxypDtbbrY5+9AlD3lw9mmap2trb6IwU18rMGnzEjXwCmCwCAA8ytbWtsTTfvhIoYCAUS6Aftht4qwhx87mKtSxa+raeFZ74AHIcvxfwQd+BZBocOZ0nG/n9xYa7b8exJjJd+SJfqJxdMxQBqD94GGcQd7fF2h05In+0eWd9Py/eAXMTY+ZExvKAAT1A4VCuvz6BRW0o1QBRrL18QvOJhdm6xRt8/uPpJk4sYFfgcybnSMpO2Da8g5gJu15nvrgzYvyBbDtDtvG958J05Z/lv4FVKm9W/qqqjEAAAAASUVORK5CYII=",
    ["kujou_alisa_alya_mikhailovna_28t235251_702_17574218"] = "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",
    ["honey_bear_bee_b80558ff4b834410"] = "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",
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
