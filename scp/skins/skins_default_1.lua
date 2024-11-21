local n_skins = 35 local texture_list_slim = {}
local texture_list_default = {
    ["mtf_epsilon_11_nine_tailed_fox_support_var"] = "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",
    ["scp_overlord_vaz_mtf_epsilon_6_village_idiots"] = "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",
    ["crispy156_mouth"] = "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",
    ["scp_guard"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAC/0lEQVRoBe1YO49SQRQe5LGFQSjADQQCLaGwoaH3H1hR2FnY2GpjaasFjT/Agspu41+wtiAkVpIQKCAskYSwEIJzrs7kzDAz98zlkmXXvQ3n8Z3nzJyZkGDh3z4c4kQknFqCslAoGHOYzWZH+35EiH+rEFvxkJRLR0367BtALSQq7qEBUTt3X+wedsB9WcmodZz9DnBddS4dtSEpDjTescIBv2oEGemXJ+n0z50mbNcZtcAwe5ceHhLOBKEBPBFj8aAL+2y2wo7iQ2BP8RvagFMExT5xA4rFIlZFpqfTKdmW1ICrD2/Y6uaGJZMX7Pr3NatdPmXDXz/Zq89X5EA2IDQAF75YLALo1+/PvthsTPIX7R8vQZ7P56Wa0ghSA/b7v6fk2/vXLPPkMXv+9mMQJJEA8+O+RqPBBoNB4KhUKu19C9ejQyMmk0ngj/t2Hm+whSEY+h0U+u5TqA0VIIqn4n1wFN+kHeATNAL2+G0UIagwOft3gEj0VL8H3a/Vasq50QfJarU6sMHJwTnGvC8tzq/DTvFfqVSCaxqGKVy56/XamZ/u97/fAXe+AbDqYvXxm0JfaRt/5xtgK4wqh/OinCndkM8ERTQcDhU+TK+AOeOL1+11ns8cRcRniMI3m03J9/v9YD5wmayZ9A6QHgzEZrNh4/E40JTLZQNCFfniVev4uRRMefEUxRNfyGwhBbbVaklIJpORtI3AGEzb8MfKxapjP1gW7ABRDAbhxmA50Dq+Xq/rECfvg9djOR0blGEL6TwClODpdNoQ1i7yxds9xaMxNkB0jdKA7XbrlYkv3sv5P7BP/ikBNgUCXafTUVS9Xk/hYarDYIOPeqZ98UrAmJlgCOo+RVNMO6Db7SrwdrvNfLY1YH3wSrATMMYjYCrcFhtv6d1uZ4NJOX+r8z9WkpI/BeGTf0o8TPQHjp6YwOnyXC4nRdTCxBGQhrdIyB2AC8xms0FKy+XSKzVoxmg0ctoAZj6fOzFYWa1WMRs7LRuAPfsUTh182H8UG2wfJ/0HMHbxCsa+QjMAAAAASUVORK5CYII=",
    ["scp_173_8271915"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAADR0lEQVRoBd0XO4gTUXA2Bo2XhEuOwwML5RrhmmBnYXO9WBxoZy/YKQciKCIIghxoJR5W2lpYCVceghyHjQRBsBHE5g7J58KZpDHuvHV2Z19m9+0mm92NDzZv3vzezHvzZiYWGMb+7pPRoN8WuUqn6wofRr+0fs8ShXOCLJrsQOeGg04om4keKpwxsZDx/plvP/EBjEZ/Mjc+CQMmPoAkNs+DDmMOaDabUFssibZ2uj+h0WiItHlBGg8AHQxKcufO1+bFz0A7jQdApU7SEEZDfhNd0pk2zpLqPIY93jw5QHV+9PaXss+6vqxmTicZ7gCnczzBSM+6TyjyOv/73QBK9TrU1kq+sHefQKvl2D7wBw7SMU/0d4YwaLdhYcOfM1x58pzmHLRIviqAhhfW+2Seml+d+AZfz64CvD708Db8pnwIn5ecTpAIKKs7TzRxHonYVJFFKctblnc19ZNL8Km7D2u2WS8LBahUKnDj6AgIfxEuuAYfHLBDsrGd7g9FC64iDt1VkAFQDMvyaM+1/jIMt53Q7/V6gB+Uy3D1eQtO3fScX1k5M2Y+VYmgJ+DQd8bk0kT4noC08d1HH9TNY7Ru2o7jhwOjAWnzPowHgA7ireOj2Lad3jo+Vj6rSFBQtB9snd0P8tNGi2WQXOJljEog0bAUcjrh+RyFnnUZ9LLdP8t5X6A7gGuTwVyeHwbCpK/b/g6373+EarWqWDCanj2+DIv11Vj6SR/1KVHs023yF3SbyvsCYg5KYkTnsyTP6QSjw/ogR3Q8X0v649jHdSEcKQfoQv/TeiwCKKzQSQ5La+kgdBnOE0abRL+uT1/zvYNgXxIkBRSK0671TU36jPwLdudp1+M49plylu+/ABmgv6lp16SXZpM+4qPZxG+ikx5pzlUOoD5BMnRWuNwcADr/8OkX9SGc1hhLgmltLO0Tt7uUdMTF5SYC7jzYU40RNkcIpzVyEwHoOHWGaTmP+6RyAPimLcsLNumN8/Dn8KwPw7Nqhjtx53EbXHMc/S+gKMAZcWmMyBEg3VpSBnLHk9IZVY86AD1EJWF+YxJ9Gpwe8rjWcdPoD5MtUnuKTBxOYq1vHKT/xdYVuLX53mVH5xEXxE+Mcekkx+e/plWE7JxJB6sAAAAASUVORK5CYII=",
    ["reindeer_boy_18324574"] = "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",
    ["christmas_snow_boy"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAFHklEQVRoBd1ZTWhcVRQ+L76a6uSvSWbaTOikFaWNkiq2qMlCCaXQRTaCpSsXMl1bNy7c6LIrQaSILkRQN6IILqy4ULFogqDgDxLFoGaGpDWpjpmfkLF2nu/cN9+bO/e9d+97yYROffDmnHv+7jnnnnvufYlFhuebwqpzYGgwVOrq3xtUrZR9Xl//gMBl2mP3HbV8gS5EeuL4tK/vTiHGUMahi8A5UUgWaJDpVhgrAew8rzY/d7jrCVwQ3B8OWg6YcSQCMt0KYycgTgBcHdl+r1riyHeDjG1ygvdzqRrsAaXqptj/j+bSroktyu7rJar9Jcw9yDjTBM80w83lGxMgu8dBl2TC/wCPtQXUbs9VofaBWzUXsSoAx5ocNGi3auDw2zKd89zN506eps1qhT796kvo+ZCTEtXxkTAd/3guG/uesFKuOZh4fCAVWw86YVBsAflsl3EoHD39OI1On8IwAGUdGYegTJNx8ONCTiiSutlw/GTE1Q+T83sADKvn/MyxKZp/6yL9+tHbdOLI3bRULPpOyAaj9CFj4kNOhlydE4fuEu/Y2Jgz9/BxcfKwLW7IzOdX1kmKG3vA+5e/8K+7BzeuELlv0Z1lyW2E8uUn6cRx5LnPvPnhJTEP43ytdl/6/MefnKuugU70IZuN6M55dvTCSy8Lf1956oyAGD/3zNNibNI38YURzY/aJ/B9wYnQqMVitVVA1Dn/yHiG5ufn6fDUMWG0sXyBZmZmAhNE6UPQxIccIALFWIUmviofNhYJ4D0lyqn51cc4lxie88+/QPe+9y5deW2EMpkMnTt3kU49cYa+X/xZiJj0TXzMY4J/vpp2Bo/MkT37RkdOAJ7PkssIexp7y7vmmtwiulxYF0KqvqoZxu/EKqrzJBkHMrmyUXeyA7f7Nq5t1qm31xvX6/9QOrU3oOMLuwjry2MVX1/7g9KZ/SpZjJn3wD05rX3HfaD83VJR2GK92YfuF+RSqaTVhy6gfwyCoEIEz3QZV+VuxhiJBNyOD8YEbMcodLiS5GoCvZugMQFc9nhkHDQtrLqfx/zu0sOlzw/gdqaxwvZs3FVbLbeSEzZ5tqcqyKuNvjB2LFqUL1FzQ354eFjYN/UEOzx74U1K9Zh1w/YfnMjnn6XFxUVxh2Bdk9Oq/Sh5VW4nY/v1T74O1b+28jsVVtyrb8iTGx+j0fFDgpM/eSJEwksgB7+wsOAHHp5sVt8f6BUcvCcfvhg6WwGHBt/xTo6Ns60ToklruwlCURc8yyAxnARdBXxw6WOqb7l/GvOP1fBgWnx4QE2dYGJaEvFtTeQytPzDrEUcNCehCSemPnPsrVpF2Nyb6vdtY3URqM9oIlwBfUMjBF2Vz6vHQaWH2KZnV1fOOp5qe0djN3gOWiSjacivgKhgdjKhZVk0PT3t94AoW2EVwLK7kZjlwlqbG/aL55+k/tu8rVG54W2VJONK7XqbQR4gIA5+cnJS8Jm2GwEFJjcR5D7gytq/FYqUSqWEWq1WEzDJ2LnR6iutub39iR6AwHWNC0mDDdbpVBNUVx1zMN0q/9twkqw4K8vyugrARIBIBMaAavCgs7yOBzkZQj72PWCnFTA6ckCeX+BwPJ/P+/eAqOBZQccLGO8wwT6cOyitqHd7aq2weayrANwD2GdemahAsWpqbCyPLz7mYQvx0Qtc1eE7RYCnuweI+730uSsMJhivr7V3Vc+h5D2A9fY06nS9h/+t5j2BQMBIAL/9peDgrrKnUXZU+/8BsJikHXaHCk4AAAAASUVORK5CYII=",
    ["skinTemplate"] = "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",
    ["crispy156_radioactive_suit"] = "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",
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
