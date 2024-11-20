minetest.register_tool(":scp:radio", {
	description = "Radio\nChat while holding this to send a radio message in chat.",
	inventory_image = "mesecons_button_wield_mask.png^mcl_blackstone_polished.png^mesecons_button_wield_mask.png^[makealpha:255,126,126^[transformR90"
})
minetest.register_on_chat_message(function(name, message)
	if message:sub(1, 1) == "/" then return false end
	if minetest.get_player_by_name(name):get_wielded_item():get_name() == "scp:radio" then
		minetest.chat_send_all(minetest.colorize("#787878", "{ " .. name .. " over radio }  " .. message))
		return true
	end
	return false
end)
