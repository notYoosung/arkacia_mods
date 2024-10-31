local S = minetest.get_translator(minetest.get_current_modname())

-- Spawn a stand entity
local function spawn_stand_entity(pos, node)
    local luaentity = minetest.add_entity(pos, "scp:scp_173_entity"):get_luaentity()
    if luaentity then
        luaentity:update_rotation(node or minetest.get_node(pos))
        return luaentity
    end
end

-- Find a stand entity or spawn one
local function get_stand_entity(pos, node)
    for obj in minetest.objects_inside_radius(pos, 0) do
        local luaentity = obj:get_luaentity()
        if luaentity and luaentity.name == "scp:scp_173_entity" then
            return luaentity
        end
    end
    return spawn_stand_entity(pos, node)
end

-- Migrate the old inventory format
local function migrate_inventory(inv)
    inv:set_size("armor", 5)
    local lists = inv:get_lists()
    for name, element in pairs(mcl_armor.elements) do
        local listname = "armor_" .. name
        local list = lists[listname]
        if list then
            inv:set_stack("armor", element.index, list[1])
            inv:set_size(listname, 0)
        end
    end
end

-- Drop all armor on the ground when it got destroyed
local function drop_inventory(pos)
    local inv = minetest.get_meta(pos):get_inventory()
    for _, stack in pairs(inv:get_list("armor")) do
        if not stack:is_empty() then
            local p = { x = pos.x + math.random(0, 10) / 10 - 0.5, y = pos.y, z = pos.z + math.random(0, 10) / 10 - 0.5 }
            minetest.add_item(p, stack)
        end
    end
end

-- TODO: The armor stand should be an entity
minetest.register_node(":scp:scp_173_stand", {
    description = S("Armor Stand"),
    _tt_help = S("Displays pieces of armor"),
    _doc_items_longdesc = S(
    "An armor stand is a decorative object which can display different pieces of armor. Anything which players can wear as armor can also be put on an armor stand."),
    _doc_items_usagehelp = S(
    "Just place an armor item on the armor stand. To take the top piece of armor from the armor stand, select your hand and use the place key on the armor stand."),
    drawtype = "mesh",
    mesh = "3d_armor_stand.obj",
    inventory_image = "3d_armor_stand_item.png",
    wield_image = "3d_armor_stand_item.png",
    tiles = { "default_wood.png", "mcl_stairs_stone_slab_top.png" },
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    is_ground_content = false,
    stack_max = 16,
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, 1.4, 0.5 }
    },
    -- TODO: This should be breakable by 2 quick punches
    groups = { handy = 1, deco_block = 1, dig_by_piston = 1, attached_node = 1 },
    _mcl_hardness = 2,
    sounds = mcl_sounds.node_sound_wood_defaults(),
    on_construct = function(pos)
        spawn_stand_entity(pos)
    end,
    on_destruct = function(pos)
        drop_inventory(pos)
    end,
    on_rightclick = function(pos, node, clicker, itemstack, _)
        local protname = clicker:get_player_name()

        if minetest.is_protected(pos, protname) then
            minetest.record_protection_violation(pos, protname)
            return itemstack
        end

        return mcl_armor.equip(itemstack, get_stand_entity(pos, node).object, true)
    end,
    on_rotate = function(pos, node, _, mode)
        if mode == screwdriver.ROTATE_FACE then
            node.param2 = (node.param2 + 1) % 4
            minetest.swap_node(pos, node)
            get_stand_entity(pos, node):update_rotation(node)
            return true
        end
        return false
    end,
})

minetest.register_entity("scp:scp_173_entity", {
    initial_properties = {
        physical = true,
        visual = "mesh",
        mesh = "3d_armor_stand.obj",
        textures = { "default_wood.png", "mcl_stairs_stone_slab_top.png" },
        visual_size = { x = 1, y = 1 },
        collisionbox = { -0.1, -0.4, -0.1, 0.1, 1.3, 0.1 },
        pointable = false,
        timer = 0,
        static_save = false,
    },
    _mcl_fishing_hookable = true,
    _mcl_fishing_reelable = true,
    on_activate = function(self)
        self.object:set_armor_groups({ immortal = 1 })
        self.node_pos = vector.round(self.object:get_pos())
        self.inventory = minetest.get_meta(self.node_pos):get_inventory()
        migrate_inventory(self.inventory)
        mcl_armor.update(self.object)
    end,
    on_step = function(self)
        if minetest.get_node(self.node_pos).name ~= "scp:scp_173_stand" then
            self.object:remove()
        end
    end,
    update_armor = function(self, info)
        self.object:set_properties({ textures = { info.texture } })
    end,
    update_rotation = function(self, node)
        self.object:set_yaw(minetest.dir_to_yaw(minetest.facedir_to_dir(node.param2)))
    end,
})

minetest.register_lbm({
    label = "Respawn armor stand entities",
    name = "scp:respawn_scp_173_entities",
    nodenames = { "scp:scp_173_stand" },
    run_at_every_load = true,
    action = function(pos, node)
        spawn_stand_entity(pos, node)
    end,
})


mcl_player.register_globalstep_slow(function(player)
	local pos = player:get_pos()
    local roundedlookdir = math.round(minetest.get_player_by_name("singleplayer"):get_look_horizontal()*180/math.pi/90)*90

end)


local function in_view(ob1, ob2)
    local p1 = ob1:get_pos()
    local a = vector.normalize(vector.subtract(ob2:get_pos(), p1))
    local b
    if ob1:get_luaentity() then
        local yaw = math.floor(ob1:get_yaw() * 100) / 100
        b = { x = math.sin(yaw) * -1, y = 0, z = math.cos(yaw) * 1 }
    elseif ob1:is_player() then
        b = ob1:get_look_dir()
    else
        return false
    end
    local deg = math.acos((a.x * b.x) + (a.y * b.y) + (a.z * b.z)) * (180 / math.pi)
    return not (deg < 0 or deg > 50) --45 ... cuz minetest is using a somewhat wide screen size
end

minetest.register_abm({
    nodenames = { "scp:scp_173_stand" },
    interval = 1, -- Run every 10 seconds
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        -- local objs = minetest.get_objects_inside_radius(pos, 30)
        -- for _, obj in ipairs(objs) do
        --     if obj:is_player() then
        --         if not minetest.raycast(obj:get_pos(), pos, false, false) then
        --             minetest.chat_send_all("true")
        --         else
        --             minetest.chat_send_all("false")
        --         end
        --     else
                minetest.chat_send_all("nonplayer")
        --     end
        -- end
    end
})



















--MCmobs v0.2
--maikerumine
--made for MC like Survival game
--License for code WTFPL and otherwise stated in readmes

local S = minetest.get_translator("mobs_mc")

--###################
--################### SHULKER
--###################

local adjacents = {
    vector.new(1, 0, 0),
    vector.new(-1, 0, 0),
    vector.new(0, 1, 0),
    vector.new(0, -1, 0),
    vector.new(0, 0, 1),
    vector.new(0, 0, -1),
}
local function check_spot(pos)
    pos = vector.offset(pos, 0, 0.5, 0)
    local n = minetest.get_node(pos)
    if n.name ~= "air" then return false end
    for _, a in pairs(adjacents) do
        local p = vector.add(pos, a)
        local pn = minetest.get_node(p)
        if minetest.get_item_group(pn.name, "solid") > 0 then return true end
    end
    return false
end
local pr = PseudoRandom(os.time() * (-334))

local messy_textures = {
    grey = "mobs_mc_shulker_gray.png",
}

local function set_shulker_color(self, color)
    local tx = "mobs_mc_shulker_" .. color .. ".png"
    if messy_textures[color] then tx = messy_textures[color] end
    self.object:set_properties({
        textures = { tx },
    })
    self._color = color
end

-- animation 45-80 is transition between passive and attack stance
mcl_mobs.register_mob(":scp:scp_173", {
    description = "SCP 173",
    type = "monster",
    spawn_class = "hostile",
    persist_in_peaceful = true,
    attack_type = "dogfight",
    passive = false,
    hp_min = 100,
    hp_max = 100,
    xp_min = 0,
    xp_max = 0,
    armor = 1000,
    collisionbox = { -0.5, -0.5, -0.5, 0.5, 1.4, 0.5 },
    visual = "mesh",
    mesh = "3d_armor_stand.obj",
    textures = { "default_wood.png", "mcl_stairs_stone_slab_top.png" },
    pushable = false,
    mob_pushable = false,
    visual_size = { x = 3, y = 3 },
    walk_chance = 100,
    knock_back = false,
    jump = false,
    can_despawn = false,
    --fall_speed = 0,
    does_not_prevent_sleep = true,
    drops = {
    },
    view_range = 32,
    fear_height = 0,
    walk_velocity = 100,
    run_velocity = 100,
    _mcl_fishing_hookable = true,
    _mcl_fishing_reelable = false,
    do_teleport = function(self, target)
        if target ~= nil then
            local target_pos = target:get_pos()
            -- Find all solid nodes below air in a 10×10×10 cuboid centered on the target
            local nodes = minetest.find_nodes_in_area_under_air(vector.subtract(target_pos, 5), vector.add(target_pos, 5),
                { "group:solid", "group:cracky", "group:crumbly" })
            local telepos
            if nodes ~= nil then
                if #nodes > 0 then
                    -- Up to 64 attempts to teleport
                    for _ = 1, math.min(64, #nodes) do
                        local r = pr:next(1, #nodes)
                        local nodepos = nodes[r]
                        local tg = vector.offset(nodepos, 0, 0.5, 0)
                        if check_spot(tg) then
                            telepos = tg
                        end
                    end
                    if telepos then
                        self.object:set_pos(telepos)
                    end
                end
            end
        else
            local pos = self.object:get_pos()
            -- Up to 8 top-level attempts to teleport
            for _ = 1, 8 do
                local node_ok = false
                -- We need to add (or subtract) different random numbers to each vector component, so it couldn't be done with a nice single vector.add() or .subtract():
                local randomCube = vector.new(pos.x + 8 * (pr:next(0, 16) - 8), pos.y + 8 * (pr:next(0, 16) - 8),
                    pos.z + 8 * (pr:next(0, 16) - 8))
                local nodes = minetest.find_nodes_in_area_under_air(vector.subtract(randomCube, 4),
                    vector.add(randomCube, 4), { "group:solid", "group:cracky", "group:crumbly" })
                if nodes ~= nil then
                    if #nodes > 0 then
                        -- Up to 8 low-level (in total up to 8*8 = 64) attempts to teleport
                        for _ = 1, math.min(8, #nodes) do
                            local r = pr:next(1, #nodes)
                            local nodepos = nodes[r]
                            local tg = vector.offset(nodepos, 0, 0.5, 0)
                            if check_spot(tg) then
                                self.object:set_pos(tg)
                                node_ok = true
                                break
                            end
                        end
                    end
                end
                if node_ok then
                    break
                end
            end
        end
    end,
})

mcl_mobs.register_egg(":scp:scp_173", "SCP 173", "#946694", "#4d3852", 0)
