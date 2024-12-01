local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 5",
    drawtype = "nodebox",
    tiles = {
        { name = texture },
        { name = texture },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
        { name = "blank.png" },
    },
    use_texture_alpha = "clip",
    node_box = fbox,
    collision_box = fbox,
    groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3, not_in_creative_inventory = 1, },
    selection_box = fbox,
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    node_placement_prediction = "",
    inventory_image = texture,
}
if 5 == 1 then
    local function rad_to_param2(rad)
        local tau = math.pi * 2
        if rad < tau * 7 / 8 and rad >= tau * 5 / 8 then
            return 2
        elseif rad < tau * 5 / 8 and rad >= tau * 3 / 8 then
            return 5
        elseif rad < tau * 3 / 8 and rad >= tau * 1 / 8 then
            return 3
        else
            return 4
        end
    end
    table.update(def, {
        description = "Arkacia 1.0 News - New Spawn (4x4) - Top Left",
        groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3, not_in_creative_inventory = 0, },
        on_place = function(itemstack, placer, pointed_thing)
            local under = pointed_thing.under
            local player_name = placer and placer:get_player_name() or ""

            local rc = mcl_util.call_on_rightclick(itemstack, placer, pointed_thing)
            if rc then return rc end

            local pos
            local undername = minetest.get_node(under).name
            if minetest.registered_items[undername] and minetest.registered_items[undername].buildable_to then
                pos = under
            else
                pos = pointed_thing.above
            end


            local dir = placer and placer:is_player() and placer:get_look_dir() and
                rad_to_param2(placer:get_look_horizontal()) or 0

            local pos_list = {}
            local pln = 1
            for a = 0, 3 do
                for b = 0, 3 do
                    pos_list[pln] = {x=a, y=b}
                    pln = pln + 1
                end
            end
            for i, p in pairs(pos_list) do
                local botpos = vector.add(pos,
                    vector.rotate_around_axis(vector.new(p.x, -p.y, 0), vector.new(0, 1, 0),
                        math.round(placer:get_look_horizontal() / (math.pi / 2)) * (math.pi / 2)))

                if minetest.is_protected(botpos, player_name) and
                    not minetest.check_player_privs(player_name, "protection_bypass") then
                    minetest.record_protection_violation(botpos, player_name)
                    goto continue
                end

                local botdef = minetest.registered_nodes[minetest.get_node(botpos).name]
                if not botdef or not botdef.buildable_to then
                    goto continue
                end

                minetest.set_node(botpos, { name = "arkacia:poster_arkacia_news_1_0_4x4_" .. i, param2 = dir })
                ::continue::
            end

            if not minetest.is_creative_enabled(player_name) then
                itemstack:take_item()
            end
            return itemstack
        end,
    })
end
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_5", def)