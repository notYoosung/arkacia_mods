local texture = "blank.png^[png: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"
local fbox = { type = "fixed", fixed = { -8 / 16, -1 / 2, -8 / 16, 8 / 16, -7.5 / 16, 8 / 16 } }
local def = {
    description = "Arkacia 1.0 News - New Spawn (4x4) - 8",
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
if 8 == 1 then
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
minetest.register_node(":arkacia:poster_arkacia_news_1_0_4x4_8", def)