mcl_death_messages.messages.stab= {plain="@1 was stabbed."}
mcl_damage.types.stab =  {bypasses_armor = true, bypasses_magic = true, bypasses_invulnerability = true, bypasses_totem = false}
mcl_util.deal_damage(minetest.get_player_by_name("@n"), 20, {type="stab"})