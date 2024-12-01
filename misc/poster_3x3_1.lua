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
local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
minetest.register_node(":arkacia:poster_arkacia_news_1_0_3x3_1", {
    description = "Arkacia 1.0 News - New Spawn (3x3) - Top Left",
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
    groups = { oddly_breakable_by_hand = 1, z_item = 1, dig_immediate = 3 },
    selection_box = fbox,
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    node_placement_prediction = "",
    inventory_image = texture,
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

        local pos_list = {
            vector.new(0,  0, 0),
            vector.new(1,  0, 0),
            vector.new(2,  0, 0),
            vector.new(0, -1, 0),
            vector.new(1, -1, 0),
            vector.new(2, -1, 0),
            vector.new(0, -2, 0),
            vector.new(1, -2, 0),
            vector.new(2, -2, 0),
        }
        for i, p in ipairs(pos_list) do
            local botpos = vector.add(pos,
                vector.rotate_around_axis(p, vector.new(0, 1, 0),
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

            minetest.set_node(botpos, { name = "arkacia:poster_arkacia_news_1_0_3x3_" .. i, param2 = dir })
            ::continue::
        end

        if not minetest.is_creative_enabled(player_name) then
            itemstack:take_item()
        end
        return itemstack
    end,
})
