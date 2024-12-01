local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 10",
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
if 10 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_10", def)