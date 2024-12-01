local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 1",
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
if 1 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_1", def)