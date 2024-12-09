minetest.register_node(":magikacia:statue_stone",
    {
        description = "Stone Statue",
        drawtype = "mesh",
        mesh = "mcl_armor_character.b3d",
        inventory_image =
        "3d_armor_stand_item.png",
        wield_image = "3d_armor_stand_item.png",
        tiles = { "default_stone.png", "blank.png", "blank.png" },
        paramtype =
        "light",
        paramtype2 = "facedir",
        walkable = false,
        is_ground_content = false,
        stack_max = 16,
        use_texture_alpha =
        "clip",
        selection_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, 1, 0.5 } },
        groups = { handy = 1, deco_block = 1, attached_node = 1, dig_immediate = 3 },
        _mcl_hardness = 2,
        sounds =
            mcl_sounds.node_sound_stone_defaults(),
        on_construct = function(pos) end,
        on_destruct = function(pos) end,
        on_rotate = function(
            pos, node, _, mode)
            if mode == screwdriver.ROTATE_FACE then
                node.param2 = (node.param2 + 1) % 4
                minetest.swap_node(pos, node)
                return true
            end
            return false
        end,
    })



local S = minetest.get_translator("mobs_mc")

local blank = "blank.png^[png:"

local teams = {
    ci = {

    },
    foundation = {

    },
    scp_hostile = {

    },
    scp_safe = {

    },
}
mcl_death_messages.messages.magikacia_statue_stone = { plain = "@1's neck was snapped by SCP-173." }
mcl_damage.types.magikacia_statue_stone = { bypasses_armor = false, bypasses_magic = false, bypasses_invulnerability = false, bypasses_totem = false }
local function register_player_mob(def)
    local mob_def = {
        description = def.description,
        type = "monster",
        spawn_class = "hostile",
        pathfinding = 1,
        hp_min = 20,
        hp_max = 20,
        xp_min = 6,
        xp_max = 6,
        collisionbox = { -0.3, -0.01, -0.3, 0.3, 1.90, 0.3 },
        visual = "mesh",
        mesh = "mcl_armor_character.b3d",
        head_swivel = "head.control",
        bone_eye_height = 2.2,
        head_eye_height = 2.2,
        curiosity = 100,
        textures = { def.texture, "blank.png", "blank.png" },
        visual_size = {
            x = 1,
            y = 1
        },
        makes_footstep_sound = true,
        damage = 13,
        reach = 2,
        walk_velocity = 1.2,
        run_velocity = 1.6,
        attack_type = "dogfight",
        specific_attack = { "player", },
        group_attack = true,
        attack_npcs = true,
        drops = { {
            name = "mcl_core:emerald",
            chance = 0,
            min = 0,
            max = 0,
            looting = "common"
        }, },
        animation = {
            stand_start = 40,
            stand_end = 49,
            stand_speed = 2,
            walk_start = 0,
            walk_end = 39,
            speed_normal = 25,
            run_start = 0,
            run_end = 39,
            speed_run = 50,
            punch_start = 50,
            punch_end = 59,
            punch_speed = 20,
        },
        view_range = 16,
        fear_height = 4
    }
    mcl_mobs.register_mob(":magikacia:player_mob_" .. def.name, mob_def)

    mcl_mobs.register_egg(":magikacia:player_mob_" .. def.name, def.description, "#ccc", "#aaa", 0)
end

register_player_mob({
    name = "statue_stone",
    description = minetest.colorize(mcl_colors.GRAY, "Player Mob: Stone Statue"),
    texture = "default_stone.png",
})
