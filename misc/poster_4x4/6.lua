local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 6",
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
if 6 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_6", def)