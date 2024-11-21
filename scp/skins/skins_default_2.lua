local n_skins = 45 local texture_list_slim = {}
local texture_list_default = {
    [""] = "",
    ["levi"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAAAXNSR0IArs4c6QAAAYNJREFUeF7tmdENgzAMRMNCLMFETMJELMFCraC0ohXkHB9Rk+j6W1/iPJ8daLuAPw8cEo3oSH1WuSU5ASBLYIFMbuGXW5KTA/x8N6UFMrmFX25JTg7w85UDqmgB1uKkQcwz4jdPS/vC3NZFagBwlSMNoQYAqEAUBAGopAWOvXzrLDA5YJqm0Pd9GIZhS2Se57AsSxjHEQ4ZQ4DHwkcIHv0nrVoBvA+wgsgPwFBFJoQ6ALPx1UMKO3WRHuWMgKD1kf5r/7NgdgOkFwBAAFUQAUZ6OeBIwHQLIM8W/n3UEQJQwJNgbgPJATHCagG1wP9/ENEMyExAQ1BDMEJAt4BugcwTqPTlk14dSz+MJz8B8FBrSSMHtFRNz1nkAA+1ljRyQEvV9JxFDvBQa0kjB7RUTc9Z5AAPtZY0ORzA/nvL6pPqIwBJuGzBbAVZvS3LPUoOSMJ1HowqdsMW0SWoIlLiPS0ByF1isD5VREosB7wIqAXUAv8lQLUxJdYM0AzQENQtUPs1+AQ9wVVBE9y/XgAAAABJRU5ErkJggg==",
    ["coronavirus_hazmat_suit_14005506"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAABQBJREFUaEPtWV1IXEcUPltYumTdlS1o1JBFtiHQ1mDbl/UpkKV5EAopQiNtmpdgi0lBKlL6IIgIpQmipoXEh9q+JBV8KElKKgWLgSJUQShSTTFNFrkFNfqwuOvaFmlu+aaeZe44987qemsCDoh37pl7fr45fzMbIMN4MEQ2lkSqah0rc8sLjrkb/XgLBUwyTHTooOPPvE10L/5G5Zh5KJpw8PkrmyYGQVWOF4JeKgB+yzcCsHS31laNZwMBgmlUv7lglOHFw2/5RuX8VsAEoN/yDwAoZgdMa7zoexECfvI3ekBjY6MdjUa1OmSzWbIsixYXF7X0mpoampubM8ooBeD6+np7ZmZGK8OLxjKNyjEAKggwXgUgEokUbMnlcvR/AJBIJOx0Oi3smJ6etqFTKpUSc5nmBnLArc5fuPZS4RsY7wYAL/r6w9923Sfo6vhOQwfJUlZALsFefYIAAHWcSx1K20c3koLXxfffKvAMh8sdBubza4X54Je3xfPV81MOPnKfYOojZPngtVsAZD7FyA+oZYYBgPFstGz8oXA5VVbFaWXZotXHljA8v7FGAEEGAO+5TzD1ETId33gZv/r4DztcVk6HwtFt4auzBXp4ydcC0HXnNJ1rTgkA1J3nba998QQtPPqV4An4+2ZknHrOjDmE+QEAy9/IZ20VBF8AgEAdCPCE1ZUtD9gHAOAJFYePOrxgzwBQcwB7wsqWwZWV8cLOAyBdDvAjBEZHR21Ul+bmZm312hUAuiQI5QECSgrG5OQk9fb2Uk9Pj5jjubW1lRoaGsQcFQLxL8ebeljaSRJEDkANh7EYKHMjIyP28PAwhUIhampqEiCgzIGO8oteQAagWPmuZfCNT8IUj8cLjU5XVxcNDAwIhdrb2wUYqPO85screUeV2MlxWS1TOgCGhobssbExAXYymaSWlhYtAKxE0WXQoTURZX5KCVQZweTHscKS9fV12tzc9GyegsGgXVZWprIVc3xv3TpSoOmO06byJ4OVvPRE8GJPwXMmkzE2d7Jy2xbvFQD3bzj7hpfPrx0AcOABT2MIsMurQStnUZUmt86rD8bplYtBxxLkALcQkBfODW6KqZxnZPpUb2bbXaRMVxOtqAhVtY6rOq9rOeSTwF4AwEoxECYA2HD+DkojR8gDAEJ5t/tGkfyUi1k3AMCDextOmF9dui++1wLgtfuy0qjt8r0gGyEfix07tlXXVe/gHqH+vYdi+czNY+I/eJvOEap3yjrxM/63XqugJxM/0+/ZLEVePUHffRoU/Ev2ADcA2AhWEMYx+vsBwLnLIaoK/0lruQ16tPw33fviBf8ASN95TdsHJM78It7vFwB9fX3i9qqtrY0mBg+7A1BqCDyNALz72fPU399P8/Pz1NnZ6Q0Ax58uyXCi4dhEFeDB2Rw7rOv9OUcgu8sDSYq7On4/df05kaQqjqe03uT2m4SaA6Af+J+9cpS6u7tFGHZ0dNDE5//8lwRjsZjjKkmWhsZFN9xaXV5r8gCVp1fSnJ2d1eqwtLSkfV9dXU1Mw3NdXZ04LFmWFbjw9ikbOeDbH6YC8XhcHLZ8AcBUBXQAeCVNnaVem8M0AAAjxWnx5jH64J2Hogrc+/514qRcMgBqQoOyuyldOiPh5mpo8LpiPUAGQJbxzAMgnwC1sbB1TwDXd2v2YifHA754ACtk+vVYVVy33s0D3ACAuzONY98NILz/Fz9Iaww3zGQPAAAAAElFTkSuQmCC",
    ["bizop_santa_8be6e7479f6ee130"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAAD+ElEQVRoBeVZTWsTQRiebLbdxKDQCMbWHhQCHvzCm2c9CaIgePNSKdGDePBUKHhT/BGiCPkBCuJNbwFvRUUEkYIo1ra0HvqRL5O4z7bPdnYyO7sxG5vSAZl5v573Y96ZndSUiBgdd5hUlpaWTGJRKBRSRoU+hU8Ko8b4phcbRv92n/6HwvxoWp/jr5axNl7siRXg0oWLwkpbHmi71RZv3r0diuJEBZFYAeDow9ePnr+zxTNRfhOT31qoGbGmra1NCVNKrADcfThCB/yvYVmWvv9jBpBYAZD06ROnPLdyMWLGsWtqkdUb9q9Av5UzH5B+0feAfSpqhwedQ8odg/Zhwt/3HbDvC7DrR4Av7YjPmfykw5FR6a4ub7fbvs7T8UyXHAy8IRL7DGo9xGAiODxlEXBEEXSJ+0nKroD1ejIr+BQG/ri9c9Us/Ol4NHzvegEYOAI2FIHRh82E8TCApQ4kLQ/SsQoQdlGzfWXgvbaOVQAkyiJ0DpwU1WZDZBvzieS62AzuTBKgbH1gF0ZS/lHQYbOlfNmhXC4Q0d3jx3wZFo8+femykRUe5kc6cKobTNYkn11t6o23AV9NOB05wZnl4I+hdDrkt7EuIJcXqwNCbEPZTPR8+aWnM3fzWkCX8gCzBwKXGovQg5lWdSAFoKd8Ps/l0M4DKQBbnAUgzZ0nzb/kcDcpj6oW9aP04shTxWIxcOZVo2q1GmBls8FPzNTqt4AcBBOcePZCNJtNsVy64emEJUh9FQj65zLdj1UWIAoPBb7ys268U7QdwBt/fX1duI+TQFwoiOM4Ph/BMxAm4j887lz3bCcdS/C7C0aovuRJ1ucjhjx2DtV1eJRFzVYmkxHlcllUKhWBNf4hQQw1eRUsl8upLI9mwLJQx6NcJ9PxqJ/kbCPJUqnkYWKN3W+1Wkn6GGqswBFwn6I9B8v2gyHXc6Ltve+5i2hdnFvK6YS0SR/tztanHWYTHuTqMQFPN+zNzU0dX6iXn6xUr9cFLsONjQ3vwmMi6oUlB46AGNT72lah5TsD+Ko+fcqFJI9YoOlfxaOuabblc4yEOJBgWBFwR/h2a7Tof9Yl2j+qGcGWzzsuQI5aLfjEJJ/z2po5cyZDfXl3yVNnk45JpuL0QgfuABpe7TSEcD9dz4NPAIojZ5xPfqtlZbltZT7XLJqarEoTm61Pe5WO8gc7+/7BUdr785HZx/hPTTF2e8rnyYvDzo5Ne/6HL2JgYY4p9w22F+DDRk6Uupe/6+8oFSOUTqdDRRDYK3V3t5Wx8mBGfHZ5vzUyRVWMqYx/oHUFA49F4HuEX6leaVNIdpwkVQDZpiH9ng9rQSaiylVa9UM5E6e8F/qe5Rif+n8Bzqy1G2A3X9gAAAAASUVORK5CYII=",
    ["ninja_9_922e96ac3c6eaf715337081860a63a42bc9"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAQKADAAQAAAABAAAAIAAAAADfYzX9AAADtElEQVRoBe1YzUtUURS/r0YbphkbaFZCgrMJQdopuKpFiCuhaFMtajYRapCCUEo0EVowYEEFEYSbKANXSeSfkM6mhSBuGihQCiFzpjBlmOZ37TzP+7p3xsf4RunAcD5+55z78c65970xhIY6OjpKKpeRgZQKFueu9BlKh4DBQ9WM39jYKPA7SBSqdDGFQkFsbGxI93A4LKLRaKWhde2nLU9dC6yurioXmMvltGMoE9QYrLgCMA8q/83NTce0JocvWWypzGuLXq9KxRuga4HY0bBjjcVi0WGrN4O2PHUtkEl1yzVhA6JNx6RcWP8p8r+2z4szfWPaMYLclKpugSAnWquxDd0Tnp+fl2MbhiFKJecrQWdnp6+5ZbPZQCvEUgF+73ldvA73tZO7DJYbQKc7z+Fm4ziX3Xy5jcsU52YjbC+5WQE45Ym4TDYd5zFcpjhu4zLhQfFQ/1mc1vjhRlz/N48dGb1vp6mpl6ZJF7/t6J3/atZMFYhgtLW1yZMNr7mJREJO4vlAr7zSeoYeifKbnOvhR7NNJpNidmJQ4Oq7/vSdNOPtEK/LROO3bpBo4SMPn4jFxUXnDlu8aquEaHJD6Yyg0sQdTnd6pcMjhuIRQ3lV8fApfy2qXGqOmWfARHpYfuygEvAau7LyTdhfb91mAx/4Igax+CHXfiFH+Q3eTpuXfT6fF5e7u8y1rP34rv2+v9DeXoo0NIjfW1sCHEQy+J/y70jZThw4yeAzS0uOOcGHiOevJo7i7dysADtQKx2L9yIVRjG0qeDwH7t/TXLCq+UVfwxVm7h/PC2ai8sybPlws5i8O2ZJMZSx6s9G0hZ8r5Q9rwCUrRepMIpBG4GonUbvvJAtRHi13OA9bw/GGeBGsVjMNH+dmbb0OgCUZ+reqKMCaPJUxnadksIOHzvOdS4jjuuQpxcWlGcJjeW7BfhT43JTPCqW15oFDs6W1qj5xGhgcO4Pmc4AshOnGK5z2S0Xxei47w1QDYBNqHfyvQF4alTStFi7Dju3cZlj3O4lc3+77KbDpiLfG8BLkcuP38yKRDwu5ubeixPHT4piucQ5jklx3U3mNpW/DgPuRb43wCvxzYs9EurtahdohQd9n7xcA7X73oD/LVAubSJ7ycJOByGuJjvOdTeZ25CL61zWYcC9KBSJRBzY+dOnpO3Vh48ODAa3GFfHfWAM0WL5XL/kPksV/etG9FSBLb09gLdAS2tSrnt9bedvMreNgI2XIpft/nXbAqpF4i1ut6TKu9uctYj7C0FxyX2TdhxgAAAAAElFTkSuQmCC",
    ["scp_049"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAAAXNSR0IArs4c6QAAAfJJREFUaEPtmLFug0AMhs2SlAmJLqTMPEKeo1kzhkysnTsmG+rKlowRW/o8zJFYelImmimVT0KC64E5LiStOBZEzrZ8X/yfDRYQl+u6V8qmbZ0xZun4D+1LJocAnqbTxjy+LxdoWsc1A8BUwAgkwBiTSsR13XFIwAAwFfCPJaDb53X79KPbpNWlz7dpvO+MgOD+wpzQGUBRFLU/27ZtwFN+FABOp5O00n3fHweA7J3B8xtAnucchOd58PUBEGxGUgEGQJZJJRAEwd0kkOf51XEcnsf5fMYqJF/kunQofghShlkLAMqXWldpg0VR8Fxt277J5jHWr0AUECphyl8HSAkAD9/yiuO4FjIMQyU4UgBla8M+jVf1uQuAtu8D1XgijC5zQXVuQXsEsFwueajD4QAGwC0qQOcT15ASwLzE+NoS0E2Y0vSj1ynJ1kZhmebFM6DtuZzvZToXY5dgmn6XxeqTnwFAfJM0FSC2FZWSl5WvaqkbCQizRvXQ7KN51bnFSOAWbbA6+Q0hAZ1WSnaBKIrIl6G2BNI01cmP9BUHHdJBMKBGY3wX6A1gOplAuF6r5qRkP5/PYbVacZ/9fs/vKs+DAsBkXmYz6YZeFwv4PB6hvCvtumK82W6VNiwCGhwAtbEoiiBJEsqscX232/X2RUcKwA8W5lw/M+OKYwAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
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
