local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 4",
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
if 4 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_4", def)