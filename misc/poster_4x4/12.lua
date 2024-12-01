local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 12",
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
if 12 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_12", def)