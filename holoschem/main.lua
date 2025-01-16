local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

holoschem = holoschem or {
    modname = modname,
    modpath = modpath,
    textures = {},
    registered_globalsteps = {},
    registered_globalsteps_slow = {},
    registered_player_globalsteps = {},
    registered_player_globalsteps_slow = {},
    registered_damage_modifiers = {},
    registered_on_leaveplayer = {},
    registered_on_joinplayer = {},
    registered_on_player_receive_fields = {},
    registered_on_receiving_chat_message = {},
    registered_on_sending_chat_message = {},
    players = {}
}

for k, v in pairs(holoschem) do
    if string.find(v, "^reigstered_") then
        local fname = string.gsub("^reigstered_", "reigster_")
        if core[fname] then
            function holoschem[fname](id, func)
                holoschem[k][id] = func
            end
        end
    end
end

if not mcl_util.holoschem_main_init then
    mcl_util.holoschem_main_init = true
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
    minetest.register_on_receiving_chat_message(function(message))
        for func_id, func in pairs(magikacia.registered_on_receiving_chat_message) do
            func(message)
        end
    end)
    minetest.register_on_sending_chat_message(function(message))
        for func_id, func in pairs(magikacia.registered_on_sending_chat_message) do
            func(message)
        end
    end)
    minetest.register_on_hp_modification(function(hp)
        for func_id, func in pairs(magikacia.registered_on_hp_modification) do
            func(hp)
        end
    end)



    minetest.register_on_joinplayer(function(player)
        local playername = player:get_player_name()
        magikacia.players[playername] = magikacia.players[playername] or {}
        for func_id, func in pairs(magikacia.registered_on_joinplayer) do
            func(player)
        end
    end)
    minetest.register_on_leaveplayer(function(player)
        local playername = player:get_player_name()
        magikacia.players[playername] = nil
        for func_id, func in pairs(magikacia.registered_on_leaveplayer) do
            func(player)
        end
    end)
    mcl_damage.register_modifier(function(obj, damage, reason)
        for func_id, func in pairs(magikacia.registered_damage_modifiers) do
            func(obj, damage, reason)
        end
    end, 2048)
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        for func_id, func in pairs(magikacia.registered_on_player_receive_fields) do
            func(player, formname, fields)
        end
    end)
end





--[[

### Global callback registration functions
Call these functions only at load time!

* `minetest.register_globalstep(function(dtime))`
    * Called every client environment step
    * `dtime` is the time since last execution in seconds.
* `minetest.register_on_mods_loaded(function())`
    * Called just after mods have finished loading.
* `minetest.register_on_shutdown(function())`
    * Called before client shutdown
    * **Warning**: If the client terminates abnormally (i.e. crashes), the registered
      callbacks **will likely not be run**. Data should be saved at
      semi-frequent intervals as well as on server shutdown.
* `minetest.register_on_receiving_chat_message(function(message))`
    * Called always when a client receive a message
    * Return `true` to mark the message as handled, which means that it will not be shown to chat
* `minetest.register_on_sending_chat_message(function(message))`
    * Called always when a client sends a message from chat
    * Return `true` to mark the message as handled, which means that it will not be sent to server
* `minetest.register_chatcommand(cmd, chatcommand definition)`
    * Adds definition to minetest.registered_chatcommands
* `minetest.unregister_chatcommand(name)`
    * Unregisters a chatcommands registered with register_chatcommand.
* `minetest.register_on_chatcommand(function(command, params))`
    * Called always when a chatcommand is triggered, before `minetest.registered_chatcommands`
      is checked to see if the command exists, but after the input is parsed.
    * Return `true` to mark the command as handled, which means that the default
      handlers will be prevented.
* `minetest.register_on_hp_modification(function(hp))`
    * Called when server modified player's HP
* `minetest.register_on_damage_taken(function(hp))`
    * Called when the local player take damages
* `minetest.register_on_formspec_input(function(formname, fields))`
    * Called when a button is pressed in the local player's inventory form
    * Newest functions are called first
    * If function returns `true`, remaining functions are not called
* `minetest.register_on_dignode(function(pos, node))`
    * Called when the local player digs a node
    * Newest functions are called first
    * If any function returns true, the node isn't dug
* `minetest.register_on_punchnode(function(pos, node))`
    * Called when the local player punches a node
    * Newest functions are called first
    * If any function returns true, the punch is ignored
* `minetest.register_on_placenode(function(pointed_thing, node))`
    * Called when a node has been placed
* `minetest.register_on_item_use(function(item, pointed_thing))`
    * Called when the local player uses an item.
    * Newest functions are called first.
    * If any function returns true, the item use is not sent to server.
* `minetest.register_on_modchannel_message(function(channel_name, sender, message))`
    * Called when an incoming mod channel message is received
    * You must have joined some channels before, and server must acknowledge the
      join request.
    * If message comes from a server mod, `sender` field is an empty string.
* `minetest.register_on_modchannel_signal(function(channel_name, signal))`
    * Called when a valid incoming mod channel signal is received
    * Signal id permit to react to server mod channel events
    * Possible values are:
      0: join_ok
      1: join_failed
      2: leave_ok
      3: leave_failed
      4: event_on_not_joined_channel
      5: state_changed
* `minetest.register_on_inventory_open(function(inventory))`
    * Called when the local player open inventory
    * Newest functions are called first
    * If any function returns true, inventory doesn't open
]]