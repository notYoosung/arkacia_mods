entity_modifier = {}


entity_modifier.player_original_disguise_properties = {}
local player_clipboard = {}


local player_initial_properties = {}

minetest.register_on_leaveplayer(function(player)
    local player_name = player:get_player_name()
    player_clipboard[player_name] = nil
    player_initial_properties[player_name] = nil
end)

function entity_modifier.reset_player_model(player_name, player)
    local player_properties = player_initial_properties[player_name]
    if not player_properties then
        minetest.chat_send_player(player_name, "Nothing to reset for " .. player_name)
        return
    end
    player_properties.nametag = ""
    player:set_properties(player_properties)
    entity_modifier.player_original_disguise_properties[player_name] = nil
    player_initial_properties[player_name] = nil
    minetest.chat_send_player(player_name, "Your player model is reset to the default: " .. player_name)
    return player_properties
end

function entity_modifier.get_node_disguise(node_def)
    local model_properties = {}

    if node_def.drawtype == "normal"
        or node_def.drawtype == "liquid"
        or node_def.drawtype == "glasslike"
        or node_def.drawtype == "allfaces"
        or node_def.drawtype == "allfaces_optional" then
        model_properties.textures = {}
        local last_texture
        for i = 1, 6 do
            if node_def.tiles[i] then
                last_texture = node_def.tiles[i].name or node_def.tiles[i]
            end
            model_properties.textures[i] = last_texture
        end

        local collisionbox = { -0.5, -0.5-0.5, -0.5, 0.5, 0.5-0.5, 0.5 }
        model_properties.visual = "cube"
        model_properties.collisionbox = collisionbox
        model_properties.selectionbox = collisionbox
        model_properties.collide_with_objects = node_def.collide_with_objects
        if model_properties.collide_with_objects == nil then
            model_properties.collide_with_objects = not true
        end
    elseif node_def.drawtype == "airlike" then
        model_properties.visual_size = { x = 0, y = 0 }
        return model_properties
    else
        model_properties = {
            visual = "upright_sprite",
            textures = node_def.tiles,
            collisionbox = model_properties.collisionbox or { -0.3, 0.0, -0.3, 0.3, 0.6, 0.3 },
            selectionbox = model_properties.selectionbox,
        }
    end
    entity_modifier.get_entity_properties_with_defaults(model_properties, "")
    model_properties.nametag_color = { a = 0, r = 0, g = 0, b = 0 }
    model_properties.eye_height = 0.5

    return model_properties
end

function entity_modifier.get_entity_properties_with_defaults(properties, player_name)
    if not properties then return end
    properties.nametag = player_name
    properties.automatic_rotate = properties.automatic_rotate or 0
    properties.visual_size = properties.visual_size or { x = 1, y = 1 }

    return properties
end

function entity_modifier.disguise_player(player, model_name, model_properties)
    player:move_to(vector.add(player:get_pos(), { x = 0, y = 0.5, z = 0 }))

    if (model_properties.hp_max or 1) < minetest.PLAYER_MAX_HP_DEFAULT then
        model_properties.hp_max = minetest.PLAYER_MAX_HP_DEFAULT
    end
    if model_properties.nametag == "" then
        model_properties.nametag_color = { a = 0, r = 0, g = 0, b = 0 }
    end

    local player_name = player:get_player_name()

    if not player_initial_properties[player_name] then
        player_initial_properties[player_name] = entity_modifier.get_entity_properties_with_defaults(
            player:get_properties(), player_name
        )
    end
    player:set_properties(model_properties)
    entity_modifier.player_original_disguise_properties[player_name] = model_properties

    minetest.chat_send_player(player_name, "Disguised to " .. model_name)
end

function entity_modifier.copy_to_or_clear_clipboard(player_name, object_name, properties)
    local copied_model = player_clipboard[player_name]
    if copied_model and object_name == copied_model.name then
        player_clipboard[player_name] = nil
        minetest.chat_send_player(player_name, "Clipboard cleared")
    else
        player_clipboard[player_name] = { name = object_name, properties = properties }
        minetest.chat_send_player(player_name, "Model copied: " .. object_name)
    end
end

function entity_modifier.disguise_tool_primary(_, player, pointed_object)
    local player_name = player:get_player_name()
    if not minetest.check_player_privs(player, { disguise = true }) then
        minetest.chat_send_player(player_name, "You have not the `disguise` permission")
        return
    end

    if pointed_object.type == "node" then
        local node_name = minetest.get_node(pointed_object.under).name
        local node_def = minetest.registered_nodes[node_name]
        if node_def then
            entity_modifier.copy_to_or_clear_clipboard(
                player_name,
                node_name,
                entity_modifier.get_node_disguise(node_def)
            )
        else
            minetest.chat_send_player(
                player_name,
                "Not existing node: " .. node_name
            )
        end
    elseif pointed_object.type == "object" then
        local copied_model = player_clipboard[player_name]

        local name = pointed_object.ref:get_player_name() or ""
        local luaentity = pointed_object.ref:get_luaentity()
        if luaentity then name = luaentity.name end

        if not copied_model then
            local properties = entity_modifier.get_entity_properties_with_defaults(
                pointed_object.ref:get_properties(),
                pointed_object.ref:get_player_name()
            )
            if not properties then
                minetest.chat_send_player(player_name, "Not existing entity")
                return
            end

            player_clipboard[player_name] = {
                name = name,
                properties = properties,
            }
            minetest.chat_send_player(player_name, "Model copied: " .. name)
            return
        end


        if next(copied_model) == nil then
            if pointed_object.ref:is_player() then
                entity_modifier.reset_player_model(name, pointed_object.ref)
            else
                pointed_object.ref:set_properties(
                    entity_modifier.get_entity_properties_with_defaults(luaentity)
                )
                minetest.chat_send_player(player_name, "Entity model reset: " .. name)
            end
            return
        elseif pointed_object.ref:is_player() then
            entity_modifier.disguise_player(pointed_object.ref, name, copied_model.properties)
        else
            pointed_object.ref:set_properties(copied_model.properties)
            if luaentity.on_step then
                pointed_object.ref:set_properties({ physical = true })
            end
            pointed_object.ref:move_to(vector.add(pointed_object.ref:get_pos(), { x = 0, y = 1, z = 0 }))
        end
        minetest.chat_send_player(player_name, "Entity " .. name .. " disguised to " .. copied_model.name)
    elseif pointed_object.type == "nothing" then
        entity_modifier.copy_to_or_clear_clipboard(
            player_name,
            "air",
            { visual_size = { x = 0, y = 0 } }
        )
    else
        minetest.chat_send_player(
            player_name,
            "Not supported type yet: " .. pointed_object.type
        )
    end
end

function entity_modifier.get_model_properties(player_name, model_name)
    local node = minetest.registered_nodes[model_name]
    if node then
        return entity_modifier.get_node_disguise(node)
    end

    local model_properties = minetest.registered_entities[model_name]
    if model_properties then
        return model_properties
    end

    model_properties = minetest.get_player_by_name(model_name)
    if model_properties then
        return model_properties
    end

    minetest.chat_send_player(player_name, "Unsupported model name: " .. model_name)
end

function entity_modifier.disguise_to_model(player_name, model_name, doer_name)
    doer_name = doer_name or player_name

    local player = minetest.get_player_by_name(player_name)
    if not player then
        minetest.chat_send_player(doer_name, "Invalid player name: " .. player_name)
    end


    entity_modifier.resize_player(player)
    local model_properties

    if not model_name or model_name == "" then
        local clipboard_model = player_clipboard[doer_name]
        if clipboard_model then
            model_name = clipboard_model.name
            model_properties = clipboard_model.properties
        else
            entity_modifier.reset_player_model(player_name, player)
            if doer_name ~= player_name then
                minetest.chat_send_player(doer_name, "Player model reset")
            end
            return
        end
    end

    model_properties = model_properties or entity_modifier.get_model_properties(doer_name, model_name)
    if model_properties then
        entity_modifier.disguise_player(
            player,
            model_name,
            model_properties
        )
        minetest.chat_send_player(doer_name, "Player " .. player_name .. " is disguised to " .. model_name)
    end
end

local function get_clipboard(name)
    local clipboard = player_clipboard[name]
    if clipboard then return clipboard end
    minetest.chat_send_player(name, "Clipboard is empty")
end

minetest.register_privilege("clipboard_edit", {
    description = "Can edit clipboard properties"
})

minetest.register_chatcommand("clipboard", {
    params = "clipboard [<object_or_property>]",
    description = "Modify or show the clipboard",
    func = function(name, arg)
        local message

        local first_char = arg:sub(1, 1)
        if first_char == "" then
            local clipboard = get_clipboard(name)
            if clipboard then
                message = "Model in clipboard: " .. clipboard.name
            end
        elseif first_char == "*" then
            player_clipboard[name] = {}
            minetest.chat_send_player(name, "Reset mode enabled")
        elseif first_char == "." then
            local clipboard = get_clipboard(name)
            if not clipboard then return end

            local found, _, property, value_string = arg:find('^.([^=]+)=(.+)$')

            if found then
                local value
                if value_string == "true" then
                    value = true
                elseif value_string == "false" then
                    value = false
                else
                    _, value = value_string:find('^"([^"]+)"$')
                    value = value or tonumber(value_string)
                end

                if not minetest.check_player_privs(name, { clipboard_edit = true }) then
                    message = "You have not the `clipboard_edit` permission"
                elseif value == nil then
                    message = "Invalid value: " .. value_string
                else
                    clipboard.properties[property] = value
                    message = "Clipboard value for " .. property .. " changed to " .. value_string
                end
            else
                property = arg:sub(2)
                local value = clipboard.properties[property]
                if value then
                    message = "Clipboard value for " .. property .. ": " .. value
                else
                    message = "No such value in clipboard value for " .. property
                end
            end
        elseif arg == '""' then
            player_clipboard[name] = nil
            message = "Clipboard cleared."
        else
            local properties = entity_modifier.get_model_properties(name, arg)
            if properties then
                player_clipboard[name] = { name = arg, properties = properties }
                message = "Model copied to clipboard: " .. arg
            end
        end

        if message then
            minetest.chat_send_player(name, message)
        end
    end
})

minetest.register_privilege("disguiseme", {
    description = "Can disguise itself"
})

minetest.register_chatcommand("disguiseme", {
    params = "disguiseme [<object>]",
    description = "disguise you to another object",
    privs = { disguiseme = true },
    func = entity_modifier.disguise_to_model
})

minetest.register_privilege("disguise", {
    description = "Can disguise players"
})

minetest.register_chatcommand("disguise", {
    params = "disguise <name> [<object>]",
    description = "disguise a player to another object",
    privs = { disguise = true },
    func = function(name, params)
        local args = params:split(" ")
        local player_name = args[1]
        if not player_name then
            minetest.chat_send_player(name, "Invalid usage: " .. params)
            return
        end

        entity_modifier.disguise_to_model(player_name, args[2], name)
    end
})

function entity_modifier.disguise_tool_secondary(_, player, _)
    local player_name = player:get_player_name()
    local copied_model = player_clipboard[player_name]
    if copied_model and next(copied_model) ~= nil then
        entity_modifier.disguise_player(player, copied_model.name, copied_model.properties)
    elseif player_initial_properties[player_name] then
        entity_modifier.reset_player_model(player_name, player)
    else
        player_clipboard[player_name] = {
            name = player_name,
            properties = entity_modifier.get_entity_properties_with_defaults(
                player:get_properties(),
                player_name
            )
        }
        minetest.chat_send_player(player_name, "Model copied to clipboard: " .. player_name)
    end
end

minetest.register_tool(":arkacia:entity_modifier_disguise_wand", {
    description = "Disguise Wand",
    inventory_image = "default_stick.png",
    liquids_pointable = true,

    on_use = entity_modifier.disguise_tool_primary,

    on_place = entity_modifier.disguise_tool_secondary,

    on_secondary_use = entity_modifier.disguise_tool_secondary
})

minetest.register_privilege("list_models", {
    description = "List all entity models"
})

minetest.register_chatcommand("list_models", {
    params = "list_models [<namespace>]",
    description = "list available entity models",
    privs = { list_models = true },
    func = function(name, namespace)
        local model_names = ""
        for _, model in pairs(minetest.registered_entities) do
            if namespace == "" or model.name:sub(1, #namespace) == namespace then
                model_names = model_names .. " " .. model.name
            end
        end
        minetest.chat_send_player(name, "Available entity model names:" .. model_names)
    end
})
local player_sizes = {}

minetest.register_on_joinplayer(function(player)
    local size = player_sizes[player:get_player_name()]
    if size == nil then
        player_sizes[player:get_player_name()] = 1
    else
        entity_modifier.resize_player(player, size)
    end
end)

minetest.register_on_leaveplayer(function(player)
    player_sizes[player:get_player_name()] = nil
end)

minetest.register_on_respawnplayer(function(player)
    entity_modifier.resize_player(player, player_sizes[player:get_player_name()])
end)

entity_modifier.resize_player = function(player, size)
    local player_name = player:get_player_name()
    size = size or 1
    player_sizes[player_name] = size


    if size < 0 or size > 80 then
        minetest.chat_send_player(player_name, "Invalid size: " .. size)
        return
    end

    local model = mcl_player.player_get_animation(player).model

    local default_properties =
        entity_modifier.player_original_disguise_properties[player_name] or
        model

    local jump = 1


    if size == 1 then
        player:set_eye_offset(
            { x = 0, y = 0, z = 0 },
            { x = 0, y = 0, z = 0 }
        )
    elseif size < 1 then
        player:set_eye_offset(
            { x = 0, y = 0, z = 0 },
            { x = 0, y = 0, z = math.floor(5.5 - size * 5) }
        )
    else
        player:set_eye_offset(
            { x = 0, y = 0, z = 0 },
            { x = 0, y = size * 5, z = -size }
        )
        if size >= 4 then
            jump = 2
        end
    end
    player:set_physics_override({ jump = jump })

    local new_properties = {}


    if default_properties.collisionbox then
        for i, v in ipairs(default_properties.collisionbox) do
            default_properties.collisionbox[i] = v * size
        end
    end

    if default_properties.selectionbox then
        for i, v in ipairs(default_properties.selectionbox) do
            default_properties.selectionbox[i] = v * size
        end
    end
    if default_properties.eye_height then
        new_properties.eye_height = default_properties.eye_height * size
    end
    new_properties.visual_size = { x = size, y = size }

    player:set_properties(new_properties)
end

minetest.register_privilege("resize", {
    description = "Can resize players"
})

minetest.register_chatcommand("resize", {
    params = "resize <name> [<size>]",
    description = "resize a player size (0.0 to 80)",
    privs = { resize = true },
    func = function(name, params)
        local args = params:split(" ")
        local player_name = args[1]
        if not player_name then
            minetest.chat_send_player(name, "Invalid usage: " .. params)
            return
        end

        local player = minetest.get_player_by_name(player_name)
        if player then
            entity_modifier.resize_player(player, tonumber(args[2]))
        else
            minetest.chat_send_player(name, "Invalid player name: " .. player_name)
        end
    end
})

minetest.register_privilege("resizeme", {
    description = "Can resize itself"
})

minetest.register_chatcommand("resizeme", {
    params = "resizeme [<size>]",
    description = "resize your player size (0.0 to 80)",
    privs = { resizeme = true },
    func = function(player_name, size_string)
        entity_modifier.resize_player(
            minetest.get_player_by_name(player_name),
            tonumber(size_string)
        )
    end
})


minetest.register_on_leaveplayer(function(player)
    entity_modifier.player_original_disguise_properties[player:get_player_name()] = nil
end)
