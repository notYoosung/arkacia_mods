minetest.register_chatcommand("secretkick", {
    description = "Kick a player from the server, but they won't see the \"Kicked: (Reason)\" message.",
    params = "<player>",
    privs = { kick = true },
    func = function(name, param)
        if not minetest.get_player_by_name(param) then
            return false, "[SecretKick] Error: Player \"" .. param .. "\" not found"
        end
        minetest.disconnect_player(param)
        return true, "[SecretKick] Player \"" .. param .. "\" has been kicked"
    end
})