local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 2",
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
if 2 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_2", def)