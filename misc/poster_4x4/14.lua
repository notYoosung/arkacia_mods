local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 14",
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
if 14 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_14", def)