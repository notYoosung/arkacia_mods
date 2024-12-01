local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 13",
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
if 13 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_13", def)