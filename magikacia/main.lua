magikacia = magikacia or {
    textures = {},
    registered_globalsteps = {},
    registered_globalsteps_slow = {},
    registered_player_globalsteps = {},
    registered_player_globalsteps_slow = {},
    players = {}
}


function magikacia.register_globalstep(id, func)
    magikacia.registered_globalsteps[id] = func
end

function magikacia.register_globalstep_slow(id, func)
    magikacia.registered_globalsteps_slow[id] = func
end

function magikacia.register_player_globalstep(id, func)
    magikacia.registered_player_globalsteps[id] = func
end

function magikacia.register_player_globalstep_slow(id, func)
    magikacia.registered_player_globalsteps_slow[id] = func
end

if not mcl_util._magikacia_main_init then
    mcl_util._magikacia_main_init = true
    local globalstep_slow_timer = 0
    
    minetest.register_globalstep(function(dtime)
        globalstep_slow_timer = globalstep_slow_timer + dtime
        if globalstep_slow_timer >= 5 then
            globalstep_slow_timer = globalstep_slow_timer - 5
            for func_id, func in pairs(magikacia.registered_globalsteps_slow) do
                func(dtime)
            end
        end
        for func_id, func in pairs(magikacia.registered_globalsteps) do
            func(dtime)
        end
    end)
    mcl_player.register_globalstep(function(player, dtime)
        for func_id, func in pairs(magikacia.registered_player_globalsteps) do
            func(player, dtime)
        end
    end)
    mcl_player.register_globalstep_slow(function(player, dtime)
        for func_id, func in pairs(magikacia.registered_player_globalsteps_slow) do
            func(player, dtime)
        end
    end)
    minetest.register_on_joinplayer(function(player)
        local playername = player:get_player_name()
        magikacia.players[playername] = magikacia.players[playername] or {}
    end)
    minetest.register_on_leaveplayer(function(player)
        local playername = player:get_player_name()
        magikacia.players[playername] = nil
    end)
end

