local texture_list_default = {}
local texture_list_slim = {
    ["fluffy_th_mariiposa"] = "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",
    ["tnt_lover_18292693"] = "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",
    ["polar_bear_5b235a5bf9a07429"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEi0lEQVRoBdVYW0tUURTeIzONV6aE0gfJghCKLkR3hG5EUYEE9tov6LV/1EsPPYSQUURpIKURUUaBRBRINSWKiJdJaTrf1m9cZ3n22WdmNMcDx3X/9l7r7L32HlPG80xOThbn5uZMLpcLeU5PT5vGxkYjbdBJP8gdHR2pUGCNCXW++cgEpS8S1TaZPHy1LOOT8mNjY0WXb5zNFaP13gLEJRFn0wPVquxdnjMzM84vkCSplpYW7xhJcDbKJ10t8JvHDyzEue7uENTg0FBIrlXBuwWSTFwnj5goXRKs/+3jLQA6uX6oI9X2rSR7twCOOp0odaBb/Un5zvkkCerjEDEoGgsUZ29tbU3xOOvq6opsmOPj45GN2HXH8OHJnFIAz77sN9samkzduR5pM4uLi1YOJmkWFhZMfX29lckHxbNyJpMJxf0d7DN/5mdN4cw1q3cdlygSirPj3YAdP991wsgiyESCMYvB+LZA5KWdE4Cufey1KQTjTx05b9USk36g8K3D5LJB8tnde62tubm55MPEmCgSx4uHOvpAx1hgARPYruThDxtWCYqPGNdEf4/02xWAxPEiljrw8gHGtpXxgc1VKH3Iw5bynfNYBe+fPWRMiB6+eN3IAoSMCQXcE7jE9ZLmF579+dVM/8qb3K42Mzc7YxZng6t5wDe177Gj6MK58KKmFNsEXWc8gQZXCnPsyg2qKqI6cYJ8fz9sWSR7/uat1NsXT+zXJ087/UldeLRL6j0GpfN68PpESYJ59Oxlu/dBu6/2lvgksT6fOjkhyfPrA6D39h37EkzL0ldigJcy40njbPQBLd67Wyz++BJ+A530qZQvHYMAQFNAV8bz+dVzS/HHdauT1919py9Yf4nBBkRMOGg7jkEbGPNn4P7dIpa9dInSSXtSPgSKIDQQdm5+oba2NouXz+e9v+8nJiZivwxOEeATmxOlzrd/2eCC5m2CBspw77xKjoqJbYLwZfIqrmqRRa4aqEoAbwHKxf8w8KgUcuDk8rb4OLK6nbBV8PW5PeiMbaJ1tG0k9Z4CWPZ4SMuZzM7MH4PX9cgl7PLZaH3pEiIH4vLU+5Q+UXbZNOnH5imbJW1smpB5xaaNlLdOypKiB7geFNbXSxibZjJUlEMRyyIhIV2Eqez2SDiZPB2y2SxZSwuFgqWu+cUVwBUTGmBFSLuqDzuT04EyRvpkmpZ/HuOqikcvcdo1nk4edujiVoDGqFT29oBKgHF11U+UTvtshmwLgAanm1xc9eNsm5FENWPaYzDqrJfLXA/gsnUeOmXvDR9erh57MvbkpZ41hYYd+11vA/YAGU9ebjvqKqV2BaTT634dMHK/Sz5qojp5+ETpGFtOk2OMi9rMl5aWXPay9N9Gh8230eC+37R6RZUAI0/7rIiVUivPhjRBJLf/1PItMF2cL/G1krScRxoNjXuazY0yHKP2G+30l4CaX0o1BCr3pUX7/2859P+AcgePKg4wOg8eXwMVpVvjtAkK2wP4JWVCktfzor/WY2/jB82n4ed22cvbGnXyfwOMR8fXmFxlcfNgvKblxPwDDrEKgHQXBuUAAAAASUVORK5CYII=",
    ["dehu_scarf_5faf56683e38a907"] = "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",
    ["adwrable_barbie_aca42161fdceca16"] = "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",
    ["honey_bear_bee_b80558ff4b834410"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAG2UlEQVRoBdVYfWhWVRg/s3d7t3dffozVFMWZ5UdBLIsIFSuRIEmG0pTAyGJimhqUYn+UaUHmR6SFiiKGi5iSNkT9RywN/SNq+Y/4UZaSqDWdc+5D381Y9/e8+92dc++5977b26IeOPc85/k653nOec7HzVIRUDltSlc85x5DalX1WLe9aH29i8djMcGTd++6tCPHv89yG31A2P/ug98Yds7WLewaW7lZaFMnPdHl7cdGs3U/wEbUaXA+np0KQLLjL4USBHBcdz5Irjd0vX/q0XnUoHmdD6JRX6+NqOoM4rOnPyOdwPGOztTM5mTH1JpFD4mIvgKoo9e2wen8vuIMQl/1qZdWAOB8y+071JG6MC9XYXZa2pKBs46UOHT0RGQfhuF/uZFK2ohOi/JzXGchWpgfl7RIdvakw6aFVYaVJZv3GO3/aiNyD8DA4ajkf3eOC97tPHIezmfnJYwC2j+9H/RHENNaAeg4dRLkyhhSeM9w4HxOQVEP4X+ERa6A0+cvKRTkOjZBFOCk97evEx4e14Xi7UenP/fURB/fRvPaQDuL56yNCScJw8tKiUp96WqD2x4/eriLA1kwfYQqG5owaFevtKutB383aEglAFaU95wHXXe8/tQZYzMN40FXPyV0HDwATjf0b6SAe95rmxuEX581Se357jRQF0D7bO9xtw0E+ktnlav8QsOsyBQVOhsp7xMe+4YRSwPOY0Zx/AKwCnG66EHQ1egwatBxYSJNlwMegzHs8vqODgYGy1n3Og8+aORDlvob916wBuFWSwfUXIAOUgmA/m3AWccqxTi59wAHre7wMWNV2GwE0di/hJS7PIgALk1defmMKXpTrd1/zG179els47U2kdlx5KrYpKNe+7vqDoc6AsclAFqgGQx3EBrinfH6mvnutZlinLABcn3tvuWJI87yRGcYpPCcY66puUW9XXOAuoKDRj5kRcfRhY11e35RCMJH+85L8fJ1+2EXJSx7FEyMLgccNPLdgWlIW0vPe+T9Xec0TgrFmGBHTgEZEM54ON3tOGhwEiUIyNf1X51aJoFBEAg6X7cPPh4tlPPWfzQ2KRSuENTcLIGTr+sx7yfM3ZYF2yi8tutyGBN4xm4Fog22rlqimq43qjHlI4X94cBiNahkiFqwcpMhDv1P9l8U2rKqB9QHX57x8Q1CROO+IYNCJWx8vhB1RRsNs48AyIfCtucseFvefNl30elovaVe2/A5VaUO0qeQjZ/OYwlLXU8B2LPR2I+3hqPefkjzbT5vVc/pKinOV9eb2xTqmbPnuvZabzaqR6fN8um4Ag4Cw2zbHK4YV64uXWmQVONGhrQAPnxoqVq/vTbU/ruL54r99judMj6Oc8X6HaF6HJO3NlIAzERutlemz23bWwD2x4wappputqpBAwvEto73pjM4P+/px9XOb3/ojZoh6wuAwc2gsW7lclXQmrotthaUqmWr1mZgLVgV75BMwPcWwNLqT4D9c79d9nUBWm/7RopuO3RMUsFnME1C1s9fb3Fzljr7Tvzo7gGk6TXzbubEx3wbIeX6sgJse8bEigdp0qiDgsUUXv1pTVp7gjUF4Big8/Zto1M2svPyiEqNjQ1w8swFqeFI3f46mdEXq14QHDTuCTZ58sSA89HlSeuPegDe8UElqENdPkgGdMwGApEu4LHDB0+6OunI4cj0ypHm2wO8gn1p25yw0Wj74zcekRnHUSjFWS1h8tRLp8axzDsEnsD8ycuLUMYBYN5iMMClOI4gRytnVMoYgdMxmzz+FcBh3O9RBEcwHHuZAmzU11TLCqB92EQgwItt2PWViufGVfJOUmowiaMGhPExWMpx1tARcv/6qX3qwNGTas0rFeqLa86Tufs975UvKsx2n7rSH5x3bFCeGx43OLRpQwbo+VAOZMx0ycCELwVgf7fDyzjEo0eWud0Tb7jWKLk/aZTLEoR8UtneuPciSUYNfiKe416agEcBnE9HjnYyDgCutbjZAXi+I7p5zmB/co77qmeflBp8yAJs8sLwfCBfUlyuht072OCEORjGM4x0N6x7wOIlS9X8+Qts8mnT0jmEl8+5X6FEweU/b0SJBPL5PLYJYB+IPV+RUCt2Onk6r0KNnFwtconCYqkRiCh4573VUSKB/LW1vwoPKyYMvCsgTNbLW7n9rPWHK/4nSAB0BTqu02x4lNz40SN8aqDxouRjhhDakx2yB0DE9njCQ0rnYbVQDnT8QHmpcloXHEYRYedDWgyzXjs5RW5vaSZfajx/owBPWAJxOFo62Plpor32Gm40y3OXsqgpz+cxeXgek4+cbndOKQDzG20dD+KBjuc9n9i8AyAoCAZ4fwOGKKY+V8Q+1wAAAABJRU5ErkJggg==",
    ["lo_fi_18328111"] = "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",
    ["reindeer_girl_6456005"] = "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",
    ["robin_cerulean"] = "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",
    ["kujou_alisa_alya_mikhailovna_28t235251_702_17574218"] = "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",
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
		texture = "blank.png^[png:" .. v,
	})
end
for i, v in pairs(texture_list_slim) do
    mcl_skins.register_simple_skin({
        texture = "blank.png^[png:" .. v,
        slim_arms = true
    })
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
