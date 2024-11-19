local texture_list_default = {}
local texture_list_slim = {
    [""] = "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",
    ["mother_nature_tinypaykitten"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAG60lEQVRoBd1YbWjVVRh/7ry6V6fbvHcvzoRttqGTRmiCps7EyAIDs5IFoRgk5ScFoQ/2IT8EQUGRYBBIQWYmRkJaiToTtTdipdhCt/B1euc23Yu6lt7O7/z93Z17du69/7vdD9UD/3vOec7zPOc8r+ecG5AUsG3LS1GQNNRNl5bW89J84mdpnD9nxNglBrSfH2oJuOYyidt/8HW9R1vmk8veSLl20Gayx1AcAOVdAGMkAswpAySazhjej6KJFktpADBC+fa2c3Lh2g0tB/3/C2T5UQRRUFVdIw+UTtbk6AMYHXrwH/3xZQBbN0QAo4BtTm+7mB94OGfzpzNuvbrbmd+Q8d0v2xPO+V0jZQq4cp8RgDn0a3JVauQWW2sqnI6UZguf3rD91GlBkSsoqZBwRbHUlT0XYNHr77qSnjAHdUoDMMz3fnUorgbQCJRZmJ/Nrm57BwbjxqMdQHEoyo/KA7/o4fUpq3yqdVOmACMACrPiU3kYB2FuK49FgctECphKotpDcbQmPpWSyeYDxz/ZGpdHVBibh6I4y5MB7wSIEBqG9IwejCmXc5T/6tYP47yInEfYp+thpkm6hglyY9wQNk0cN0vPc8zWNM7Kp5aKbQRbDvmStWaOm3SbmhrjHPX2zuY4w4EWaQIDQobJm6yfMAVsbyYTAkXxkccV+sDxgyzS2nLpSRQ8ApQHvfnZBuFlKHKlm2y+2lgR5IZcXoOnn6gf3hAkf306vYUoP9mucKzBi6z2ppJMFTNlNzWJjgo7GtKJgqDpLYQxDWDiI7cnyMc/9cuLcwv0/tEXmSDh3L9ihc5UEH2T31baNU/lq2bX66PO5lk8/5Ho0RM/Bha8sCXAvmkgm96vEXQE4IqLWx5y2ATgoXxjRa9c7ohIZeljenpGoEWmloel+UqhyH1el8K8OkM214AARBRx2ChwDF1X/toehiHAYwPSACmEKEIRhVEZTaDlWlgDcyiYsRSgMHOjxDWuelma93wQO+6gvMa99ylJdOvijSNwDFDxCdi0CTSgiTP7rnnWAt4XYAwoSz6sx2gDTcAOI1MJ9lfNm0r+uHbPD5fjPEt6k8iF4zzm/DyXn13aELXpXDjKZQsFGRXEmS3mRoTS0dZTMWuBuCwwweSR2traETwmwZoNyzR/drH3cuTcYLf3kFq74R2inO3iutlJ5b+1c4WW39baIWtKHhTcOC9d65Z17x6mvKT8JGI7IgU48W9t60MNemswQCYg4T1gtMIHfu8UfN3Hh2RlznT9jVaWi+90Z0scGt4fC2TcAGPZjF9e0wiVpfH3E78ySBewc54Tftsd72/UpF3fHtRtzjQvRDHYuGKWztG9d84La4Amcvwkqhkz5+cKwx6K93WO09yRrksjpIRLKmVi6K7Gb27ax/mkNSGYW5TYgrd73OHl4il5fJnQCDjj+2sGZL/cEskXCedXSkS8DbsMAeWxeRNAD9pQeZ4UTKqQtpvNuh8qV3+0/Jb8qQ0ev5DRIggjaOge0jWgep3nDQ9ZKRfP4gY5EkzPDc96Rque9Ix+5FSXNGojcN5lyIvd/TIzlEsSX602QGH0uCbuDSzwxWQS2aELZVr3/Rn7/xDe6Oy4pUMzu+uGyWr0vSs2PUf6SJfI+GPHpGDhQm2EujNe+NdJnvRWeH1DiO4Wdqo/ZjptbOJx8O6uzSLPP+0x0xBH/pC7kVY51+4+amZWlcu4cJ2mYeiaOYkUMAGKpQpbmx5GoGwYoUrtsedMmybj2W/ysI+i6PqDhvM7jqyOrl2yK1YXgkPKugDexdEPL6lVv+p7czuGGha8tp5d6fnsS7lTG1Ik6jv2jcZjsy3bvpCCOSrpFeTNK1I5q7xxH7zipMLaUbxIk6gtUsrjCquNoNYeLUB5mzfId/fsvxdJ/rR8+b7jgDYG8KbSYISRgKfR0DcVqlg9V6qiNXqNgVDEXkuP6VVzEsZh+AMP76Paa9nqtqeVV69EGH6sYHofsrKqovOk9EK9jM/JloGLAzH55iMFiuM7+9HumBFouBiD0bk6RSWvA0xjOaYTovBIyoTyWMCOgqzr0fEymH9Shu4Myu3KyVJTtkIXHBBTcfShPICKF957VPDZAOXLrpfY6LjzG4YwP3gbXncBog0vOkadiyYdnB0BwayeA5JXMEWd2CeVnOVaVsMsL9/7+vpisktfWaL7Ufk1TnH7OMJRJDMUqb6wDCs1UZULVPVE4F1whulBB9k8BdCOFWzlIS94r2i53FJGQOsHAjcfEpmYnBLeRa7z1oYcx+PFNhal8JIkMnwZ8tLFO00yoTzXstug9nJQhbLhbZvIHpuRYc9hDEURCbwjwPOJlCc92mFDJKfHMYfjzn4IpToCsYYN/wAmP12qdZMY8wAAAABJRU5ErkJggg==",
    ["nature_girl_exoticblue"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAJDklEQVRoBd1YC1SUxxX+dkGQRxEWgQWqGHnZaMBYxZxo1FpUwGdO1WpCgpo2RkNMNB5PCzbSEyTo0WgV0dimatskKk2a1hON1bYRNT4bJGkSBUQhCBqEXbAUAeXv3Psz//67IgsGTm3unvnvdx9zZ+6dmf+xBjihnORExeTVG7UNN2EVjchXyFJXVduiRRgz1B+DR8Vh65YDmm71/sMGTbgPgauzOVGidyOy6QuQf64G+edsyd+t3/2kd1oA/crLidNOoEY74f+dnBaAVllud8cjQMnLHZC2aKZdLbK2/tFOvl8FY3dMzDF5itmerjvG6u4YTndAV46A0cOD59fa2Njd8+yxeE7v0G8vfFyh0fWFkE8B0k+fMgky8V7+3yEVWmpuMKdCeE19zukY7Pw/ujg9ApT43YhsdNYpcWoupr7cpPzatnfv1vWe9GmJP1So5TyZwItyT0EcOrmunByvuBjVRbrdaovr/vx4NG35O7s3vjwDk3xmY/3el/Hdf3zJulPDByD6yAUYRd/Xqs4jqq8J/3p+q114gwibnhRvC2pnVYXOvicUX21Udi6Ywp2M6L5NxTsgoI8rKPkQPzduD62aiTnDloKK0PBMPMaI5AMui9V+ZgOC18xDecJQZDyxBpcTYuG2+Ac8qYmDFzAO9FVvK0Ne+ZGWrtmk6ohTi8mYiXm/3afZ2wOUsNQTjjR7GJbl7YcitPFTh6GmoUnJfTJR2w21Qpb+neFa/Ff3ZynUSEF8z+ltjK0nLYqloZl1Wwu3KzTAi79eqtCbIWHLiVr22yxk6qv3pziy7+bkBI4h5YNps+z85WS1CQmFxDIpSpQSLtqdLtpKxtRP+kku/cmmx46y3t9ACdPqGT5rQPWA3tj9yQb4v30Mc994HzlH1sH/neOYnzIbLnTOxRknul17HZeCE/Hel7nwfPMwrE88xjvm0uYFsEwfC4rn8nkjrvV343ipY5dr8T8p34Wi67UgHcX/RVKagSZr8nI30MRopeWEz6x+mscziC0/ICZC4FZc+vQiJmXtsfMlJ8e++nh3i08+hr+mz1VOjXpIm9DI45+hpKwOEWF9ePCS8nr8pfArxgf25TBPnJrKfFpsP0T092F8ocyK6DBfDSesew9UEEXsWeuMcRjWPwWlm+axvai8DlH9Vd9JWbu1hGlC7NB2OZj2Y0UmHzUn086m92sP6wtCdkdZ9jFSspT0+tlJzMmwKGcDJjy7iAtByf/q0HZYA5q5j9InCGOWx+DN/DwuDCVOvqk5G2VMXLO0cPJkKyq3wvf9j7BzwVRhp2Oq4GrtLfYlmyTH5ElfLOZG8+tq8tRX7iTCRI6yqgWMlZZmHoQUNBg1pe4a28lGKxgVOBKBka48fVqGITEjENInim2ULJPoQwlTIyJONkpWJkorT42IdLIQrNBd6B6iEzsF76UPBTbQY7C9ETIyFyNjZS7fdVcuewqubc958qV7wC3xsrN6wx+EpED6yjh0p6ZHIBFhPScsbYQ78xikm+Ditw506QhQ7M7QHUHz8vLsClIdYkHdTXVV6xqtyJ6SdUcf/UDOnvtD5y9EZGQkiouLER0dzV0vXLig6WbNmtVh/NayfLv5ybGNYWMk7LC/dJLc6ZugdPy28h4tAH0R3u9fheorWg8tr/xI6qHw3RLW0FTwrt2ZogP055LWTgWfFmFEae8H7XzfWr5Ek9OXJjNWb5aqOnn9Zs1O4HdLUxHs74qqmlvMSScx8cxtr5Cqy9TZe0K7O2C6SEySXXWksgNOd32zSGhC+gaUCT+DuOU/9fojOJS5VDz2bH+g6kNEh/mJpKv1KvFSdadOOqy9eBorwuNY3FRZyDw55lnma/+UgezHEqWrU+7q4hegPd8dvVst9pOSdhdTgIQI9QvVMAFKftAAP4SGhqK+vp4LcOPGDUTxW6LtxUd2otU3BZmFWM1Jk56KQbpgfwt2NF1Cc2MTFvoOwoojHyCgXyB+OvIFrD6yHumDR+Priq85VJ7nLlwpqYCbRy+s/vwY6+TlzKaXlBFLNto9HaTOttTSuxu4Ir4sv9iRDh8fH35Zsh7cokX19vaGvklDsL8LJ60m7iLVmB46B3U19XjxgPrfwk/iUmH8tIG/PaggzY3NWJa0EtUV1QK3IGXUz7W+joCSpqbXG+m0k4a4xCTLJmCXaF7uXjt/KgKTOBspuXu4KKSTjbZ6ULj9LiJ/0tH3wuv7X0V9jRVLZmSL1XXD3pJduP6AB8KbzmDt2MlYODEDxsJ/Y/G45VjxeAZMpWpx1EHVa1B4iF5kLHXt3gPu8O6iIuzBUHj60rZWySwm4OvvJkU7rm5/iGRthYi6WsU+JrMZmXETcdF9BPxL/8Mr7Vd9Cm9c+z12FH2F8NgIzBeetbEjYbp+ivsQDm/DdgMJQSat13/jAri7u+vj4drhjSwruI0l219i/MtBUcwt+bkIild1+k6e5iBQspIIkw4XK1h1WCQ8KzZFTVKc5NkRAvuqCZODTN4Rc2dx6T95hd35J73UfeMCyEEk9zKr223V+SJ4+3izmjAVQdqkL/G+4SJRQYr4cdKEL6qf34HhwWyjGyB0q6pPmB06eZFJ692Nv7lyXpMJ6+VVV/4JapII/6zCJm+tsPWVPsRplQcPHIx1T6/Fsjbc3sqTr3dbwcy6+4DEXma1AOTXU2RovpyvnPnoY44/Ytyj/Hfj0X0fsjxq9PeZH9p/iPmEpAnMjx09w3zs9CR8UefLWH8JbSnE+ZsDERKi7obKykoM6l2KK71i9W4aDmk5p2E9qOw1FOXfq0LiFQ+kn/gQWY8mYJv1PJ6jHaGjtI9V2wchjZhc6YHs4pNIi18hPe7Y/tJA3HB85xqlINKPdQ8XW/hb9Wg/9ek45EQJ64/FmpiPLqzF32JMMHmo/xaNr1BQ6RXONv1l+PDhoC88/dce4bNnz+rdNNyRv//VAs2PgPyUvllfy/qCuIF4+HQpY3pynRwSinFljRj/QhbrxKXDArgWiuTlywBhpqZ6ZjJxVQmwTKO0UUGkCUGVUrJxevGRjbR6bPOyIWknTiRlwuOmJRCzW/l3elVhbot6PCaRMfIRyF1A3tmeJ0nbKfovgGU76kndY6AAAAAASUVORK5CYII=",
    ["poinsettia_skinmas"] = "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",
    ["bunny_slippers"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAJhJREFUaEPtmDEOgCAMRcvAafUMDp5BT8uAwYSE4NA40v9cWFj6+n4Bk4l/Sbx+AwAGiBMgAuICMASJABEQJ0AExAXgFCACRMAhUEup45aUcyhr3GIAgAHiEYg+JN0ZAIDgBDAgeIPd8jDARRR8AwbMDW5X33bf72twAb7/A+QAzI+dvx1f/XX4qj4WfeybnddtffWArA7gATb3LiG1F6T3AAAAAElFTkSuQmCC",
    ["pink_uniform_3ce30faa1ac401b2"] = "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",
    ["endergirl_06b1970b248d1e43"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEYElEQVRoBdVY3UtUQRSf1V1NUdwyi8BKKV/sJTGyqESSIDCJHrIHoUf7D/oj+hN8N6geIkzwxQifMpKC8CnDPgyq7WNlxU3Xj/zNeoa5c8/MvXe9N+zC3Zn5nXN+c87cM3Pu3ZQIuJoyx7YCVJzipdKnlFMhQEjzV1dnPJobGyXP2DYImj9tM9Tx2pp6faj6q2srqp9kB8GnjQXAfGEXweVblUu4F2S24LEgZlZU4u+eX4BKgopiE2oLhCHM51941LLZc55x0gNzr9PZETTvrjNgoLlTmMFjUmCQJX0hcDN4zGnDTX92vQAmYdxjHHTrzIkP7J8dgjjtuTvuYG18tAgImm49+O76bl+p5jCOPxV2r3DGcWLmia4HiHmSkstDMKjOD7ScYmOdyM1JPMg+SG4rdR+n3kj+D49nRNuNHtHaV/Zj8fmcIAwKx/tPO98TbPxYZJkBnINIeVvg0ivtBwth44AaJwOOOWzOQU5738wGyHBRVnAvSZCTvUvOlkE4dqu1SyyvroFHjL28J1vzZ/jsXQlB98Hia2ugpl2U8a8/71Mj7de3louroqGuVppSf3ThSerAvhO+/R+F31oFEHxhrXx3tZ8XuOmiMclpoUgeR4und6GhTQwe7JfB3/86qb4p0MciQAYdetKVzMtmAIgQ3OelGck5NvpQTD96qvjvXLktem9eE8MjQxI72tSjZHF0EBCefKH2iHy64z+mZPB44sSPRehruijl0EUm2FKdbLjWtwBI/5OZFlEorSr9zqH+cn9/s2wRvMRGyjB0YTO/lou8DWh/k/MInrBCqah84Dq6nGw4HtgSTjw0D1sGEYx+vcqN60PVP9MyqProzJdynnGUAR1oCMR8s0NNn12ZVU8fvByGkq7z6PMTThgtmIcUwq3Ft1vZ9gHS87SlzaJY2cj5bHSlMO8VcMb2RMzgdW706dBDAFRdkLVBdiYPjX1bgASVtmb2mDy7yRKTC+Nv35+J3Xx4WasAN1lUDFvHtn2iciWln+gC2Jy+mu3wiTjMp8QAhw9dZtDwUIr2fH5hQlnZzgClsNOBDXRtaU9P3zwsiSfMdjAPL7KlQ4zG1JI+SiNhrjYtdkqbare11ff975+8LdnsSCkQWojGTN12GS2K5uZLUqO9KisIA0D6O+a+V1p6sUGQ5mEJG5KTvdlyNqYOjRPZAo2ZWrGwmZfOwxn0gbku3Wm9z9m45C4Zy0UnKLW6Esoed2Wq6jhYYY1pb5mDU8BsF+c0MFua23gqwdO2IEG2sVn+GHIR64uBNHddSh7uL30XVWyytB6AyWpbAJsNpbn8ait42YA1rvsjp0PLq10euWScfiWY80WouqqmEs7/ysa5AFEjce1zcAXJo84Xh34iVSAOx1wcrjLoknGcsWZAgfY4UzzwB4aSc55EwFwVgqsoLupEMmAy/843J4dByVXqXDLfBBUCsWbA9FI58N6mDjFT/OJxCX9dkdwj2B4gbc0nFzWVTc6w478s2+6BLq4SbgAAAABJRU5ErkJggg==",
    ["basically_me_abandoned23232"] = "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",
    ["robin213"] = "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",
    ["egg_girl"] = "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",
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
