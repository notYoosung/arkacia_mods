local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 7",
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
if 7 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_7", def)