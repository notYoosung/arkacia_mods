local n_skins = 45 local texture_list_slim = {}
local texture_list_default = {
    ["scp_049"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAfJJREFUaEPtmLFug0AMhs2SlAmJLqTMPEKeo1kzhkysnTsmG+rKlowRW/o8zJFYelImmimVT0KC64E5LiStOBZEzrZ8X/yfDRYQl+u6V8qmbZ0xZun4D+1LJocAnqbTxjy+LxdoWsc1A8BUwAgkwBiTSsR13XFIwAAwFfCPJaDb53X79KPbpNWlz7dpvO+MgOD+wpzQGUBRFLU/27ZtwFN+FABOp5O00n3fHweA7J3B8xtAnucchOd58PUBEGxGUgEGQJZJJRAEwd0kkOf51XEcnsf5fMYqJF/kunQofghShlkLAMqXWldpg0VR8Fxt277J5jHWr0AUECphyl8HSAkAD9/yiuO4FjIMQyU4UgBla8M+jVf1uQuAtu8D1XgijC5zQXVuQXsEsFwueajD4QAGwC0qQOcT15ASwLzE+NoS0E2Y0vSj1ynJ1kZhmebFM6DtuZzvZToXY5dgmn6XxeqTnwFAfJM0FSC2FZWSl5WvaqkbCQizRvXQ7KN51bnFSOAWbbA6+Q0hAZ1WSnaBKIrIl6G2BNI01cmP9BUHHdJBMKBGY3wX6A1gOplAuF6r5qRkP5/PYbVacZ/9fs/vKs+DAsBkXmYz6YZeFwv4PB6hvCvtumK82W6VNiwCGhwAtbEoiiBJEsqscX232/X2RUcKwA8W5lw/M+OKYwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    ["scp_173_8271915"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAADR0lEQVRoBd0XO4gTUXA2Bo2XhEuOwwML5RrhmmBnYXO9WBxoZy/YKQciKCIIghxoJR5W2lpYCVceghyHjQRBsBHE5g7J58KZpDHuvHV2Z19m9+0mm92NDzZv3vzezHvzZiYWGMb+7pPRoN8WuUqn6wofRr+0fs8ShXOCLJrsQOeGg04om4keKpwxsZDx/plvP/EBjEZ/Mjc+CQMmPoAkNs+DDmMOaDabUFssibZ2uj+h0WiItHlBGg8AHQxKcufO1+bFz0A7jQdApU7SEEZDfhNd0pk2zpLqPIY93jw5QHV+9PaXss+6vqxmTicZ7gCnczzBSM+6TyjyOv/73QBK9TrU1kq+sHefQKvl2D7wBw7SMU/0d4YwaLdhYcOfM1x58pzmHLRIviqAhhfW+2Seml+d+AZfz64CvD708Db8pnwIn5ecTpAIKKs7TzRxHonYVJFFKctblnc19ZNL8Km7D2u2WS8LBahUKnDj6AgIfxEuuAYfHLBDsrGd7g9FC64iDt1VkAFQDMvyaM+1/jIMt53Q7/V6gB+Uy3D1eQtO3fScX1k5M2Y+VYmgJ+DQd8bk0kT4noC08d1HH9TNY7Ru2o7jhwOjAWnzPowHgA7ireOj2Lad3jo+Vj6rSFBQtB9snd0P8tNGi2WQXOJljEog0bAUcjrh+RyFnnUZ9LLdP8t5X6A7gGuTwVyeHwbCpK/b/g6373+EarWqWDCanj2+DIv11Vj6SR/1KVHs023yF3SbyvsCYg5KYkTnsyTP6QSjw/ogR3Q8X0v649jHdSEcKQfoQv/TeiwCKKzQSQ5La+kgdBnOE0abRL+uT1/zvYNgXxIkBRSK0671TU36jPwLdudp1+M49plylu+/ABmgv6lp16SXZpM+4qPZxG+ikx5pzlUOoD5BMnRWuNwcADr/8OkX9SGc1hhLgmltLO0Tt7uUdMTF5SYC7jzYU40RNkcIpzVyEwHoOHWGaTmP+6RyAPimLcsLNumN8/Dn8KwPw7Nqhjtx53EbXHMc/S+gKMAZcWmMyBEg3VpSBnLHk9IZVY86AD1EJWF+YxJ9Gpwe8rjWcdPoD5MtUnuKTBxOYq1vHKT/xdYVuLX53mVH5xEXxE+Mcekkx+e/plWE7JxJB6sAAAAASUVORK5CYII=",
    ["scp_guard"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAC/0lEQVRoBe1YO49SQRQe5LGFQSjADQQCLaGwoaH3H1hR2FnY2GpjaasFjT/Agspu41+wtiAkVpIQKCAskYSwEIJzrs7kzDAz98zlkmXXvQ3n8Z3nzJyZkGDh3z4c4kQknFqCslAoGHOYzWZH+35EiH+rEFvxkJRLR0367BtALSQq7qEBUTt3X+wedsB9WcmodZz9DnBddS4dtSEpDjTescIBv2oEGemXJ+n0z50mbNcZtcAwe5ceHhLOBKEBPBFj8aAL+2y2wo7iQ2BP8RvagFMExT5xA4rFIlZFpqfTKdmW1ICrD2/Y6uaGJZMX7Pr3NatdPmXDXz/Zq89X5EA2IDQAF75YLALo1+/PvthsTPIX7R8vQZ7P56Wa0ghSA/b7v6fk2/vXLPPkMXv+9mMQJJEA8+O+RqPBBoNB4KhUKu19C9ejQyMmk0ngj/t2Hm+whSEY+h0U+u5TqA0VIIqn4n1wFN+kHeATNAL2+G0UIagwOft3gEj0VL8H3a/Vasq50QfJarU6sMHJwTnGvC8tzq/DTvFfqVSCaxqGKVy56/XamZ/u97/fAXe+AbDqYvXxm0JfaRt/5xtgK4wqh/OinCndkM8ERTQcDhU+TK+AOeOL1+11ns8cRcRniMI3m03J9/v9YD5wmayZ9A6QHgzEZrNh4/E40JTLZQNCFfniVev4uRRMefEUxRNfyGwhBbbVaklIJpORtI3AGEzb8MfKxapjP1gW7ABRDAbhxmA50Dq+Xq/rECfvg9djOR0blGEL6TwClODpdNoQ1i7yxds9xaMxNkB0jdKA7XbrlYkv3sv5P7BP/ikBNgUCXafTUVS9Xk/hYarDYIOPeqZ98UrAmJlgCOo+RVNMO6Db7SrwdrvNfLY1YH3wSrATMMYjYCrcFhtv6d1uZ4NJOX+r8z9WkpI/BeGTf0o8TPQHjp6YwOnyXC4nRdTCxBGQhrdIyB2AC8xms0FKy+XSKzVoxmg0ctoAZj6fOzFYWa1WMRs7LRuAPfsUTh182H8UG2wfJ/0HMHbxCsa+QjMAAAAASUVORK5CYII=",
    ["scp_overlord_vaz_mtf_epsilon_6_village_idiots"] = "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",
    ["skinTemplate"] = "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",
    ["winter_clothing_soviet_soldier_13784932"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAA+RJREFUaEPtWV1IVEEUPrek1VxXdFPMRFuCiBbMyKgVDIqkolCiUDJ8sKBc8CmKfiAiglKKHiJYCyooshIi1h5CjISMLHTJAsN6MWLTqFRc3NQsN84sc3e8P3N//FmtnZe5zj1z5pzvfOecO6sAGmNZHIR4Ih+eP+BqsBaUCVpnRPO9pnExAGIMiKWA4RowtsAClokxktqxGjDfi2BRviOUkLAYRkZ+gnTGCD+6UjOjXcBdUUgYmJqSDAODQ7LZc6dVs5DzDNTcjADwFMwGAFLnWXumDIBam1ud5zDUnt939hiSp8JffoNiEGjk9So1C4SgBsA6l5PQXs/A1PC1dekRlcmoAVBc6CTMi7dawb5kEfT/+AW73/SDLw4guHkp+RvH6PAwmRtbuzTZrGSgkJedIaP4996vkJaZYcghM3vwgJXOHNk5DU9eCywAPENYAEp3bOCmq24ANuZlyWQvnD4DJ8+d5YLyqtNvCDQUzs6xkz0YaXQGZwTAsCIAQACoDgqMVDddp+cpMkAKgMfbDocFAWrbHxMQJho74FooBO6S9ZPsNAsA6zwaaJbOyBqpLmogXWcBwWdNAC6dOAaJrlICwOWX4YvPkYIyAkCwrQGO1lwUQTADQFp6AtlPWyw+N3f0mGIA27KVGMSeQd8LVcX5qnmDzusZLAh65FmZusYOU84aPUdNXhUAvc5TxWZBiDoAUmTc5VtFRgwFgtDU9lEUCQQCMD4+zo3Yzk253EqcnZUu6kP9OJJtieKap/4pVz+1D/f2BePFfTabjTx7vV5DjJIJTxcAB6uqiUHBQIDM9+tvk3k6AQguDIOJgfkvAUAGoOMUAJxbWlqiy4DyXS6SAnvLK+cHA1jKS+sBzVHpOpuzn/3fxNfsuhoARqs3mzLsXj22obxWTRGmCoCSQ9Q4BOFG3VVRRM2ZFGukCLL6BofDRZJ3Bi84ugA4dahEtWp/6o1Elz1oeWakkisZiQ697Y7cDtesCt8s1RziAWAUHKn8+ev8riDMBAA0LajjW0oq4Zn31twEwOGQ/+CxryiXREyLAfea38F21wqRHGw9oM7roXRUGaAEAO2tvIJF+y4FQOo8jTrqmHcMoI5jX1UaSUlJIAjhdutyyn83wG4gjSrmP69yq8mznWVGuoAaA3gsoNFHGTYFqIHozD/NAD0AKDFnTnaBuc6Agv5RxTQcGAv/40U6Ui2WSUsVTS+4n8aC3W5X/Q5QqwEsA0q3rZUZMdXeTRUiY3qD8o8ktItnG7XP7/eDz+ebfQDQgT37q+Gmp5b4csB9HB7ejXwRqnUXpetxd9+fSRcerQLNBgdlta7HfwF58IMXWjwjwwAAAABJRU5ErkJggg==",
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
