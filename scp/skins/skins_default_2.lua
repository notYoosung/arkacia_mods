local n_skins = 45 local texture_list_slim = {}
local texture_list_default = {
    ["levi"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAYNJREFUeF7tmdENgzAMRMNCLMFETMJELMFCraC0ohXkHB9Rk+j6W1/iPJ8daLuAPw8cEo3oSH1WuSU5ASBLYIFMbuGXW5KTA/x8N6UFMrmFX25JTg7w85UDqmgB1uKkQcwz4jdPS/vC3NZFagBwlSMNoQYAqEAUBAGopAWOvXzrLDA5YJqm0Pd9GIZhS2Se57AsSxjHEQ4ZQ4DHwkcIHv0nrVoBvA+wgsgPwFBFJoQ6ALPx1UMKO3WRHuWMgKD1kf5r/7NgdgOkFwBAAFUQAUZ6OeBIwHQLIM8W/n3UEQJQwJNgbgPJATHCagG1wP9/ENEMyExAQ1BDMEJAt4BugcwTqPTlk14dSz+MJz8B8FBrSSMHtFRNz1nkAA+1ljRyQEvV9JxFDvBQa0kjB7RUTc9Z5AAPtZY0ORzA/nvL6pPqIwBJuGzBbAVZvS3LPUoOSMJ1HowqdsMW0SWoIlLiPS0ByF1isD5VREosB7wIqAXUAv8lQLUxJdYM0AzQENQtUPs1+AQ9wVVBE9y/XgAAAABJRU5ErkJggg==",
    ["christmas_snow_boy"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAFHklEQVRoBd1ZTWhcVRQ+L76a6uSvSWbaTOikFaWNkiq2qMlCCaXQRTaCpSsXMl1bNy7c6LIrQaSILkRQN6IILqy4ULFogqDgDxLFoGaGpDWpjpmfkLF2nu/cN9+bO/e9d+97yYROffDmnHv+7jnnnnvufYlFhuebwqpzYGgwVOrq3xtUrZR9Xl//gMBl2mP3HbV8gS5EeuL4tK/vTiHGUMahi8A5UUgWaJDpVhgrAew8rzY/d7jrCVwQ3B8OWg6YcSQCMt0KYycgTgBcHdl+r1riyHeDjG1ygvdzqRrsAaXqptj/j+bSroktyu7rJar9Jcw9yDjTBM80w83lGxMgu8dBl2TC/wCPtQXUbs9VofaBWzUXsSoAx5ocNGi3auDw2zKd89zN506eps1qhT796kvo+ZCTEtXxkTAd/3guG/uesFKuOZh4fCAVWw86YVBsAflsl3EoHD39OI1On8IwAGUdGYegTJNx8ONCTiiSutlw/GTE1Q+T83sADKvn/MyxKZp/6yL9+tHbdOLI3bRULPpOyAaj9CFj4kNOhlydE4fuEu/Y2Jgz9/BxcfKwLW7IzOdX1kmKG3vA+5e/8K+7BzeuELlv0Z1lyW2E8uUn6cRx5LnPvPnhJTEP43ytdl/6/MefnKuugU70IZuN6M55dvTCSy8Lf1956oyAGD/3zNNibNI38YURzY/aJ/B9wYnQqMVitVVA1Dn/yHiG5ufn6fDUMWG0sXyBZmZmAhNE6UPQxIccIALFWIUmviofNhYJ4D0lyqn51cc4lxie88+/QPe+9y5deW2EMpkMnTt3kU49cYa+X/xZiJj0TXzMY4J/vpp2Bo/MkT37RkdOAJ7PkssIexp7y7vmmtwiulxYF0KqvqoZxu/EKqrzJBkHMrmyUXeyA7f7Nq5t1qm31xvX6/9QOrU3oOMLuwjry2MVX1/7g9KZ/SpZjJn3wD05rX3HfaD83VJR2GK92YfuF+RSqaTVhy6gfwyCoEIEz3QZV+VuxhiJBNyOD8YEbMcodLiS5GoCvZugMQFc9nhkHDQtrLqfx/zu0sOlzw/gdqaxwvZs3FVbLbeSEzZ5tqcqyKuNvjB2LFqUL1FzQ354eFjYN/UEOzx74U1K9Zh1w/YfnMjnn6XFxUVxh2Bdk9Oq/Sh5VW4nY/v1T74O1b+28jsVVtyrb8iTGx+j0fFDgpM/eSJEwksgB7+wsOAHHp5sVt8f6BUcvCcfvhg6WwGHBt/xTo6Ns60ToklruwlCURc8yyAxnARdBXxw6WOqb7l/GvOP1fBgWnx4QE2dYGJaEvFtTeQytPzDrEUcNCehCSemPnPsrVpF2Nyb6vdtY3URqM9oIlwBfUMjBF2Vz6vHQaWH2KZnV1fOOp5qe0djN3gOWiSjacivgKhgdjKhZVk0PT3t94AoW2EVwLK7kZjlwlqbG/aL55+k/tu8rVG54W2VJONK7XqbQR4gIA5+cnJS8Jm2GwEFJjcR5D7gytq/FYqUSqWEWq1WEzDJ2LnR6iutub39iR6AwHWNC0mDDdbpVBNUVx1zMN0q/9twkqw4K8vyugrARIBIBMaAavCgs7yOBzkZQj72PWCnFTA6ckCeX+BwPJ/P+/eAqOBZQccLGO8wwT6cOyitqHd7aq2weayrANwD2GdemahAsWpqbCyPLz7mYQvx0Qtc1eE7RYCnuweI+730uSsMJhivr7V3Vc+h5D2A9fY06nS9h/+t5j2BQMBIAL/9peDgrrKnUXZU+/8BsJikHXaHCk4AAAAASUVORK5CYII=",
    ["scp_guard"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAC/0lEQVRoBe1YO49SQRQe5LGFQSjADQQCLaGwoaH3H1hR2FnY2GpjaasFjT/Agspu41+wtiAkVpIQKCAskYSwEIJzrs7kzDAz98zlkmXXvQ3n8Z3nzJyZkGDh3z4c4kQknFqCslAoGHOYzWZH+35EiH+rEFvxkJRLR0367BtALSQq7qEBUTt3X+wedsB9WcmodZz9DnBddS4dtSEpDjTescIBv2oEGemXJ+n0z50mbNcZtcAwe5ceHhLOBKEBPBFj8aAL+2y2wo7iQ2BP8RvagFMExT5xA4rFIlZFpqfTKdmW1ICrD2/Y6uaGJZMX7Pr3NatdPmXDXz/Zq89X5EA2IDQAF75YLALo1+/PvthsTPIX7R8vQZ7P56Wa0ghSA/b7v6fk2/vXLPPkMXv+9mMQJJEA8+O+RqPBBoNB4KhUKu19C9ejQyMmk0ngj/t2Hm+whSEY+h0U+u5TqA0VIIqn4n1wFN+kHeATNAL2+G0UIagwOft3gEj0VL8H3a/Vasq50QfJarU6sMHJwTnGvC8tzq/DTvFfqVSCaxqGKVy56/XamZ/u97/fAXe+AbDqYvXxm0JfaRt/5xtgK4wqh/OinCndkM8ERTQcDhU+TK+AOeOL1+11ns8cRcRniMI3m03J9/v9YD5wmayZ9A6QHgzEZrNh4/E40JTLZQNCFfniVev4uRRMefEUxRNfyGwhBbbVaklIJpORtI3AGEzb8MfKxapjP1gW7ABRDAbhxmA50Dq+Xq/rECfvg9djOR0blGEL6TwClODpdNoQ1i7yxds9xaMxNkB0jdKA7XbrlYkv3sv5P7BP/ikBNgUCXafTUVS9Xk/hYarDYIOPeqZ98UrAmJlgCOo+RVNMO6Db7SrwdrvNfLY1YH3wSrATMMYjYCrcFhtv6d1uZ4NJOX+r8z9WkpI/BeGTf0o8TPQHjp6YwOnyXC4nRdTCxBGQhrdIyB2AC8xms0FKy+XSKzVoxmg0ctoAZj6fOzFYWa1WMRs7LRuAPfsUTh182H8UG2wfJ/0HMHbxCsa+QjMAAAAASUVORK5CYII=",
    [""] = "",
    ["scp_173_8271915"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAADR0lEQVRoBd0XO4gTUXA2Bo2XhEuOwwML5RrhmmBnYXO9WBxoZy/YKQciKCIIghxoJR5W2lpYCVceghyHjQRBsBHE5g7J58KZpDHuvHV2Z19m9+0mm92NDzZv3vzezHvzZiYWGMb+7pPRoN8WuUqn6wofRr+0fs8ShXOCLJrsQOeGg04om4keKpwxsZDx/plvP/EBjEZ/Mjc+CQMmPoAkNs+DDmMOaDabUFssibZ2uj+h0WiItHlBGg8AHQxKcufO1+bFz0A7jQdApU7SEEZDfhNd0pk2zpLqPIY93jw5QHV+9PaXss+6vqxmTicZ7gCnczzBSM+6TyjyOv/73QBK9TrU1kq+sHefQKvl2D7wBw7SMU/0d4YwaLdhYcOfM1x58pzmHLRIviqAhhfW+2Seml+d+AZfz64CvD708Db8pnwIn5ecTpAIKKs7TzRxHonYVJFFKctblnc19ZNL8Km7D2u2WS8LBahUKnDj6AgIfxEuuAYfHLBDsrGd7g9FC64iDt1VkAFQDMvyaM+1/jIMt53Q7/V6gB+Uy3D1eQtO3fScX1k5M2Y+VYmgJ+DQd8bk0kT4noC08d1HH9TNY7Ru2o7jhwOjAWnzPowHgA7ireOj2Lad3jo+Vj6rSFBQtB9snd0P8tNGi2WQXOJljEog0bAUcjrh+RyFnnUZ9LLdP8t5X6A7gGuTwVyeHwbCpK/b/g6373+EarWqWDCanj2+DIv11Vj6SR/1KVHs023yF3SbyvsCYg5KYkTnsyTP6QSjw/ogR3Q8X0v649jHdSEcKQfoQv/TeiwCKKzQSQ5La+kgdBnOE0abRL+uT1/zvYNgXxIkBRSK0671TU36jPwLdudp1+M49plylu+/ABmgv6lp16SXZpM+4qPZxG+ikx5pzlUOoD5BMnRWuNwcADr/8OkX9SGc1hhLgmltLO0Tt7uUdMTF5SYC7jzYU40RNkcIpzVyEwHoOHWGaTmP+6RyAPimLcsLNumN8/Dn8KwPw7Nqhjtx53EbXHMc/S+gKMAZcWmMyBEg3VpSBnLHk9IZVY86AD1EJWF+YxJ9Gpwe8rjWcdPoD5MtUnuKTBxOYq1vHKT/xdYVuLX53mVH5xEXxE+Mcekkx+e/plWE7JxJB6sAAAAASUVORK5CYII=",
    ["coronavirus_hazmat_suit_14005506"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAABQBJREFUaEPtWV1IXEcUPltYumTdlS1o1JBFtiHQ1mDbl/UpkKV5EAopQiNtmpdgi0lBKlL6IIgIpQmipoXEh9q+JBV8KElKKgWLgSJUQShSTTFNFrkFNfqwuOvaFmlu+aaeZe44987qemsCDoh37pl7fr45fzMbIMN4MEQ2lkSqah0rc8sLjrkb/XgLBUwyTHTooOPPvE10L/5G5Zh5KJpw8PkrmyYGQVWOF4JeKgB+yzcCsHS31laNZwMBgmlUv7lglOHFw2/5RuX8VsAEoN/yDwAoZgdMa7zoexECfvI3ekBjY6MdjUa1OmSzWbIsixYXF7X0mpoampubM8ooBeD6+np7ZmZGK8OLxjKNyjEAKggwXgUgEokUbMnlcvR/AJBIJOx0Oi3smJ6etqFTKpUSc5nmBnLArc5fuPZS4RsY7wYAL/r6w9923Sfo6vhOQwfJUlZALsFefYIAAHWcSx1K20c3koLXxfffKvAMh8sdBubza4X54Je3xfPV81MOPnKfYOojZPngtVsAZD7FyA+oZYYBgPFstGz8oXA5VVbFaWXZotXHljA8v7FGAEEGAO+5TzD1ETId33gZv/r4DztcVk6HwtFt4auzBXp4ydcC0HXnNJ1rTgkA1J3nba998QQtPPqV4An4+2ZknHrOjDmE+QEAy9/IZ20VBF8AgEAdCPCE1ZUtD9gHAOAJFYePOrxgzwBQcwB7wsqWwZWV8cLOAyBdDvAjBEZHR21Ul+bmZm312hUAuiQI5QECSgrG5OQk9fb2Uk9Pj5jjubW1lRoaGsQcFQLxL8ebeljaSRJEDkANh7EYKHMjIyP28PAwhUIhampqEiCgzIGO8oteQAagWPmuZfCNT8IUj8cLjU5XVxcNDAwIhdrb2wUYqPO85screUeV2MlxWS1TOgCGhobssbExAXYymaSWlhYtAKxE0WXQoTURZX5KCVQZweTHscKS9fV12tzc9GyegsGgXVZWprIVc3xv3TpSoOmO06byJ4OVvPRE8GJPwXMmkzE2d7Jy2xbvFQD3bzj7hpfPrx0AcOABT2MIsMurQStnUZUmt86rD8bplYtBxxLkALcQkBfODW6KqZxnZPpUb2bbXaRMVxOtqAhVtY6rOq9rOeSTwF4AwEoxECYA2HD+DkojR8gDAEJ5t/tGkfyUi1k3AMCDextOmF9dui++1wLgtfuy0qjt8r0gGyEfix07tlXXVe/gHqH+vYdi+czNY+I/eJvOEap3yjrxM/63XqugJxM/0+/ZLEVePUHffRoU/Ev2ADcA2AhWEMYx+vsBwLnLIaoK/0lruQ16tPw33fviBf8ASN95TdsHJM78It7vFwB9fX3i9qqtrY0mBg+7A1BqCDyNALz72fPU399P8/Pz1NnZ6Q0Ax58uyXCi4dhEFeDB2Rw7rOv9OUcgu8sDSYq7On4/df05kaQqjqe03uT2m4SaA6Af+J+9cpS6u7tFGHZ0dNDE5//8lwRjsZjjKkmWhsZFN9xaXV5r8gCVp1fSnJ2d1eqwtLSkfV9dXU1Mw3NdXZ04LFmWFbjw9ikbOeDbH6YC8XhcHLZ8AcBUBXQAeCVNnaVem8M0AAAjxWnx5jH64J2Hogrc+/514qRcMgBqQoOyuyldOiPh5mpo8LpiPUAGQJbxzAMgnwC1sbB1TwDXd2v2YifHA754ACtk+vVYVVy33s0D3ACAuzONY98NILz/Fz9Iaww3zGQPAAAAAElFTkSuQmCC",
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
