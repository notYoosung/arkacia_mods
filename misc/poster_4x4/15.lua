local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 15",
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
if 15 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_15", def)