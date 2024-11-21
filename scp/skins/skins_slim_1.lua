local n_skins = 2 local texture_list_default = {}
local texture_list_slim = {
    [""] = "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",
    ["robin213"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAABrdJREFUaEPdWWtsFFUU/qasu3QLC4a2sCGoKGKRpC/lGWxCCT8sAoKGRomJsYh/lBCNwYYEQpVU4yNEE38Q0EQTpARpEINRQluxUOTVUkJoIlKiqa1tQVpoabe7O3Lu7JnevTs7M7U1Ys+fu/femTtzvvOd7547q8HBVmTn6nRJRvq96Oj8y2z5NnVc7X/T2KA5PeO/nHd8uZLCxTo5nps1HQ1NzWbr5DjP/+8B2LJmld7SeQNT0ydCbQkQcpSNGSL3RwUAKkVlIJzou7uq2pFlTmv8m/OOLyczgF9EBaC8/E20Xr4S957BGQ+itPR9jAoA5NwnLbACoKu9Fb3dtwUI/kAqJmQGRwcAqgiyuLEoUp8YQEYgkJHzZKOCAQwAO261/ZWvfx2YPiY+VZsjKN350d2fAk4Oyg7LHpLiq5Zsa0xWM9C4211C1iJKSbf3OQmoRgtb7e9McS6CrBZiEOS0IH0gk2sHNW3k9HEjkhQkeRvm9y3bV+ko4q4AsNrfWeycFmBH7WoFVThlZ5yckDWInyEHbLhMEAyw2t74JWluQ8kzljh8vPtrMS47ZLcWXaeaGwB2V1WL20oKF4tnle2rFP0V2bnDTgUBgBo92Qn6feTyVTF0qPwN0S4v/VC0S2c8kABAMiYke4YTAAB0cpRYxI4DEO8d6w8rDUwN4JJWzbWGG12oOPgdirYsx6n1bwmH5+58F4fLDqF45ZMCBKv8ZC1QGaIC4QQApQAzgByPBUewlhjhRkPs0lhTdwFZoLi23/xVBbJX5qF+c5lYK2/7FjQerMf254pNBvC5wOo8YLUma4dLACyjTCfVYWsAA8AoWe33dvu8fER2e0KUn+UUwZFw0pYB6uT8Ofl6d/ctMRwIjBOtP9Uv2t7bvTh5+pxtzhGgdg+8eLPLXE++jtYmc1o/qn9urh8Kh9B9bhounfhZ3DsxMwM5a18dkiYkXPzoIzPjHJgyOTPOn6pjtY4AyDsI38xjzeEBtP3ZbokRPctpfV3/UgfO3Smh8qGjDj/tyEBX2zWx3vzVRcicV3R3ALD//EWTQcSoZ3Nmi0PUyABg4KcjjM5Tk00GzFo4b/gAjFQKENVlmz1+gujyOKeVmgbuUuA0gDnoDR3D2U/vMxlwf3bW0FOAHLbLWdYDvoZ1gfvf17wIn9cnuh6PB6tzPhFfiepaWuIYsGDqVFEeHzj/GiKRMHQd6A/1i3u9Hi80eMzXoMi6MdKAZEZrkmkwiigr07QvNI0AkEWOLpT7BAA7zb/l+ZoTryAcPYlU7xNIwQWszKkWRcu2itWYnfW2EfWmZVi3pEH83nX0JURRh4FwjrjP7y2AhkaR05zbco5TpHmecp76gMEAakPhHHg955P2NZCgT7tTNfye0I4YABTJNH8axsCLdUs+E4URASDb1uIDQgMIACCKvoFeaFpKQvTVSBEbmB38W2YIscDnMXYpsv5wr1jTiD6x6og7ANLGpaHnVo+4kX6TUV9VbFJqvpa2LmJA960qjPUuwnj/FRFpVvxdR3NFZBmUQQBIxfPQE6q2ZQAxQUd2HAM0LBDqLzPA52kyGdQfzjIZYTCHdggbBhQWLNJlh90CwAAdPvqCyGUyymefJxVbiyulaMMCALpaR3/Y+IQmR3AoDGAN4IjTvfKYKwYsnJevj/UNFjr/VAM8KfOBlDPwpRRgkO4GAyiSW4uvYlsFHZ6ofwYRZKMvVAu6T46gqgVWDGCN6AlViftVDSBtSfMWxjTFgQEsgsSCjo4OBMYHkJrmRzQSESlANJdFT9OAYDCIvr4BXL/eKVKAIxBFVOiAvUWhI2pGitgT8A/+t2DFADmqdspv9Vyf57izBti9sNM2aABgqHB/5DjGjikAUG+h6nki8sBjdw7UZ0XbE6qJMeBi3DjPU9u4Z2bc69EXZ9noS7Q8pvZnPPWjPQB7d+7QH8p6WKz5a9MvopX73Te7EIgVMfxbnl/zslHgyEa1KBcXWuwEq5sjDgRRpi/s6QH9x0BG/z3wJ3fq86d4nlevoXlHAIqLliYUQsGgUf+3tlrX7PI7rnp6mQkYjdefpigDeXMeN0El4HjMCmSa42sIbAaYxid2tZmf2dXP7iMCwMaStQkApKdPEi/c2XktAQQGh0H4oZaKkuRGRZSaRkPhwMEPNuGPy7+B6nw+9fHhZ9aiPPFnjBUDLtXWY8KUSSjY2GyfAu9s2mBbChMIsjE4PPZtVW2cSN7j9WEgti3Kx2pZSNXKk9ZSzwZ8PH7v+eWi1idnySk68cnHXzkl5LS40d4hQMuYuzcp3lQJ/g0BveJdEfzUfwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    ["lo_fi_18328111"] = "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",
    ["robin_cerulean"] = "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",
    ["holly_jolly_christmas_d"] = "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",
    ["fluffy_th_mariiposa"] = "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",
    ["kinda_christmas_4"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAGrUlEQVRoBd1Za2xURRQ+i6uUYlsK5VEqWli0KZIglOwPoFCgogi1BIwgoYgVEgkCikhMQRETCCHIM0QjBR810BolgSrUBNRQidoIhIRgCLRVsVagT5CColnvN5czzs6du3vTdg1xkt3z/u6cmXPPzLY+ijLeWjI7lD16otGr8tgRuvr3/ZSSdBc1tP4pKByZB12xY43PGOxRiecv3LbHiBHJ5hGejMBq8OmyXaHqC9eEqrHpqqC9eiYIGhjQnQ4e/ZkyBvYi2FjP/Nnaxg4vgDqXWPBdooFil5FocHhfsbPYVfDQwRbrgV12e0Ykm1uMrvdUAVWnfhNxSB4DJY/d/j9UgF9kFOVr8sTBwqPq5EVCWbPc2PC7jJy38FHJgykvOxYm366CpwU4dOS8mD9XAGSuABjyFk915Afd2WXvO/S3m8LTK9Ar5W4xb66AgulDhIwKGDLqIaI+yea8LjVTlwFZUZ9hDv5vtFErQH//Ma2SfWfkkTdklHOiPl8chUI3nIbbUONDJ8U5j46un/ecPObN5c85oBHyCA7rx6ygjMWnhI7LzmzHOd8ZZzrjMhafEpHuEeIY5IkAADyf+wzohSJGx1HjYOdXScfniar+Or+7aG0In/0bt7kei2qMF0z4d8FNDjt0oaGZ9uz/mKbl54tLDYzYdd557Lj60e24/CAWGMACJrDxwZCXKKufMA8bdgcfxBTNnmxMDokDA403mNWX6r8sC+GCBp0+gAEsxnXbfcTBJnoAJt0jOUgtzVWExoakebfg+PTksSCO8WbpYaGDL2L4WAQWY8JBt+v48Fm355DPbQEK160UjRS7X3X8ItzFHUQwhi9gGdRGlViA2flPiCst6PaSDyhwX45MBlHPbyoWwTtKVwu6aNYaQQf2TxeUE0fs4oK5EgvXZAy2q6XPOuFw60ufOJd7/vIlIiGmcIcNlQA+dfxMmbCOAXukIXoATwz0sZwZ9NKsXMrs/4CMGzsuR/LMqDr4IgaxKhb7so5lUJNOtUfj1cWI5hvJLiqA30mmvmAakXWG85g0dzr5A/dK3YTCuTRh9Eja9eom4eJLjxd3gcZDRzlEvudQMC5TVScDDEy0JNWdN4R7Uvk2LFptbCbLX3lcAnxWtIWmFNtlL5VglEXauP5AmEkV0Dy5mbKedV5+LpcXFITySkpkmTNGZ1AH6Jwpk+SCtN34gz7Zt1c+5/BXNfRw/hhHjHSwmPlPFYbSUnqqKsnXNTSRm42d1mzfGBF/S9FroearbQSsd95bZYdZG2HdOBkiYjw7MY16E2THzqQLnnnOCLfz3beNel2ZnBAvFkDXt0eOyQKMyZ0m5jKhp11MXzTZm1JWurs9c4xpTEwWgGcsmiOEpuusirhzKGsvA69AZw2f+s7roOgBphEf11Wq4xLvkTwzM2cVCnbiiG6CHjlhL4BbBbj1BSzI0IFOfO4B/DyVAguvyAvr3mB1xJ7gT+j6748ajmB6ueUKs2G0b5L9N0Eob4ZZbCE3ZxDVVbfRr5dtOXNAEqUF4qms1OBsqTBh0+CK8D+5gP76aKd0eb1fMuWdOy1lldk5NEBbr5k3TvVjPmavwLOL5/AzBK04uC9MVoVAah+qrr+kqgi607W/0Pc1Z4nWL6eRgzJs3vLKa2mlfsn9w/xZyKuspB49kliMSmO2ABVffxP+8Cv14bJHCYljLO3elbZa/NKVibR17RWxOCaI3BFB4fNhaZnJ7NB1eAGM729iquNBZOmMvk5PqVH9uayRPKqixaoC07gRumYtkL1oJruu6/AC6IDtkfXyBwbrkKxa/kgcuzxofhodWPmd43FomodPVDn0bgp/cMUMSt38ubDXv/iIoJDBj9vwqTHu+oqpIgY+rQdqjT51J6ulHg0QFeDW7KSjxsB/ZEKGSLZ5c5uIF6+C1eSObz7nWlHl2dnkq6jQ0Myi//xP5+mHevv8vdPiMbrdtHv7iQb7P0F6aKalaLF8ENub7tDNQk4bHjDq26OsKa6Ti8evQiQcLz4c7x98xrpUjH/QlsFbA4ljMfwZ5r/2IvGblk+m5X+stlWe1dEuKGznSkCXxzCd9dDD7mZjDPh1ZDh6wO7KU5SXlU70bT2VV1+m7EBvB36SZaMs5wVFOqLj642wnacAL5LEvsW4LYybvx7PsmMBCrOHCVtKTQO1GJKHsXdi+DnLO8sXFwbXqZsd8fqOMqb8xaeDKT/Fw0y3/kdRvNfb7w7/vGUvh8WrQpz189c0cNPj8eOqTcxKilug1cel7MaoxxwnrPqqdlXfmfw/dAb26KVDHuIAAAAASUVORK5CYII=",
    ["tnt_lover_18292693"] = "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",
    ["bunny_slippers"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAJhJREFUaEPtmDEOgCAMRcvAafUMDp5BT8uAwYSE4NA40v9cWFj6+n4Bk4l/Sbx+AwAGiBMgAuICMASJABEQJ0AExAXgFCACRMAhUEup45aUcyhr3GIAgAHiEYg+JN0ZAIDgBDAgeIPd8jDARRR8AwbMDW5X33bf72twAb7/A+QAzI+dvx1f/XX4qj4WfeybnddtffWArA7gATb3LiG1F6T3AAAAAElFTkSuQmCC",
    ["endergirl_06b1970b248d1e43"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEYElEQVRoBdVY3UtUQRSf1V1NUdwyi8BKKV/sJTGyqESSIDCJHrIHoUf7D/oj+hN8N6geIkzwxQifMpKC8CnDPgyq7WNlxU3Xj/zNeoa5c8/MvXe9N+zC3Zn5nXN+c87cM3Pu3ZQIuJoyx7YCVJzipdKnlFMhQEjzV1dnPJobGyXP2DYImj9tM9Tx2pp6faj6q2srqp9kB8GnjQXAfGEXweVblUu4F2S24LEgZlZU4u+eX4BKgopiE2oLhCHM51941LLZc55x0gNzr9PZETTvrjNgoLlTmMFjUmCQJX0hcDN4zGnDTX92vQAmYdxjHHTrzIkP7J8dgjjtuTvuYG18tAgImm49+O76bl+p5jCOPxV2r3DGcWLmia4HiHmSkstDMKjOD7ScYmOdyM1JPMg+SG4rdR+n3kj+D49nRNuNHtHaV/Zj8fmcIAwKx/tPO98TbPxYZJkBnINIeVvg0ivtBwth44AaJwOOOWzOQU5738wGyHBRVnAvSZCTvUvOlkE4dqu1SyyvroFHjL28J1vzZ/jsXQlB98Hia2ugpl2U8a8/71Mj7de3louroqGuVppSf3ThSerAvhO+/R+F31oFEHxhrXx3tZ8XuOmiMclpoUgeR4und6GhTQwe7JfB3/86qb4p0MciQAYdetKVzMtmAIgQ3OelGck5NvpQTD96qvjvXLktem9eE8MjQxI72tSjZHF0EBCefKH2iHy64z+mZPB44sSPRehruijl0EUm2FKdbLjWtwBI/5OZFlEorSr9zqH+cn9/s2wRvMRGyjB0YTO/lou8DWh/k/MInrBCqah84Dq6nGw4HtgSTjw0D1sGEYx+vcqN60PVP9MyqProzJdynnGUAR1oCMR8s0NNn12ZVU8fvByGkq7z6PMTThgtmIcUwq3Ft1vZ9gHS87SlzaJY2cj5bHSlMO8VcMb2RMzgdW706dBDAFRdkLVBdiYPjX1bgASVtmb2mDy7yRKTC+Nv35+J3Xx4WasAN1lUDFvHtn2iciWln+gC2Jy+mu3wiTjMp8QAhw9dZtDwUIr2fH5hQlnZzgClsNOBDXRtaU9P3zwsiSfMdjAPL7KlQ4zG1JI+SiNhrjYtdkqbare11ff975+8LdnsSCkQWojGTN12GS2K5uZLUqO9KisIA0D6O+a+V1p6sUGQ5mEJG5KTvdlyNqYOjRPZAo2ZWrGwmZfOwxn0gbku3Wm9z9m45C4Zy0UnKLW6Esoed2Wq6jhYYY1pb5mDU8BsF+c0MFua23gqwdO2IEG2sVn+GHIR64uBNHddSh7uL30XVWyytB6AyWpbAJsNpbn8ait42YA1rvsjp0PLq10euWScfiWY80WouqqmEs7/ysa5AFEjce1zcAXJo84Xh34iVSAOx1wcrjLoknGcsWZAgfY4UzzwB4aSc55EwFwVgqsoLupEMmAy/843J4dByVXqXDLfBBUCsWbA9FI58N6mDjFT/OJxCX9dkdwj2B4gbc0nFzWVTc6w478s2+6BLq4SbgAAAABJRU5ErkJggg==",
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
