local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 3",
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
if 3 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_3", def)