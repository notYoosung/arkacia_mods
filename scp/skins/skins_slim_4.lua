local n_skins = 32 local texture_list_default = {}
local texture_list_slim = {
    ["poinsettia_skinmas"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAKV0lEQVRoBc1ZC3CU1RU+G3ZTNiQkm4Ss2bzQrDwSkrFtCIilxhEEQWxHYrXMoMU4Y1v60rbKONRS7XSENjKtYsUWUNsGGQLTMtVCSUfa0TLEWJwEgjzSJtmQsEtea0KSJpDt/c6/599///23KZjaXmZz73/vOefe8z73YqMJmtfrDQEkNzeXITMzM7n3+/3cNzY2ci9/CgoKZCjrtqiJq/xYt25daGBggGpra6PoYD49PZ2qq6ttqampfEaQNu6vzhaFY7W13Woy3lxvby+JAOLBTPY8mI/XcB60YDCoM2pWSDxcmZ9QAKJ5ILS1tdGsWbMY1+12C43/am/WvGy2a9cunWmZu5Y+YSKkF+1JdHegkDYMZtPR+bfQouZUyrknGIP2s5WVtHftvfT6vXfSTz5bHrN+rRPNS1bo5m0cXys9M96EAtjZ5qGipCHKTwuSjB/Z6aCXnYn0cKuD6YH57HQb5bozKD9rGveTJYSiujdtB8u+GALzMsamvWvX6IIxM3U13xMKwOMIUV1wGrX3p5KMr8tOo1fec7JQZDMwLw1CmKz2XFFVaHnDbhuYlzGYT/9VjW0yLGLCGLDvdhsN/LmefnG2jXla+N35dOFIorKKEB3szOY5aN/cjAIxr13N92PNO3TiGC/74ZJQ+sYatoqiut362tXQNMJOKABH0zlCusEPLeX9NHoqTQ3SxtQfFQvOY/bja4c21jHTsIrJ2NVmzPMIdPB1mPszN08jMG9uVmkQgXG5p4vxfjkTgiGSOkHwJWt0d3fzVEdHB/eLFy8mY54XXxe8/7Q340mdAHykS3PWqKysDKWkpFBUDNj6+YvMBISw+k+RGAMCx48f59+ZM2cIP2EEG4B5xAU0qwzBC3H+GPM8zBu+fi2+Lft/s2apfnCcW2oFq+2xN/vUspoCXYMS7ZekXqJnk7sYr7OzkzweD4+NFiBC2J/n4aAoVlA+10YXuvqVqyQxjqrUKCMjg1wuFwuuv78fxQsN3NRPYtKiQekR+Y1mDo0Z6fT19dGWLVvYDYxBEQKUbyumzXMcWZHmEOkfKuhkC2geSqLOMRs15GguMDQ0ROu9JYyLgPfyhf4oOk/3D+l4EAKC45c+PUz1p0Ikwtj+0Bid35/KAhBXAxwCmzArzCPaY76qqoq1uWOHFghLS0u5/IUSIAxpWDfTECFIL7DSy14JwjxSnPj+D87X6swDwdU7QjX17zIuovvA+2f4J8Sg6cdHT9KhNW3MPGjCAmBNSJcwT6kdhHmpKeTgYBraA02J/LAS/KShtnc4HHwvMM5jXawFNEBT0iR6CAEw0gvzgEuA5o8uJwLTMHkJfPCdT3Rov2/Mu5WWZtzAxY4nzc5jzIkgxBWQIf5aFGRhPFoxGiUMY+1grClw8Fu+/jBrHIeUBm2DrtCW+cOHD7OQMC8Cqqio0P0ecKAp8USEIZYgzEtNYXmTQs2PtnBGAfd/2P9t6t10hAKfzKK5c/KoZ/d7lL6pgu68p5rXuzRX11OlOfBkfyGLtqraAYzDvVBbnHhtL+Ma/8hNTvaX73i3OmFc9pNULd9CG/sj1oi1QeCyf5QABMHco8aXwkaqvPbAJVr72zoaG9PSnhkn3rcwJ+tKi3HPgDXA4borY8GDhYhgMJZ5Y2+1btwfNHkDI9KqVatCCDIZb0+h03P81NDQQHl5eQzi8/moq6srBseI/+qaqtCGt97Up2bPnq2Pn5znpefb/HylLjmWQG8VBnhtfVcy7SmZymNzvtaRw4PmZ55gZjv8PbSxvpFwJrSJzhVGj+mi6gDj6l9c2kOHMP+7qnL626bVRpCrHv/oRKSwOpDVouML8/rExziIKYVZG9qjj34MMN/UNEJdvZaWpsNhINp/9rYVPC/3BGF+8/AV+nEUxv/2I8YCkBWMTUzMOPdRxgiE/0/NBp/HgaB5KYAur1Q+uWcPlZWVWZ519gduAkxLSwtVpmQxjGheEOJZgKyjR0xAE+vA+PTp0+i4gcb8uSZzDK8hBlg1CdZF39v8b2OV4LILIOhtXeCjxGNOni+kZPr9l++nJ6c08XffgQ8FnvvZFPscJgwD4NcX2+muistU/8ow5Q64qPDxmbRnOET3Oa3P9OLtCyL01ViYg8t5PxPOsREIHnXssxZAPHgTuv7JAkBZ2X2sW7/Bcb3vSqPGbSd1QAmGmEB2yAxe4bU7btWEpgOqwfzApxQtosUPau401jxGPy0voMRZ1jHk3NvqxcniEaWk5BKtfq7BSFofbyrTrEefCA/iwZvh5NsO0z9YKJ9ajyrLs3AaW4Gs3PXS6zKk+wdLaPmwdv393I56ni8uLtbXtz8wg47s8+maxMLSb91E3/n5P3QY3Cil7XusjBx56r0hPYvGe3rJ2+GnnjMXCbSFLpSk8jajYPyVN94R9Kh+0aJFOpxxIXTuhZDQv6LoJ972fTZHO+r1YHAq52bkfDSJ+ku+mkOX/aManZeIbqhcyeOio5f4fRCXJ7dTcwccStojr7XS9gdm0pRcNyVkKMZ6A8w8W1YYyFitAZ4IP4oqffGGcJ/KPk8ltJC8JwhMvOCc/8cBdbP10y6mFvlj837N0v/siMrdzm4qLIyYgXtxDvUF+iPMh+n8vfYNHtUlr+T3QY7ozkGeE+3IlmCqu7uBBSslqrmuF1hZh4CMmgY8FOQ76dMtAThWdMzKEdoT9XY8giD4nco8ocOK1mGGVg0xoEcd9lDhRa7xn3BOiTkUXoSgJfXixNoDk+ayufryPzXygS4KBBy02dPLdDb4veSarmUDCBnxx2hhVgIwK8d4blyEQH/OoVfZCt4pfzQE+rg52hHhnx6fQflHrtBBl1a8gPEO/wi9q+7zxla6Puznx7g+p5MHTlL7eCHN79AeRwX2xqljVOScTt6biynhOieN+AeovekSNQ8rdzC0gHucv1p7RlUKtlN11jBdUIXSzr4B8qjnOVyroaDilmL2a7gDLALvCNahkQgVrOvu6UQbtY0+WPZgqP6URh+CaPN9SL85r9HH5cgOLeUXZ7JP4xUILWNWPuUGhlTlp73faaRIzwqoD2Dy7Ic5hVS5OkVAuHdd30PpHjfZs65XMSCFpg4GKcnXRlmd4XgShg7u1QaoP8BsIKDdGPE2gQeZIrUM6+xW/0YXDFO+LzFyzr4wEVPHsUIpyNiM9P2DKey+Qp/TIMxM3vyBeIc7Uf0dMtKIGhsfPEG8fl/0/9/dOFUd3uknb3ZfxAI6x2MswGXXBLKC71qJdNw/nc6OOKhcvUuAedAm0mIMBNHen6yfU3xeTD/qgIYPmD2sQIlSdwFoHvTxbsAC2JY9qPJ2CzkWlDKqxAADnbhD7UYX4EpSzHNrYhP5WtUtrVVDkxrCnRdbQAECqXhmRiLV5LVyLVKu3ArMy21Ro0KEc0IgsIaxcHEmtAXGqo8IIbIqL0gsANGoSLNn3mqOARHw2JHgyAqYxzMX3Ehyt6QuY/oTeGO/J5M43ZEKJcBpbkmipgUqPigPNO8DPN827QpspCFjuKWVUBBnpJ0dyiQ8m+Pq/S9CYC6L1hwQqwAAAABJRU5ErkJggg==",
    ["pink_uniform_3ce30faa1ac401b2"] = "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",
    ["nature_girl_exoticblue"] = "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",
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
