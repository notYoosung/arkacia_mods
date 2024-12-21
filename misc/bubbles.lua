if not vector.random_direction then
    function vector.random_direction()
        local x, y, z, l2
        repeat
            x, y, z = math.random() * 2 - 1, math.random() * 2 - 1, math.random() * 2 - 1
            l2 = x * x + y * y + z * z
        until l2 <= 1 and l2 >= 1e-6
        local l = math.sqrt(l2)
        return vector.new(x / l, y / l, z / l)
    end
end

local blank = "blank.png^[png:"
local textures = {
    bubble_block = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAkUlEQVQ4EcWTMQ6AIAxFuZrn4za4OgBuBN3VM+gVMN9YtEwNGh1+SAj/9Reo6luX5jBljXZIJG9s4HLaGy4Fc+xiUyPAGGBb1gShqgTIADBKTPczBwD9YvMxQBqbJ7BB1RgJAu+/ANzfowRvAZymS5Gu9ORngg8BqEzVkRZzpPAdpdHLcxkACNc1xuizFI0/PDvSlb17TsQobgAAAABJRU5ErkJggg==",
    bubble_block_pop = "iVBORw0KGgoAAAANSUhEUgAAABAAAABwCAYAAAAXB/A7AAAACXBIWXMAAC4jAAAuIwF4pT92AAAAH3pUWHRUaXRsZQAACJlLKk1KykmNT8rJT86OL8gvAAA23AaFS1ypqAAAApJJREFUWAntlk1u20AMhe2iy6ILHyDIumfI7dszdNsme3tRZO+arj/2DedHlFRERhEDBkck583jIzXQ/nw+79b8PqzZbHtXA3yMDF6+/Tx/+vL56n79/iuGdw9Pj/vCaRrwf/7647L8+9xax5yiBE42FqfTKaVuAQA1AzocDiXVW5BDyC0AqLm3mU1qCwANZNdpgJ4mKYDeZmNZzUGL+kiTvfVafzpI6mcdwSoAErM2pcEI7D8A6LaR3jPe1Wt8E6boAptiqxDRWmxrBatE7G2OGwH1yyReHvHiiHGeHeB4PF58f26jqc0abwIA1LN6mGuA2l5bcuEAyfw6rUcz+rVujbkG5uwl6Qat3/xVCQxLzXW3Y9A0VkyiBuLF0huwLoCCjdZVCaPkVmw1QPN1RiyGS9++ioW2yNoY26RxW8e4z0FmBgBTEAcgmLF62CIAOwSQxV3gO+EKgOqVwgnHFYB2JfKrlMUl8G4sBnAqtA1Vec5aZ4CqjjxYFKLrSTph6mdt8ZgzvA+4nWCHcEpuCKCJvbVr0EuY8lcAJlAh0g2h5/cSqHd4eVzAYl7BYGqzkalyrEWxNbRtZBm8gsGt3FnGNZi1S5JXM7gTAHorpU0uGbbVJfi1Tl9HvSemc1MwyJRiOcUlDCrWmOgJ+M3XYnlng2T10Z7JPpJAja36iEWrGnkbY9LUMwcWbYRVxnJT31kXMtRjzmINALoTgMxbCOVoV5fgk6jjOTWFmjtrkHjR9DthFkCs355Xa1ABQLN1Wsu3XQnMznYM0KMSkUDWvgP8q1FmKLLKa97bD1J82d6egdZva5/ESC0m9p63K4HWb8cATVxEHHPtO4BM4lzxyL+KyFDgnGWnvgViXL8NLLb9JP4G2KuHIWlpdrAAAAAASUVORK5CYII=",
    bubble_blower = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAHlBMVEX///8AAADopORYX2jZ3+e6yNpzjY05PECisL7///9yQfjMAAAAA3RSTlMAAAD6dsTeAAAAAWJLR0QAiAUdSAAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB+YCFAoWBL8QNY8AAAMcelRYdFJhdyBwcm9maWxlIHR5cGUgeG1wAABIicVWS47bMAzd8xQ9gkxSpHQcJ7Z3Bbrs8ftIJeM4TgYz7aIxICsS9fj4len3z1/0A7+JpZJcZfPmxSYTu1h15WJs1dy6rbIwr9vlctmYsd5NY6W6VF2k6OJFBbLNOmnz2XGwis+6VjW8ASiCQ8yyycpFrt5k9mY4aEsos4lL/LerrS6xR6EBbNS24CHz2PgQTyY7DNYucUI/TnCpTZdaiIPc5rkklVcxXsBnEhVAiEvH2iQmRbqwKF+xyvg3ifOGd4yTCPGSizNGwwiTuDw9fDOPwQIylVXVnkxjys0wr7niKTLDnM3zx6tDitdkPDT3eJIJY2SMy1AARi6O+IRHvMEsaIj9IwtQQKgQCLaenurwECTu+zYRHLY5HBushmMfYxEOPvNNZeseIsyFMF1gSgOfEuTh2nKP1Q6JI/LCAQUU2K5hPA3rQxBjxcEaoQ9ToXUAT2dg5FODJWAEg2NW6GvEb7xPx3cb6LVfdEEJfEdFo6NvALi8MERctbqNkLwGp1foR/CoUEfQIbNVzjTY0sko14AfHqXImaE/dGhkSgVQ+IFrKNnseqqus68KaRRV4VazbYQwUlq4v4GvquMd4FlzDOaLTJQvFq+KRfgD846xYv3yUYXlALtYpEs3877D0hH3BCsJxai497DZcMLZgTm9o/xVaPSjTP/ZLGt8CbgMco85Gm7NRFyR/8Hj5ObwYASE4vjN6sHmIYqZlrNGb5BgbWuGHJ4JySGDtOnRywnUQNo4u6CgIxa0EpMmzThNQ1fMWXSiloY6BA09XXAOrR6BYTESPzGIfIFT7sV7YqB5mzwRoL9l8EwApmk4uY97DH64/gdG9zsvFNDNL7grMzJg5/3p1kCkfDquoS/gtnnoCjPFVX1v5pk/D3UVd+1R3N6mAj3mwr+kAr2IxAMDd+RvHVw/LRymt7X+CBdFgBlgpzBcs3Qionunovet6pNOdftG4W0PCO0RySa75/eLOO4HzzcvZbSe8fMzYYd//jYaO8cPNMovtBrUM4w8Pq7oD7l0Que5cGqFAAAAW0lEQVQI12NggAFGQUFBYWNBATDDxNUQzBB2K2sHM0zTxdMKwIxCQQsII1k4FcwQbjMLB6uxKOsoBDGE08XLweZYFAKNAjKEwwXBDGbTQiijHUwpMLCXQxkwAADk3xDafidc2AAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMi0wMi0yMFQxMDoyMTo0MSswMDowMIrYD4MAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjItMDItMjBUMTA6MjE6NDErMDA6MDD7hbc/AAAAAElFTkSuQmCC",
}
for k, v in pairs(textures) do
    textures[k] = blank .. v
end



local function spawn_pop_particle(pos)
    local pdef = {
        amount = 1,
        pos = pos,
        velocity = { x = 0, y = 0, z = 0 },
        acceleration = { x = 0, y = 0, z = 0 },
        expirationtime = 0.25,
        size = 10,
        collisiondetection = false,
        collision_removal = false,
        object_collision = true,
        vertical = false,
        texture = {
            name = textures.bubble_block_pop,
        },
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 0.5,
        },
        glow = 14,
    }
    minetest.add_particle(pdef)
end


local bubble_colors = {
    "#d3a4f7",
    "#f3c1f0",
    "#a2c0f8",
    "#a2f8df",
}



for i, v in ipairs(bubble_colors) do
    minetest.register_node(":arkacia:bubble_block_" .. i, {
        description = "Bubble Block\nFall Damage: 0%\nBreaks when u stand on it!",
        tiles = { textures.bubble_block .. "^[colorize:" .. bubble_colors[i] .. ":alpha" },
        groups = { dig_immediate = 3, fall_damage_add_percent = -100, },
        sounds = {
            dug = {name = "slimenodes_dug", gain = 0.5},
            place = {name = "slimenodes_place", gain = 0.5},
            footstep = {name = "slimenodes_step", gain = 0.3},
        },
        use_texture_alpha = "blend",
        paramtype = "light",
        is_ground_content = false,
        sunlight_propagates = true,
        on_destruct = function(pos)
            spawn_pop_particle(pos)
        end,
    })
end





local function bubble_blower_primary(itemstack, user, pointed_thing)
    if user and user:get_pos() then
        local look_dir = user:get_look_dir()
        local pos = vector.offset(user:get_pos(), look_dir.x, (user:get_properties().eye_height or 1.625) + look_dir.y, look_dir.z)
        minetest.add_particlespawner({
            amount = 100,
            time = 1,
            minpos = pos,
            maxpos = pos,
            minvel = vector.offset(look_dir, -1, -1, -1),
            maxvel = vector.offset(look_dir, 1, 1, 1),
            minacc = vector.zero(),
            maxacc = vector.multiply(look_dir, 5),
            minexptime = 1,
            maxexptime = 3,
            minsize = 1,
            maxsize = 5,
            collisiondetection = true,
            collision_removal = true,
            object_collision = true,
            glow = 14,
            texture = textures.bubble_block_pop,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 1,
            },
        })
    end
end
local function bubble_blower_secondary(itemstack, user, pointed_thing)
    if pointed_thing then
        local pos
        if pointed_thing.type == "node" then
            pos = pointed_thing.above
        elseif pointed_thing.type == "object" then
            local obj = pointed_thing.ref
            if obj then
                pos = obj:get_pos()
            end
        else
            if user then
                local look_height = user:get_properties().eye_height or 1.625
                pos = vector.add(vector.offset(user:get_pos(), 0, look_height, 0), vector.multiply(user:get_look_dir(), 3))
            end
        end
        if pos then
            local node = minetest.get_node(pos)
            if node and node.name == "air" then
                minetest.place_node(pos, { name = "arkacia:bubble_block_" .. math.ceil(math.random() * 4) }, user)
            end
        end
    end
end
minetest.register_tool(":arkacia:bubble_blower", {
    description = "Bubble blower",
    inventory_image = textures.bubble_blower .. mcl_enchanting.overlay,
    on_use = bubble_blower_primary,
    on_secondary_use = bubble_blower_secondary,
    on_place = bubble_blower_secondary,
})












if not mcl_util._arkacia_buuble_spawner_init then
    local bubbledestroyfunc = function(player)
        local pos = player:get_pos()
        local npos = vector.add(pos, mcl_player.node_offsets.stand)
        local node = minetest.get_node(npos)
        if node and node.name:find("arkacia:bubble_block_") then
            minetest.swap_node(npos, { name = "air" })
            minetest.sound_play({ name = "slimenodes_dug", gain = 0.5 }, { pos = npos })
            spawn_pop_particle(npos)
        end
    end
    table.insert(mcl_player.registered_globalsteps_slow, bubbledestroyfunc)
    mcl_util._arkacia_buuble_spawner_init = true
end

