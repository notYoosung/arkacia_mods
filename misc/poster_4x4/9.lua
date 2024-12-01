local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 9",
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
if 9 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_9", def)