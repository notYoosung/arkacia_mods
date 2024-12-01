local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 11",
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
if 11 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_11", def)