minetest.register_tool(":bear:taser",
    {
        description = "Taser",
        inventory_image = "mcl_fire_flint_and_steel.png",
        groups = { tool = 1, dig_speed_class = 7, enchantability = 100 },
        tool_capabilities = { full_punch_interval = 0.1, max_drop_level = 0, punch_attack_uses = -1, },
        sound = { breaks = "default_tool_breaks" },
        on_use = function(
            itemstack, user, pointed_thing)
            mcl_tools.entity = pointed_thing.ref
            if pointed_thing.type == "object" then
                local playerref = mcl_tools.entity
                if mcl_tools.entity:is_player() and mcl_tools.entity:get_player_name() then
                    playerref = minetest
                        .get_player_by_name(mcl_tools.entity:get_player_name())
                end
                if playerref and (playerref:is_player() or playerref:get_luaentity()) and mcl_util.get_hp(playerref) > 1 then
                    mcl_util.deal_damage(playerref, 1, { type = "generic" })
                end
                if playerref and playerref:is_player() then
                    local function snap(ent, n)
                        if ent and ent:is_player() then
                            ent:set_look_horizontal(ent:get_look_horizontal() + math.random(-math.pi / 16, math.pi / 16))
                            ent:set_look_vertical(ent:get_look_vertical() + math.random(-math.pi / 16, math.pi / 16))
                        end
                        if n - 1 <= 0 then return end
                        minetest.after(0.05,
                            function(ent) return snap(ent, n - 1) end, ent)
                    end
                    snap(playerref, 5)
                end
            end
        end,
        _mcl_toollike_wield = true,
    })
minetest.register_alias("scp:taser", "bear:taser")
