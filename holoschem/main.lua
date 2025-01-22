local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

holoschem = holoschem or {
    modname = modname,
    modpath = modpath,
    textures = {},
    registered_globalstep = {},
    registered_globalstep_slow = {},

    registered_on_mods_loaded = {},
    registered_on_shutdown = {},
    registered_on_receiving_chat_message = {},
    registered_on_sending_chat_message = {},
    registered_on_chatcommand = {},
    registered_on_hp_modification = {},
    registered_on_damage_taken = {},
    registered_on_formspec_input = {},
    registered_on_dignode = {},
    registered_on_punchnode = {},
    registered_on_placenode = {},
    registered_on_item_use = {},
    registered_on_modchannel_message = {},
    registered_on_modchannel_signal = {},
    registered_on_inventory_open = {},

    schematic = nil,
    schematicname = "",
    pos = vector.zero(),
    visible = false,
}

local function get_localplayer()
    if not holoschem.localplayer and minetest.localplayer then
        holoschem.localplayer = minetest.localplayer
        holoschem.localplayername = minetest.localplayer:get_player_name()
    else
        minetest.after(0.5)
        get_localplayer()
    end
end

for k, registered_list in pairs(holoschem) do
    if string.find(k, "^registered_") then
        local fname = string.gsub("^registered_", "register_")
        if core[fname] then
            function holoschem[fname](id, func)
                holoschem[k][id] = func
            end
        end
    end
end

if not mcl_util.holoschem_main_init then
    mcl_util.holoschem_main_init = true

    local special_registrations = {
        registered_globalstep = true,
        registered_globalstep_slow = true,
    }

    local globalstep_slow_timer = 0

    minetest.register_globalstep(function(dtime)
        globalstep_slow_timer = globalstep_slow_timer + dtime
        if globalstep_slow_timer >= 5 then
            globalstep_slow_timer = globalstep_slow_timer - 5
            for func_id, func in pairs(holoschem.registered_globalstep_slow) do
                func(dtime)
            end
        end
        for func_id, func in pairs(holoschem.registered_globalstep) do
            func(dtime)
        end
    end)

    --[[minetest.register_globalstep(function(dtime))`
    minetest.register_on_mods_loaded(function())`
    minetest.register_on_shutdown(function())`
    minetest.register_on_receiving_chat_message(function(message))`
    minetest.register_on_sending_chat_message(function(message))`
    minetest.register_on_chatcommand(function(command, params))`
    minetest.register_on_hp_modification(function(hp))`
    minetest.register_on_damage_taken(function(hp))`
    minetest.register_on_formspec_input(function(formname, fields))`
    minetest.register_on_dignode(function(pos, node))`
    minetest.register_on_punchnode(function(pos, node))`
    minetest.register_on_placenode(function(pointed_thing, node))`
    minetest.register_on_item_use(function(item, pointed_thing))`
    minetest.register_on_modchannel_message(function(channel_name, sender, message))`
    minetest.register_on_modchannel_signal(function(channel_name, signal))`
    minetest.register_on_inventory_open(function(inventory))`]]

    for k, registered_list in pairs(holoschem) do
        if not special_registrations[k] and string.find(k, "^registered_") then
            local fname = string.gsub("^registered_", "register_")
            if core[fname] then
                core[fname](function(...)
                    for func_id, func in pairs(registered_list) do
                        if func and type(func)  then
                            func(...)
                        end
                    end
                end)
            end
        end
    end

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