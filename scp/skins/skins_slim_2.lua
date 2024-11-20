local n_skins = 12 local texture_list_default = {}
local texture_list_slim = {
    ["basically_me_abandoned23232"] = "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",
    ["strawberry_kitty_13486c32a706077"] = "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",
    ["egg_girl"] = "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",
    ["uzi_murder_drones_3def1f9e02aa86cb"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAGBUlEQVRoBe1YXWhcVRCetVubJdmQ2NTGKtikitHWWksaA7ZihKJVWn0yJbbBYkQarRR8EDVghSgIfahKm5eAohJMqeAPtkqhqVbQthJrTDVFYlrRmPqXJZtlo21Y73duvrtn7z333s0mShAnkDln5pvzM2dmzrkbkRBatvS6DCBLLq/MQQ7/MqL6t9Y3O/Ky+aWqnbgw5shef+uZiNMpoLGi5iY1f//AVznj+MmnO8Ul0zX4r+GjYRviyV9WsjAMKpVTmMRoNgJCjUIA7pMn3E9Ofb481AEcaHB4UNITE6obKyqS8tIy1UbYc+PE1pRXqebI+O8UzVmetwOw4XI7xT2b2fxQnUcGwZ6XDhnlc0kY6gAUO5w4Th8cxDZ4VbV/uOvFcC5tWl9LqAOy4Z5wwl6E7YQaK1o8T4pKbOdw8IlxO13Yn6s81AGrV90vyb/GpELbAdtVl/rkhIb9N5qPb30l8/IbO3KuyXznjZjueYY9Ng+CA0wUn3JA76n9Ki14YwDLdwLtdJ2uZ1rNVlXnfHwnsO8en3pjBGTDnubB3L4R7HQIRnq1vE28mplJwsalPuo+GUxrX3cJsS+z8IWMjiWUjX5LmMblW+IP63qk/tiJj0ND94XtXRlcqbhuy0rjzoJaX9zoaxs2LvWeCMBm7ln3mJpsYHRITbbr4S3OpPFFMae9a3e3ajc1PClY4JGTnVqhdGBOAxsvhLhp8BKr2JaVxCUxnixkKI9NlPmuX224vmpKl0pvz35l8ICV40FUf2+7wFmMHH0s2CGlKEOfbRsPiZlw8tAkxpLKwWw3d6yPQEf90x1NvpFgHjkrjWbzPSGt1kZAn5/rU5MS1nJfhxURMWl/80ElatvymrWgtHS+s131sUDQE427Fd/3bttUJNh1gTWCeee+RpWR4Z/+knRXeWwa1d9gNi1R9I41LcoAp86NQIDJueC3jzwlj27c4/TFmhYy6rlQ2uP24JchxvryzAEwD2Hu/oEdHrlb4N489X5y6vPhkebNzzte5KLdL7j2Z5uMD52257py5vCzJ8ikz+dzeSb3POf2457cqVx8Vebaq5fJd+cGBRxFkYScHTx7xmNDPTjswYtjxZJKpxRHH23SLcvrpP/707KierkSsX389AkZOf9j4Ph8t2C8vi9OKvvx8ymprr0m0I5zu7nnFnADwgqVG6/34YTZJt2RfG4nf00XPE2oA/hSwwzTdcbhAx8IvhMaNtxV8ALdhnQqHMHvj/iiSTcs7/7/vwgxZ/1cxkoPPV561gsuw/oAXggh10HkaKMO4HSxHtYPyNnmyUNGWlm7hs2c2gNhWK2iYeSHb4cyF1OTKlQpRMgixEyTAkNdz6EPpe72dTRzOOyy7wtRhRTpo+evA7YaOh5OrShfqNINeL0g0waF+bdR86sStjg0PnVp48ejyKMJ64/5BOBnx44qPKqriUoWBxc3ffOwt6Mo4esAHQ9nAJ+esH91hj1k2DSjEdzPAcTALh+Kdu0dkqHRtFSVZ9/4NITcRCasjjMtYrqLhlMYMbqD9Hlmox2tLLY3Tp7PoGHY97pflXQyLY0trWq47s59EovH5Pr62wKHx9ci6wodhm8VOCLfG8j9O0TghJYyOpJKqwgwAf0iQMciPN20qXGbwAk9n3bJvPlLJHF2SCAzYWmLhXPx4PhcBh5cD3/g9ccZ7ckZLVYRpCiQ/yMRgBnjVy6QVSvvVnn7yfGjgYuAkr8PYPN4IfLT+ZGtOyWZuijx4twnC2QmIs4qgia1Rxbd+/5Oj4eJ8vO0KcdpQ5786U851XfQiQDK8+HcPLClFQuUCXmYfb44jpPrVkqnuF/e6b/8uExUlzVg09ptqo8aAFltwwYTPEfGSKCwfu3Ngievfkuhj6vbRKZfqE04ygIdQFAQZ6XWMch3nVgMTVgd52774eGM8ZT5itYd5R7P1J+xA3oPf+QZ94obb5DJC8Mq/KFk++evv/FgIQjC87TxViHh9IM+gBAF+VIUeW6HevazN8xYrw2r19/pgQd97nrAliAIj09e90NNSnJHgTP4W2XYIy3XUuRvjpGkNCXEUrcAAAAASUVORK5CYII=",
    ["reindeer_girl_6456005"] = "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",
    ["adwrable_barbie_aca42161fdceca16"] = "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",
    ["honey_bear_bee_b80558ff4b834410"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAG2UlEQVRoBdVYfWhWVRg/s3d7t3dffozVFMWZ5UdBLIsIFSuRIEmG0pTAyGJimhqUYn+UaUHmR6SFiiKGi5iSNkT9RywN/SNq+Y/4UZaSqDWdc+5D381Y9/e8+92dc++5977b26IeOPc85/k653nOec7HzVIRUDltSlc85x5DalX1WLe9aH29i8djMcGTd++6tCPHv89yG31A2P/ug98Yds7WLewaW7lZaFMnPdHl7cdGs3U/wEbUaXA+np0KQLLjL4USBHBcdz5Irjd0vX/q0XnUoHmdD6JRX6+NqOoM4rOnPyOdwPGOztTM5mTH1JpFD4mIvgKoo9e2wen8vuIMQl/1qZdWAOB8y+071JG6MC9XYXZa2pKBs46UOHT0RGQfhuF/uZFK2ohOi/JzXGchWpgfl7RIdvakw6aFVYaVJZv3GO3/aiNyD8DA4ajkf3eOC97tPHIezmfnJYwC2j+9H/RHENNaAeg4dRLkyhhSeM9w4HxOQVEP4X+ERa6A0+cvKRTkOjZBFOCk97evEx4e14Xi7UenP/fURB/fRvPaQDuL56yNCScJw8tKiUp96WqD2x4/eriLA1kwfYQqG5owaFevtKutB383aEglAFaU95wHXXe8/tQZYzMN40FXPyV0HDwATjf0b6SAe95rmxuEX581Se357jRQF0D7bO9xtw0E+ktnlav8QsOsyBQVOhsp7xMe+4YRSwPOY0Zx/AKwCnG66EHQ1egwatBxYSJNlwMegzHs8vqODgYGy1n3Og8+aORDlvob916wBuFWSwfUXIAOUgmA/m3AWccqxTi59wAHre7wMWNV2GwE0di/hJS7PIgALk1defmMKXpTrd1/zG179els47U2kdlx5KrYpKNe+7vqDoc6AsclAFqgGQx3EBrinfH6mvnutZlinLABcn3tvuWJI87yRGcYpPCcY66puUW9XXOAuoKDRj5kRcfRhY11e35RCMJH+85L8fJ1+2EXJSx7FEyMLgccNPLdgWlIW0vPe+T9Xec0TgrFmGBHTgEZEM54ON3tOGhwEiUIyNf1X51aJoFBEAg6X7cPPh4tlPPWfzQ2KRSuENTcLIGTr+sx7yfM3ZYF2yi8tutyGBN4xm4Fog22rlqimq43qjHlI4X94cBiNahkiFqwcpMhDv1P9l8U2rKqB9QHX57x8Q1CROO+IYNCJWx8vhB1RRsNs48AyIfCtucseFvefNl30elovaVe2/A5VaUO0qeQjZ/OYwlLXU8B2LPR2I+3hqPefkjzbT5vVc/pKinOV9eb2xTqmbPnuvZabzaqR6fN8um4Ag4Cw2zbHK4YV64uXWmQVONGhrQAPnxoqVq/vTbU/ruL54r99judMj6Oc8X6HaF6HJO3NlIAzERutlemz23bWwD2x4wappputqpBAwvEto73pjM4P+/px9XOb3/ojZoh6wuAwc2gsW7lclXQmrotthaUqmWr1mZgLVgV75BMwPcWwNLqT4D9c79d9nUBWm/7RopuO3RMUsFnME1C1s9fb3Fzljr7Tvzo7gGk6TXzbubEx3wbIeX6sgJse8bEigdp0qiDgsUUXv1pTVp7gjUF4Big8/Zto1M2svPyiEqNjQ1w8swFqeFI3f46mdEXq14QHDTuCTZ58sSA89HlSeuPegDe8UElqENdPkgGdMwGApEu4LHDB0+6OunI4cj0ypHm2wO8gn1p25yw0Wj74zcekRnHUSjFWS1h8tRLp8axzDsEnsD8ycuLUMYBYN5iMMClOI4gRytnVMoYgdMxmzz+FcBh3O9RBEcwHHuZAmzU11TLCqB92EQgwItt2PWViufGVfJOUmowiaMGhPExWMpx1tARcv/6qX3qwNGTas0rFeqLa86Tufs975UvKsx2n7rSH5x3bFCeGx43OLRpQwbo+VAOZMx0ycCELwVgf7fDyzjEo0eWud0Tb7jWKLk/aZTLEoR8UtneuPciSUYNfiKe416agEcBnE9HjnYyDgCutbjZAXi+I7p5zmB/co77qmeflBp8yAJs8sLwfCBfUlyuht072OCEORjGM4x0N6x7wOIlS9X8+Qts8mnT0jmEl8+5X6FEweU/b0SJBPL5PLYJYB+IPV+RUCt2Onk6r0KNnFwtconCYqkRiCh4573VUSKB/LW1vwoPKyYMvCsgTNbLW7n9rPWHK/4nSAB0BTqu02x4lNz40SN8aqDxouRjhhDakx2yB0DE9njCQ0rnYbVQDnT8QHmpcloXHEYRYedDWgyzXjs5RW5vaSZfajx/owBPWAJxOFo62Plpor32Gm40y3OXsqgpz+cxeXgek4+cbndOKQDzG20dD+KBjuc9n9i8AyAoCAZ4fwOGKKY+V8Q+1wAAAABJRU5ErkJggg==",
    ["flower_crown_pant_tears_c88a8be708bcaa05"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAIB0lEQVRoBb1Za0zURxCfIwSB43GnmBAFU0xKTCq1SiSN9VHQ0KQ1VbAG1FpqEUx91H5o0jSlFWObfmlTX7UVX9BqFa2AVmw/KIViTNoYi5YYKlSrgGIQy+sEbcJ1f3s3y96fO+6OAyf5s7Ozs7M7s7Mzs4eJvMBbS9PskVFR1NPdTWhNJpPCQbPb7ZLOYjAOGvMdKD9v4rGRtls2rrTbbI/o80Mnpax3czLslshwKtx9JGDZQb5syhIVLpVEi4VhCLQMoAN4XOJiHIYIFKD8eItliBir1UKFG1cFvIBPBtBXt1qiHd2Yp2ULY/Au0A44e2gxFijg5Jtb76nTh7ztJeWmm7fvUGfPw0DFk08GmJ+RS1OTU5WiWNVqtdKCjBy5gQnOE0I7QdABaHENAgW4/curNwwRAyPgGzLgJyHYG/+qTR/S3r17ad26ddQVH0/t7e00K/F5iouLo66uLjk9d1k6BYWYXUQNPLZRwfYSF9pIOlVVVfa0tDQT2s7OTsrMzJRKG/sjkY05Xj0ASkrlRXvs2DGaOHGiVB5GiY6Opm4RCD0BgmSgAKV1ZcvKyuxsFIub2ODvel49oLe3l5qbm6XLZ2dnU/Plc9QrPABGObLrU3L4oIkGHhvvoyMb+LshIz+fOOhQnvtsBCO/v32vBqguK6b4uFi60tImWyxwtbzENcCZOAz6u7zv/EjHNRUlhBQIz8K18H22Z87gNUJwVFSkcOUe4dqxNDPtNTp69CitWLGCfvx2t0vg6+q2iVQXIaVFR4bJegCBruDLElqw9A0qLS2lrKwsOiPmATCWm7HQpY5AauSaAu3BiirTjoL1do70fMrcSkHiTwRqELEbpF93V4v50f566jvJx3UC0iUyBgfN99Yss5vN42jr7u9NQVB6avxkqXxMtIWixEJQHq4Ow8DMnIejo8ziKjhyMmgRkZFyf3FJLxDuI5S/cv4H6R3xk2N576p2gNFUTZEwQ/Ihz0N5BshhZZj2seABzuubxbpMYx7jPCi846MNdnzu0iXSK9Z2BEGnMz2TmikjPoxgFfe8R3jFcLkcJ4zx5ORkKioqkkZ4btFyx56cdQJvEK0pJlF1OUViIwCkO77XHNygJFyf06yaLBDQ4F2g6fNgPD5p1Ar4AEwDzhUl1g5uuPcf5S/JoLt378q0huDW1NREjx45NoYJ3gBBMj8/X853XIMcihSnVC9qgZuXqyniqZk0PiSEpk2bRhcvCmnddVLkK6+vp/T0dKm42BRxxNfvN1wf0Cuui9VZcdp6eiQNnoCYYEyTMAKMqMvBBDYUcDZ4EDZ+7do1MpvNMs0h7YWHi9K2/S/wSdj2zXE6feEqvb8hl/JWZtKp2isEGsONGzfoVPFOmRJxDeBB+/fvp+nTp9OshRmUkJAgld+3bx/NmTOHkhdlUlJSErW1talNsdvDCEZ4IGiIFUx3976AssgQuvJQGHNAY+V1GuYE4eShbEtLCyHNtVw+T02//8xr0ZGzF6iyspI2FWyhgf5eMoWESRy0w5W1Dr77jbKFIerOnaDTJbto7dq1VF9frwzbI04tLy+PGhoaFA1G51PizXOaUxsQCIIV+twC3/zJHmUQ9BkwHzJZYd2wRhrGghuFsjHCXe43/uZy6hAYKYLgq3OfpdmzZ1PdrTsUFOrIALGT4iglJYWWzJshI7J6GDkNgbm15QdpaspLdPbwHsoWrm6z2ejPX8qInLEBxm5tbQWrAqPyzSL1GrXcvO0rReKroARoyHCG1Y1tQhpEnsdiaAGM8wZ2Fr6jiR5EN2/dJTsIhJzaQGCc05U+zmkQdxv3WnftQcmuGAKhkc8dzXWWbz1lTY3dpaq5dOmSGoIbp6amupujeGBQVk4RBcK02rq/FbnLGcyinekUA03/3BpWvmBx2Z8SJpKMhvuMen0L+CzJyYjT5lzPO9JpujxdcZ3uD36n4jN/2IfwjroBsAIrfmBHIR0Un06THecfeMBoGEGX6S8+6gbAvf+3+6GMA7wZvBi7e/rcvhz5GjCvL601NFSxTVr6gcJHguCwhtwpPHkBeAky9PX1MeqxFYHJZex0raPgWTJ/pqIjCIqApvoiZih8QGGDSInGO0h1j1nGjaPOwQKOHdE9s5MaBGWNH6o4fN6ADWXkw50H3Ko+Lj/gqNo8Ad4jgCmixQe35FYO+PhHU97HGURun8O1J74mc1gozVq8RpbIkBYWFqaERkQ46gFFcIPACFNezJIjqxfPlw8iT3kbdUinuDYMyBg+HR9PCKAdYgCc/Lzlb0uRskr0UzhHfF0hiMArEq+ybufPaCwWyjLoSuOxgzpkrMHFABdOFlGEOVyd/kgX5+czz6+o+YNyFjs8SL//PM4tlO5w8xbg8bFoXbLA3GX58vRtff30U/EXHtfjGGGME8Mp98CQGTwKf8ID0gNYEVR6+PgKDLcXPDfdvdzczYHMh+ITrzh3wy55CF6ANDo0N7mfGig1qL+/X/7UjZ+7gcMYl88cGlYueBsbG+U8IyPX/6Dfri5Vn5FP73d0dcp3gU57UngwfgswAn5uqKmpoevXrxuHZD8xcfCXnXjxvwIj4P2O4oKzgHFc78NgKJ3Bj/uPFrSOrsF/ven8o40H48cLf8HbHGQA9VuBEM5XrKOjY8hSxaLQeVMUQ5wBkBJbRPS/LT6MjTXIIAiFdKV03NMGPPEgEOrXwNN8nc6K4vTvO7MA03S+scCD8QuNv+DvHARBb3DI6Qnge1LKY63/AXy81CtrVu9uAAAAAElFTkSuQmCC",
    ["wedding_dress"] = "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",
    ["hu_tao_wqtermelcn_4febbfc99fc9fdf4"] = "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",
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
