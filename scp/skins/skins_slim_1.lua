local n_skins = 2 local texture_list_default = {}
local texture_list_slim = {
    [""] = "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",
    ["bunny_slippers"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAJhJREFUaEPtmDEOgCAMRcvAafUMDp5BT8uAwYSE4NA40v9cWFj6+n4Bk4l/Sbx+AwAGiBMgAuICMASJABEQJ0AExAXgFCACRMAhUEup45aUcyhr3GIAgAHiEYg+JN0ZAIDgBDAgeIPd8jDARRR8AwbMDW5X33bf72twAb7/A+QAzI+dvx1f/XX4qj4WfeybnddtffWArA7gATb3LiG1F6T3AAAAAElFTkSuQmCC",
    ["dehu_scarf_5faf56683e38a907"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAGuklEQVRoBc1YXWhcRRSexL2bzSYxMf2JbSoFFbRIBfG5pfbJH1CrwZ+K//GnVChYgq2lFiz+kYr0QavSKhpoX/JQUVGkFGl8EMQXQXxRaTW1bA1plt3sbnK3rPPN3e/m7GTu3ZumxB6YO2fO38w5c+65M7dFNYGhxwdqcSLjZ88rL51S/mzV9JAljv7YyVMtcfrNeHL+4ZFRY8umPXHn5trn355smMdFc83V6iLatGJhWuX+nWxooAHgfBTE8aJ0XHTOTx7WwvmjHEVAwKNOVJ8oANOVGbOr2FE20AAc2xNE0W25JGPMJXcYOOeXdNtWHI+y0dtHCd13ZNoU9htOAbCzoBE3iHhcrp2HSaa9MG/QJM7ZOq5xogAwA2gAgUBAOrs6SFKHPzka4kAGn9naML5SB4leAey23FWZAQgGnPe6uxsaaMyYK9V5rCtRAJwZUK8BXR3tkf7JoEUK/c+MRAHoW9Gr1vSvbGigAQrT5UgXlioDHt28cV61d9FcC22R31SXwFLSogreQtcQ5RPtS74pgpm2tKrMzCr0AOLok0Az/aT8uLmwaLk+OhOlwznBlzjlSUv0ClDpUvvs1Kzq1W8KeonT3v7DRxtOcaSz3zu4NUzxTDr4/Eoa5WQvbXJO8rkWjFM4UTGyFGDP0xbG77z2Bsmmf+X1PeG4mX5vKvhclnqCDMOCANJ+3I7C6YmJC+E6odfT1RXObyO0RfvDx79pCPDu0eBIve3+u2qtqPBIdQpzYaCBh/Z3oay2Dr0czgMcNPKb6U86PhSgQf+QtThOgpTHURZtqlBokIMOaOTLd5r66CGH5uKDBl4rKjWcx2LgCB0H7VyxbNpzOwalXYODRn6UPmzTPpRoHzh0wIuq1uATuKMyrUmjLcrKHrbRpC3yQQMvrAFcKBdGQfR3bLpXDTz1oOq6aZ1pwEGTEKcPuV8mzxunYR+4BKSiHBOHTTQJez74NExnF5+y0iZ2mnT2pJmvAHYfwJ748rRn6JliST35wFwWAPfzeUU+9dhT3yjrB+nsJR/XZdetjQuELHbKvla7aJAlYC7qwL59dyBtXmQObH+slslkVKVSUeh//fMcbarZalUd+fK7eTqhgEbeGhioZbVeSevny0XV3d6p5HjNzf0ql3cfnvq629VL7x6Jtf/RrhdNtvi+rzzPU9lsVpVKJfXC2x/G6sk1StxkgCTYOJzuaA+qGPBmAGcBdi/1nt25wwx9v3679IJlfHX4YynWFIfzi4XIAPxw4WrV1p5Vvam5DFjIZMiAXZ+NGJXdD20xmbAQ/aWSDYugnHBsqkcOFdINLQnA8Tg4cz4fyY7juZSQ+ouFFrzztpGfKteqmXLJZIDN29AzFdYH1Ak/NxOmO53nO29nAGqCC+w6Ice9Ny53qURuCOoCIGlNSOVbu+dNAOers+57wIlyWvP0ETKdVuuX6f8EF8d1wQtM+BcDHYwRBKQ+gA4xAFmtCyhZc8i6gWDSnhFexIOF2cyp7XKDcCJ01oD1y1BQ2/Q32J32Xv08DoO/5afUuu7glQEOwBhBWHXN3O5lUilFx72rggCcKdfldUAYNGNAP+A87PWp1SRdcg9HZRBg6NZHDo6p0VGVytRTxmU9KgBSBz89squDc7lXT/FCZ1rt3L9PVXQmHds7HL4icg6vT2dPMYj/uZqvpotF1VENLjrTE5Pmn+Pl+KHC7z3P/1jD16NnT90z0L8RPGcR5HskF2zjcTLycvT0gX3mTAB97Dx337a30DHqj6u57PBUiB4NzpPmfAU8na7Nqn4SmeA7H1TqijhDYPcl8Ocqe/CA8+TItTDoHEsbxMGjHGgPD46Mff/Fjg3YdT0cA+3Q8X5jH6dNZwD8+mK9+lEYSjZQhr/HwZc4xp4+4GT0WSIKbHlbDnwcdn4+M6HWrcgaHDL4/GH3XQDn5QEJu83bIAJh67gDkOCbH7cLnIQZgIKGIvdXNbjh3aALrAS+MuzBA85b3O1r54opeNJBjCXYPKQ6bo6b7jt4ivbrNaAFPGcNkAab4UhV3BnQgMs0ZgY8/17wM4X8KHl7Ltr68Y+czUo8hg3X3yPQwHMGIDd+WqEtFnjWh53FfNNvuy74A73Y9VAfrwXxFBy1CweLyD+nf6dcQ8/LEYhtbcHJq0GgPkAGEPxlnUrF/GRlekJe4rlcTnXp31+lqq8K+i+Q4etsi6oB8EXykP7YbThtZwJ4Ldu23F3DLS+tK78NUbc/KXvL9atCNZ7lt786ZGjMAAbi/TeHDX3tysbTZ9z1WBY1nv3xnhMPJ68j5NlHYdt5/l36D68BEOVutO4oAAAAAElFTkSuQmCC",
    ["endergirl_06b1970b248d1e43"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAEYElEQVRoBdVY3UtUQRSf1V1NUdwyi8BKKV/sJTGyqESSIDCJHrIHoUf7D/oj+hN8N6geIkzwxQifMpKC8CnDPgyq7WNlxU3Xj/zNeoa5c8/MvXe9N+zC3Zn5nXN+c87cM3Pu3ZQIuJoyx7YCVJzipdKnlFMhQEjzV1dnPJobGyXP2DYImj9tM9Tx2pp6faj6q2srqp9kB8GnjQXAfGEXweVblUu4F2S24LEgZlZU4u+eX4BKgopiE2oLhCHM51941LLZc55x0gNzr9PZETTvrjNgoLlTmMFjUmCQJX0hcDN4zGnDTX92vQAmYdxjHHTrzIkP7J8dgjjtuTvuYG18tAgImm49+O76bl+p5jCOPxV2r3DGcWLmia4HiHmSkstDMKjOD7ScYmOdyM1JPMg+SG4rdR+n3kj+D49nRNuNHtHaV/Zj8fmcIAwKx/tPO98TbPxYZJkBnINIeVvg0ivtBwth44AaJwOOOWzOQU5738wGyHBRVnAvSZCTvUvOlkE4dqu1SyyvroFHjL28J1vzZ/jsXQlB98Hia2ugpl2U8a8/71Mj7de3louroqGuVppSf3ThSerAvhO+/R+F31oFEHxhrXx3tZ8XuOmiMclpoUgeR4und6GhTQwe7JfB3/86qb4p0MciQAYdetKVzMtmAIgQ3OelGck5NvpQTD96qvjvXLktem9eE8MjQxI72tSjZHF0EBCefKH2iHy64z+mZPB44sSPRehruijl0EUm2FKdbLjWtwBI/5OZFlEorSr9zqH+cn9/s2wRvMRGyjB0YTO/lou8DWh/k/MInrBCqah84Dq6nGw4HtgSTjw0D1sGEYx+vcqN60PVP9MyqProzJdynnGUAR1oCMR8s0NNn12ZVU8fvByGkq7z6PMTThgtmIcUwq3Ft1vZ9gHS87SlzaJY2cj5bHSlMO8VcMb2RMzgdW706dBDAFRdkLVBdiYPjX1bgASVtmb2mDy7yRKTC+Nv35+J3Xx4WasAN1lUDFvHtn2iciWln+gC2Jy+mu3wiTjMp8QAhw9dZtDwUIr2fH5hQlnZzgClsNOBDXRtaU9P3zwsiSfMdjAPL7KlQ4zG1JI+SiNhrjYtdkqbare11ff975+8LdnsSCkQWojGTN12GS2K5uZLUqO9KisIA0D6O+a+V1p6sUGQ5mEJG5KTvdlyNqYOjRPZAo2ZWrGwmZfOwxn0gbku3Wm9z9m45C4Zy0UnKLW6Esoed2Wq6jhYYY1pb5mDU8BsF+c0MFua23gqwdO2IEG2sVn+GHIR64uBNHddSh7uL30XVWyytB6AyWpbAJsNpbn8ait42YA1rvsjp0PLq10euWScfiWY80WouqqmEs7/ysa5AFEjce1zcAXJo84Xh34iVSAOx1wcrjLoknGcsWZAgfY4UzzwB4aSc55EwFwVgqsoLupEMmAy/843J4dByVXqXDLfBBUCsWbA9FI58N6mDjFT/OJxCX9dkdwj2B4gbc0nFzWVTc6w478s2+6BLq4SbgAAAABJRU5ErkJggg==",
    ["adwrable_barbie_aca42161fdceca16"] = "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",
    ["christmas_aesthetic_girl"] = "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",
    ["christmas_snow_girl"] = "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",
    ["christmas_valkyra_f"] = "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",
    ["egg_girl"] = "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",
    ["basically_me_abandoned23232"] = "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",
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
