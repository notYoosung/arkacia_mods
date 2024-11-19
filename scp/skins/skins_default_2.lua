local n_skins = 45 local texture_list_slim = {}
local texture_list_default = {
    ["scp_guard"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAC/0lEQVRoBe1YO49SQRQe5LGFQSjADQQCLaGwoaH3H1hR2FnY2GpjaasFjT/Agspu41+wtiAkVpIQKCAskYSwEIJzrs7kzDAz98zlkmXXvQ3n8Z3nzJyZkGDh3z4c4kQknFqCslAoGHOYzWZH+35EiH+rEFvxkJRLR0367BtALSQq7qEBUTt3X+wedsB9WcmodZz9DnBddS4dtSEpDjTescIBv2oEGemXJ+n0z50mbNcZtcAwe5ceHhLOBKEBPBFj8aAL+2y2wo7iQ2BP8RvagFMExT5xA4rFIlZFpqfTKdmW1ICrD2/Y6uaGJZMX7Pr3NatdPmXDXz/Zq89X5EA2IDQAF75YLALo1+/PvthsTPIX7R8vQZ7P56Wa0ghSA/b7v6fk2/vXLPPkMXv+9mMQJJEA8+O+RqPBBoNB4KhUKu19C9ejQyMmk0ngj/t2Hm+whSEY+h0U+u5TqA0VIIqn4n1wFN+kHeATNAL2+G0UIagwOft3gEj0VL8H3a/Vasq50QfJarU6sMHJwTnGvC8tzq/DTvFfqVSCaxqGKVy56/XamZ/u97/fAXe+AbDqYvXxm0JfaRt/5xtgK4wqh/OinCndkM8ERTQcDhU+TK+AOeOL1+11ns8cRcRniMI3m03J9/v9YD5wmayZ9A6QHgzEZrNh4/E40JTLZQNCFfniVev4uRRMefEUxRNfyGwhBbbVaklIJpORtI3AGEzb8MfKxapjP1gW7ABRDAbhxmA50Dq+Xq/rECfvg9djOR0blGEL6TwClODpdNoQ1i7yxds9xaMxNkB0jdKA7XbrlYkv3sv5P7BP/ikBNgUCXafTUVS9Xk/hYarDYIOPeqZ98UrAmJlgCOo+RVNMO6Db7SrwdrvNfLY1YH3wSrATMMYjYCrcFhtv6d1uZ4NJOX+r8z9WkpI/BeGTf0o8TPQHjp6YwOnyXC4nRdTCxBGQhrdIyB2AC8xms0FKy+XSKzVoxmg0ctoAZj6fOzFYWa1WMRs7LRuAPfsUTh182H8UG2wfJ/0HMHbxCsa+QjMAAAAASUVORK5CYII=",
    ["scp_overlord_vaz_mtf_epsilon_6_village_idiots"] = "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",
    ["levi"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAYNJREFUeF7tmdENgzAMRMNCLMFETMJELMFCraC0ohXkHB9Rk+j6W1/iPJ8daLuAPw8cEo3oSH1WuSU5ASBLYIFMbuGXW5KTA/x8N6UFMrmFX25JTg7w85UDqmgB1uKkQcwz4jdPS/vC3NZFagBwlSMNoQYAqEAUBAGopAWOvXzrLDA5YJqm0Pd9GIZhS2Se57AsSxjHEQ4ZQ4DHwkcIHv0nrVoBvA+wgsgPwFBFJoQ6ALPx1UMKO3WRHuWMgKD1kf5r/7NgdgOkFwBAAFUQAUZ6OeBIwHQLIM8W/n3UEQJQwJNgbgPJATHCagG1wP9/ENEMyExAQ1BDMEJAt4BugcwTqPTlk14dSz+MJz8B8FBrSSMHtFRNz1nkAA+1ljRyQEvV9JxFDvBQa0kjB7RUTc9Z5AAPtZY0ORzA/nvL6pPqIwBJuGzBbAVZvS3LPUoOSMJ1HowqdsMW0SWoIlLiPS0ByF1isD5VREosB7wIqAXUAv8lQLUxJdYM0AzQENQtUPs1+AQ9wVVBE9y/XgAAAABJRU5ErkJggg==",
    ["christmas_snow_boy"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAFHklEQVRoBd1ZTWhcVRQ+L76a6uSvSWbaTOikFaWNkiq2qMlCCaXQRTaCpSsXMl1bNy7c6LIrQaSILkRQN6IILqy4ULFogqDgDxLFoGaGpDWpjpmfkLF2nu/cN9+bO/e9d+97yYROffDmnHv+7jnnnnvufYlFhuebwqpzYGgwVOrq3xtUrZR9Xl//gMBl2mP3HbV8gS5EeuL4tK/vTiHGUMahi8A5UUgWaJDpVhgrAew8rzY/d7jrCVwQ3B8OWg6YcSQCMt0KYycgTgBcHdl+r1riyHeDjG1ygvdzqRrsAaXqptj/j+bSroktyu7rJar9Jcw9yDjTBM80w83lGxMgu8dBl2TC/wCPtQXUbs9VofaBWzUXsSoAx5ocNGi3auDw2zKd89zN506eps1qhT796kvo+ZCTEtXxkTAd/3guG/uesFKuOZh4fCAVWw86YVBsAflsl3EoHD39OI1On8IwAGUdGYegTJNx8ONCTiiSutlw/GTE1Q+T83sADKvn/MyxKZp/6yL9+tHbdOLI3bRULPpOyAaj9CFj4kNOhlydE4fuEu/Y2Jgz9/BxcfKwLW7IzOdX1kmKG3vA+5e/8K+7BzeuELlv0Z1lyW2E8uUn6cRx5LnPvPnhJTEP43ytdl/6/MefnKuugU70IZuN6M55dvTCSy8Lf1956oyAGD/3zNNibNI38YURzY/aJ/B9wYnQqMVitVVA1Dn/yHiG5ufn6fDUMWG0sXyBZmZmAhNE6UPQxIccIALFWIUmviofNhYJ4D0lyqn51cc4lxie88+/QPe+9y5deW2EMpkMnTt3kU49cYa+X/xZiJj0TXzMY4J/vpp2Bo/MkT37RkdOAJ7PkssIexp7y7vmmtwiulxYF0KqvqoZxu/EKqrzJBkHMrmyUXeyA7f7Nq5t1qm31xvX6/9QOrU3oOMLuwjry2MVX1/7g9KZ/SpZjJn3wD05rX3HfaD83VJR2GK92YfuF+RSqaTVhy6gfwyCoEIEz3QZV+VuxhiJBNyOD8YEbMcodLiS5GoCvZugMQFc9nhkHDQtrLqfx/zu0sOlzw/gdqaxwvZs3FVbLbeSEzZ5tqcqyKuNvjB2LFqUL1FzQ354eFjYN/UEOzx74U1K9Zh1w/YfnMjnn6XFxUVxh2Bdk9Oq/Sh5VW4nY/v1T74O1b+28jsVVtyrb8iTGx+j0fFDgpM/eSJEwksgB7+wsOAHHp5sVt8f6BUcvCcfvhg6WwGHBt/xTo6Ns60ToklruwlCURc8yyAxnARdBXxw6WOqb7l/GvOP1fBgWnx4QE2dYGJaEvFtTeQytPzDrEUcNCehCSemPnPsrVpF2Nyb6vdtY3URqM9oIlwBfUMjBF2Vz6vHQaWH2KZnV1fOOp5qe0djN3gOWiSjacivgKhgdjKhZVk0PT3t94AoW2EVwLK7kZjlwlqbG/aL55+k/tu8rVG54W2VJONK7XqbQR4gIA5+cnJS8Jm2GwEFJjcR5D7gytq/FYqUSqWEWq1WEzDJ2LnR6iutub39iR6AwHWNC0mDDdbpVBNUVx1zMN0q/9twkqw4K8vyugrARIBIBMaAavCgs7yOBzkZQj72PWCnFTA6ckCeX+BwPJ/P+/eAqOBZQccLGO8wwT6cOyitqHd7aq2weayrANwD2GdemahAsWpqbCyPLz7mYQvx0Qtc1eE7RYCnuweI+730uSsMJhivr7V3Vc+h5D2A9fY06nS9h/+t5j2BQMBIAL/9peDgrrKnUXZU+/8BsJikHXaHCk4AAAAASUVORK5CYII=",
    ["coronavirus_hazmat_suit_14005506"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAABQBJREFUaEPtWV1IXEcUPltYumTdlS1o1JBFtiHQ1mDbl/UpkKV5EAopQiNtmpdgi0lBKlL6IIgIpQmipoXEh9q+JBV8KElKKgWLgSJUQShSTTFNFrkFNfqwuOvaFmlu+aaeZe44987qemsCDoh37pl7fr45fzMbIMN4MEQ2lkSqah0rc8sLjrkb/XgLBUwyTHTooOPPvE10L/5G5Zh5KJpw8PkrmyYGQVWOF4JeKgB+yzcCsHS31laNZwMBgmlUv7lglOHFw2/5RuX8VsAEoN/yDwAoZgdMa7zoexECfvI3ekBjY6MdjUa1OmSzWbIsixYXF7X0mpoampubM8ooBeD6+np7ZmZGK8OLxjKNyjEAKggwXgUgEokUbMnlcvR/AJBIJOx0Oi3smJ6etqFTKpUSc5nmBnLArc5fuPZS4RsY7wYAL/r6w9923Sfo6vhOQwfJUlZALsFefYIAAHWcSx1K20c3koLXxfffKvAMh8sdBubza4X54Je3xfPV81MOPnKfYOojZPngtVsAZD7FyA+oZYYBgPFstGz8oXA5VVbFaWXZotXHljA8v7FGAEEGAO+5TzD1ETId33gZv/r4DztcVk6HwtFt4auzBXp4ydcC0HXnNJ1rTgkA1J3nba998QQtPPqV4An4+2ZknHrOjDmE+QEAy9/IZ20VBF8AgEAdCPCE1ZUtD9gHAOAJFYePOrxgzwBQcwB7wsqWwZWV8cLOAyBdDvAjBEZHR21Ul+bmZm312hUAuiQI5QECSgrG5OQk9fb2Uk9Pj5jjubW1lRoaGsQcFQLxL8ebeljaSRJEDkANh7EYKHMjIyP28PAwhUIhampqEiCgzIGO8oteQAagWPmuZfCNT8IUj8cLjU5XVxcNDAwIhdrb2wUYqPO85screUeV2MlxWS1TOgCGhobssbExAXYymaSWlhYtAKxE0WXQoTURZX5KCVQZweTHscKS9fV12tzc9GyegsGgXVZWprIVc3xv3TpSoOmO06byJ4OVvPRE8GJPwXMmkzE2d7Jy2xbvFQD3bzj7hpfPrx0AcOABT2MIsMurQStnUZUmt86rD8bplYtBxxLkALcQkBfODW6KqZxnZPpUb2bbXaRMVxOtqAhVtY6rOq9rOeSTwF4AwEoxECYA2HD+DkojR8gDAEJ5t/tGkfyUi1k3AMCDextOmF9dui++1wLgtfuy0qjt8r0gGyEfix07tlXXVe/gHqH+vYdi+czNY+I/eJvOEap3yjrxM/63XqugJxM/0+/ZLEVePUHffRoU/Ev2ADcA2AhWEMYx+vsBwLnLIaoK/0lruQ16tPw33fviBf8ASN95TdsHJM78It7vFwB9fX3i9qqtrY0mBg+7A1BqCDyNALz72fPU399P8/Pz1NnZ6Q0Ax58uyXCi4dhEFeDB2Rw7rOv9OUcgu8sDSYq7On4/df05kaQqjqe03uT2m4SaA6Af+J+9cpS6u7tFGHZ0dNDE5//8lwRjsZjjKkmWhsZFN9xaXV5r8gCVp1fSnJ2d1eqwtLSkfV9dXU1Mw3NdXZ04LFmWFbjw9ikbOeDbH6YC8XhcHLZ8AcBUBXQAeCVNnaVem8M0AAAjxWnx5jH64J2Hogrc+/514qRcMgBqQoOyuyldOiPh5mpo8LpiPUAGQJbxzAMgnwC1sbB1TwDXd2v2YifHA754ACtk+vVYVVy33s0D3ACAuzONY98NILz/Fz9Iaww3zGQPAAAAAElFTkSuQmCC",
    ["crispy156_radioactive_suit"] = "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",
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
