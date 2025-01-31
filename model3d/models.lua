--https://luk3yx.gitlab.io/minetest-formspec-editor/
--mcl_util._arkacia_model3d_init
local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)
local F = minetest.formspec_escape
local C = minetest.colorize

local model3d_on_receive_fields = {}

local function get_model_entity_editor_formspec(defs)
    local le = defs.self
    local props = {
        size_x = 1,
        size_y = 1,
        size_z = 1,
        pos_x = 1,
        pos_y = 1,
        pos_z = 1,
        rot_x = 0,
        rot_y = 0,
        rot_z = 0,
        color_r = 200,
        color_g = 200,
        color_b = 200,
        color_alpha = 255,
        gravity = 0,
    }
    if le then
        local obj = le.object
        local player = defs.player
        local pos = obj:get_pos()
        if pos then
            props.pos_x = pos.x
            props.pos_y = pos.y
            props.pos_z = pos.z
        end
    end
    -- model[<X>,<Y>;<W>,<H>;<name>;<mesh>;<textures>;<rotation>;<continuous>;<mouse control>;<frame loop range>;<animation speed>]
    local grindstone_formspec = table.concat({
        "formspec_version[6]",
        "size[11.75,10.425]",

        "label[0.375,0.375;" .. F(C(mcl_formspec.label_color, S("Repair & Disenchant"))) .. "]",

        mcl_formspec.get_itemslot_bg_v4(2.875, 1.25, 1, 1),
        "list[context;input;2.875,1.25;1,1;]",

        mcl_formspec.get_itemslot_bg_v4(2.875, 2.625, 1, 1),
        "list[context;input;2.875,2.625;1,1;1]",

        "image[2.375,1;2,2.875;grindstone_gui_9.png;2]",

        "image[1.875,1.5;0.5,2.875;grindstone_gui_9.png;2]",
        "image[4.375,1.5;0.5,2.875;grindstone_gui_9.png;2]",

        "image[5.5,1.95;1.5,1;gui_crafting_arrow.png]",

        mcl_formspec.get_itemslot_bg_v4(7.875, 1.9375, 1, 1),
        "list[context;output;7.875,1.9375;1,1;]",

        "label[0.375,4.7;" .. F(C(mcl_formspec.label_color, S("Inventory"))) .. "]",

        mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3),
        "list[current_player;main;0.375,5.1;9,3;9]",

        mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1),
        "list[current_player;main;0.375,9.05;9,1;]",

        "listring[context;output]",
        "listring[current_player;main]",
        "listring[context;input]",
        "listring[current_player;main]",
    })
    local fs = table.concat({
        "formspec_version[6]",
        "size[15,15]",
        "position[0.5,0.5]",
        "label[0,0;Model Entity Editor]",
        "model[0,1;1,1;model3d_display;", (defs.mesh or "model3d_cube.obj"), ";default_dirt.png;1,1;true;true]",
        "field[0,1;8,1;mesh;Mesh;]",
        "button[0,2;8,1;save;Save]",
        "list[current_player;main;0,4;8,4;]",
    }, "")
    return fs
end
local registered_model3d_ents = {}

minetest.register_entity(":model3d:model_entity", {
    initial_properties = {
        visual = "mesh",
        mesh = "model3d_monkey.obj",
        textures = { "blank.png^[colorize:#a4a4a4:255" },
        static_save = true,
        visual_size = { x = 1, y = 1, z = 1 },
        armor = { immortal = 1, },
    },
    on_activate = function(self, staticdata)
        if staticdata ~= "" then
            local data = minetest.deserialize(staticdata)
            if data then
                for k, v in pairs(data) do
                    self[k] = v
                end
            end
            if self.ent_id then
                if registered_model3d_ents[self.ent_id] ~= nil then
                    self.ent_id = #registered_model3d_ents + 1
                end
                registered_model3d_ents[self.ent_id] = self.object
            end
        end
        minetest.log("model entity on_activate: " .. dump(self.textures))
    end,
    on_step = function(self, dtime)
    end,
    on_rightclick = function(self, clicker)
        if clicker and clicker:is_player() then
            local pname = clicker:get_player_name()
            minetest.show_formspec(pname, "model3d:model_entity_editor", get_model_entity_editor_formspec({
                self = self,
                player = clicker,
            }))
        end
    end,
})

model3d_on_receive_fields["model3d:model_entity_editor"] = function(player, formname, fields)
    local ent
    if fields.ent_id then
        local id = tonumber(fields.ent_id)
        if id ~= nil then
            ent = registered_model3d_ents[id]
        end
    end
    if ent and ent:is_valid() then
        local le = ent:get_luaentity()
        if le then
            local default_props = {
                size_x = 1,
                size_y = 1,
                size_z = 1,
                pos_x = 1,
                pos_y = 1,
                pos_z = 1,
                rot_x = 1,
                rot_y = 1,
                rot_z = 1,
                color_r = 200,
                color_g = 200,
                color_b = 200,
                color_alpha = 255,
                gravity = 0,
            }
            for prop_key, prop_val in pairs(default_props) do
                le[prop_key] = fields[prop_key] ~= nil and fields[prop_key] or default_props[prop_key]
            end
            le.textures = { "blank.png^[colorize:#" .. string.format("#%02X%02X%02X", le.color_r, le.color_g, le.color_b) .. ":" .. (le.color_alpha or "255") }
        end
    end
end


local model_list = table.concat({
    "model3d_circle_surface.obj",
    "model3d_circle.obj",
    "model3d_cone.obj",
    "model3d_cube.obj",
    "model3d_cylinder_surface.obj",
    "model3d_cylinder.obj",
    "model3d_iso_sphere.obj",
    "model3d_monkey.obj",
    "model3d_plane.obj",
    "model3d_sphere_surface.obj",
    "model3d_sphere.obj",
    "model3d_text_arkacia.obj",
    "model3d_torus_surface.obj",
    "model3d_torus.obj",
}, ",")



local function get_tool_spawner_spawner_secondary_formspec(def)
    -- model[<X>,<Y>;<W>,<H>;<name>;<mesh>;<textures>;<rotation>;<continuous>;<mouse control>;<frame loop range>;<animation speed>]
    -- textlist[<X>,<Y>;<W>,<H>;<name>;<listelem 1>,<listelem 2>,...,<listelem n>]
    -- dropdown[<X>,<Y>;<W>;<name>;<item 1>,<item 2>, ...,<item n>;<selected idx>;<index event>]
    local fs = table.concat({
        "formspec_version[4]",
        "size[15,15]",
        "position[0.5,0.5]",
        "label[0,0;Model Spawner]",
        "model[1,2;3,3;model3d_display;", (def.mesh ~= nil and def.mesh ~= "" and def.mesh or "model3d_cube.obj"), ";default_dirt.png;1,1;true;true]",
        -- "button[0,2;8,1;save;Save]",
        "dropdown[2.5,6;10;1;", model_list, ";4;false]",
        "list[current_player;main;2.5,10;8,4;]",
    }, "")
    return fs
end

local function tool_model_spawner_primary(itemstack, player, pointed_thing)
    local meta = itemstack:get_meta()
    local mesh = meta:get_string("model3d:mesh")
    local pos
    if pointed_thing.type == "node" then
        pos = pointed_thing.above
    elseif pointed_thing.type == "object" and pointed_thing.ref then
        pos = pointed_thing.ref:get_pos()
    end
    if pos then
        local defs = {
            pos = pos,
        }
        if mesh ~= "" and mesh ~=  nil then
            defs.mesh = mesh
        else
            defs.mesh = "model3d_cube.obj"
            defs.textures = { "default_dirt.png" }
        end
        local ent = minetest.add_entity(pos, "model3d:model_entity", minetest.serialize(defs))
    end
end

local function tool_model_spawner_secondary(itemstack, player, pointed_thing)
    local meta = itemstack:get_meta()
    local mesh = meta:get_string("model3d:mesh")
    minetest.show_formspec(player:get_player_name(), "model3d:tool_model_spawner", get_tool_spawner_spawner_secondary_formspec({
        mesh = mesh == "" and nil or mesh,
    }))
end


minetest.register_tool(":model3d:tool_model_spawner", {
    description = "Model Spawner",
    inventory_image = "model3d_model_spawner.png",
    wield_image = "model3d_model_spawner.png",
    on_use = tool_model_spawner_primary,
    on_secondary_use = tool_model_spawner_secondary,
    on_place = tool_model_spawner_secondary,
})






































model3d = {
    preview_rotations = {},
    player_formspecs = {},
    model_names = {
        "circle_surface",
        "cube",
        "cylinder_surface",
        "iso_sphere",
        "monkey",
        "plane",
        "sphere_surface",
        "text_arkacia",
        "torus_surface",
    },
}
function model3d.get_texture_by_hex(color)
    return "blank.png^[colorize:#" .. color .. ":255"
end

function model3d.show_formspec(player)
    local formspec_data = mcl_skins.player_formspecs[player]
    -- local skin = mcl_skins.player_skins[player]
    local active_tab = formspec_data.active_tab
    local page_num = formspec_data.page_num

    local formspec = "formspec_version[3]size[14.2,11]"

    for i, tab in pairs(mcl_skins.tab_names) do
        if tab == active_tab then
            formspec = formspec ..
                "style[" .. tab .. ";bgcolor=green]"
        end

        local y = 0.3 + (i - 1) * 0.8
        formspec = formspec ..
            "style[" .. tab .. ";content_offset=16,0]" ..
            "button[0.3," .. y .. ";4,0.8;" .. tab .. ";" .. mcl_skins.tab_descriptions[tab] .. "]" ..
            "image[0.4," .. y + 0.1 .. ";0.6,0.6;mcl_skins_icons.png^[verticalframe:11:" .. i - 1 .. "]"

        -- if skin.simple_skins_id then break end
    end


    local mesh = "model3d_cube.obj"
    formspec = formspec ..
        "model[11,0.3;3,7;player_mesh;" .. mesh .. ";" ..
        model3d.get_texture_by_hex("AAAAAA") ..
        ",blank.png,blank.png;0,180;false;true;0,0]"


    --[[for _, model_name in ipairs(model3d.model_names) do
        mesh = "model3d_" .. model_name .. ".obj"
        -- local texture = texture
        -- local scale = scale
        local x = 11.5 + (scale.x - 1) * 0.5
        local y = 0.3 + (scale.y - 1) * 0.5

        formspec = formspec ..
            "model[" .. x .. "," .. y .. ";" .. scale.x .. "," .. scale.y .. ";" .. model_name .. ";" .. mesh .. ";" ..
            texture ..
            ",blank.png,blank.png;0,180;false;true;0,0]"
    end--]]
    --[[if active_tab == "skin" then
        local page_start = (page_num - 1) * 8 - 1
        local page_end = math.min(page_start + 8 - 1, #mcl_skins.simple_skins)
        formspec = formspec ..
            "style_type[button;bgcolor=#00000000]"

        local skin = table.copy(skin)
        local simple_skins_id = skin.simple_skins_id
        skin.simple_skins_id = nil
        mcl_skins.simple_skins[-1] = {
            slim_arms = skin.slim_arms,
            texture = mcl_skins.compile_skin(skin),
        }
        simple_skins_id = simple_skins_id or
            mcl_skins.simple_skins[-1].texture

        for i = page_start, page_end do
            local skin = mcl_skins.simple_skins[i]
            local j = i - page_start - 1
            local mesh = skin.slim_arms and "mcl_armor_character_female.b3d" or
                "mcl_armor_character.b3d"

            local x = 4.5 + (j + 1) % 4 * 1.6
            local y = 0.3 + math.floor((j + 1) / 4) * 3.1

            formspec = formspec ..
                "model[" .. x .. "," .. y .. ";1.5,3;player_mesh;" .. mesh .. ";" ..
                skin.texture ..
                ",blank.png,blank.png;0,180;false;true;0,0]"

            if simple_skins_id == skin.texture then
                formspec = formspec ..
                    "style[" .. i ..
                    ";bgcolor=;bgimg=mcl_skins_select_overlay.png;" ..
                    "bgimg_pressed=mcl_skins_select_overlay.png;bgimg_middle=14,14]"
            end
            formspec = formspec ..
                "button[" .. x .. "," .. y .. ";1.5,3;" .. i .. ";]"
        end

        if page_start == -1 then
            formspec = formspec .. "image[4.85,1;0.8,0.8;mcl_skins_button.png]"
        end
    elseif active_tab == "template" then
        formspec = formspec ..
            "model[5,2;2,3;player_mesh;mcl_armor_character.b3d;" ..
            mcl_skins.compile_skin(mcl_skins.steve) ..
            ",blank.png,blank.png;0,180;false;true;0,0]" ..

            "button[5,5.2;2,0.8;steve;" .. S("Select") .. "]" ..

            "model[7.5,2;2,3;player_mesh;mcl_armor_character_female.b3d;" ..
            mcl_skins.compile_skin(mcl_skins.alex) ..
            ",blank.png,blank.png;0,180;false;true;0,0]" ..

            "button[7.5,5.2;2,0.8;alex;" .. S("Select") .. "]"
    elseif mcl_skins[active_tab] then
        formspec = formspec ..
            "style_type[button;bgcolor=#00000000]"
        local textures = mcl_skins[active_tab]
        local page_start = (page_num - 1) * 16 + 1
        local page_end = math.min(page_start + 16 - 1, #textures)

        for j = page_start, page_end do
            local i = j - page_start + 1
            local texture = textures[j]
            local preview = mcl_skins.masks[skin.base] .. "^[colorize:gray^" .. skin.base
            local color = C(skin[active_tab .. "_color"])
            local mask = mcl_skins.masks[texture]
            if color and mask then
                preview = preview .. "^(" .. mask .. "^[colorize:" .. color .. ":alpha)"
            end
            preview = preview .. "^" .. texture

            local mesh = "mcl_skins_head.obj"
            if active_tab == "top" then
                mesh = "mcl_skins_top.obj"
            elseif active_tab == "bottom" or active_tab == "footwear" then
                mesh = "mcl_skins_bottom.obj"
            end

            local rot_x = -10
            local rot_y = 20
            if mcl_skins.preview_rotations[texture] then
                rot_x = mcl_skins.preview_rotations[texture].x
                rot_y = mcl_skins.preview_rotations[texture].y
            end

            i = i - 1
            local x = 4.5 + i % 4 * 1.6
            local y = 0.3 + math.floor(i / 4) * 1.6
            formspec = formspec ..
                "model[" .. x .. "," .. y ..
                ";1.5,1.5;" .. mesh .. ";" .. mesh .. ";" ..
                preview ..
                ";" .. rot_x .. "," .. rot_y .. ";false;false;0,0]"

            if skin[active_tab] == texture then
                formspec = formspec ..
                    "style[" .. texture ..
                    ";bgcolor=;bgimg=mcl_skins_select_overlay.png;" ..
                    "bgimg_pressed=mcl_skins_select_overlay.png;bgimg_middle=14,14]"
            end
            formspec = formspec .. "button[" .. x .. "," .. y .. ";1.5,1.5;" .. texture .. ";]"
        end
    elseif active_tab == "arm" then
        local x = skin.slim_arms and 5.7 or 4.6
        formspec = formspec ..
            "image_button[4.6,0.3;1,1;mcl_skins_thick_arms.png;thick_arms;]" ..
            "image_button[5.7,0.3;1,1;mcl_skins_slim_arms.png;slim_arms;]" ..
            "style[arm;bgcolor=;bgimg=mcl_skins_select_overlay.png;" ..
            "bgimg_middle=14,14;bgimg_pressed=mcl_skins_select_overlay.png]" ..
            "button[" .. x .. ",0.3;1,1;arm;]"
    end--]]


    --[[if skin[active_tab .. "_color"] then
        local colors = mcl_skins.color
        if active_tab == "base" then colors = mcl_skins.base_color end

        local tab_color = active_tab .. "_color"
        local selected_color = skin[tab_color]
        for i, colorspec in pairs(colors) do
            local color = C(colorspec)
            i = i - 1
            local x = 4.6 + i % 6 * 0.9
            local y = 8 + math.floor(i / 6) * 0.9
            formspec = formspec ..
                "image_button[" .. x .. "," .. y ..
                ";0.8,0.8;blank.png^[noalpha^[colorize:" ..
                color .. ":alpha;" .. colorspec .. ";]"

            if selected_color == colorspec then
                formspec = formspec ..
                    "style[" .. color ..
                    ";bgcolor=;bgimg=mcl_skins_select_overlay.png;bgimg_middle=14,14;" ..
                    "bgimg_pressed=mcl_skins_select_overlay.png]" ..
                    "button[" .. x .. "," .. y .. ";0.8,0.8;" .. color .. ";]"
            end
        end

        if active_tab ~= "base" then
            -- Bitwise Operations !?!?!
            local red = math.floor(selected_color / 0x10000) - 0xff00
            local green = math.floor(selected_color / 0x100) - 0xff0000 - red * 0x100
            local blue = selected_color - 0xff000000 - red * 0x10000 - green * 0x100
            formspec = formspec ..
                "container[10.2,8]" ..
                "scrollbaroptions[min=0;max=255;smallstep=20]" ..

                "box[0.4,0;2.49,0.38;red]" ..
                "label[0.2,0.2;-]" ..
                "scrollbar[0.4,0;2.5,0.4;horizontal;red;" .. red .. "]" ..
                "label[2.9,0.2;+]" ..

                "box[0.4,0.6;2.49,0.38;green]" ..
                "label[0.2,0.8;-]" ..
                "scrollbar[0.4,0.6;2.5,0.4;horizontal;green;" .. green .. "]" ..
                "label[2.9,0.8;+]" ..

                "box[0.4,1.2;2.49,0.38;blue]" ..
                "label[0.2,1.4;-]" ..
                "scrollbar[0.4,1.2;2.5,0.4;horizontal;blue;" .. blue .. "]" ..
                "label[2.9,1.4;+]" ..

                "container_end[]"
        end
    end--]]

    local page_count = 1
    --[[if mcl_skins[active_tab] then
        page_count = math.ceil(#mcl_skins[active_tab] / 16)
    elseif active_tab == "skin" then
        page_count = math.ceil((#mcl_skins.simple_skins + 2) / 8)
    end--]]

    if page_num > 1 then
        formspec = formspec ..
            "image_button[4.5,6.7;1,1;mcl_skins_arrow.png^[transformFX;previous_page;]"
    end

    if page_num < page_count then
        formspec = formspec ..
            "image_button[9.8,6.7;1,1;mcl_skins_arrow.png;next_page;]"
    end

    if page_count > 1 then
        formspec = formspec ..
            "label[7.3,7.2;" .. page_num .. " / " .. page_count .. "]"
    end

    local player_name = player:get_player_name()
    minetest.show_formspec(player_name, "model3d:model_formspec", formspec)
end

function tool_model_formspec_primary(itemstack, user, pointed_thing)
    if not user then return end
    model3d.show_formspec(user)
end

--[[minetest.register_tool(":model3d:tool_model_formspec", {
    description = "Tool Model Formspec",
    on_use = tool_model_formspec_primary,
})]]


if not mcl_util._arkacia_model3d_init then
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if model3d_on_receive_fields[formname] then
            model3d_on_receive_fields[formname](player, formname, fields)
        end
    end)
end

mcl_util._arkacia_model3d_init = true
