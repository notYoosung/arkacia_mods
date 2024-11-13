minetest.register_craftitem(":scp:scp_018_spawner",
    {
        description = minetest.colorize("#f00", "SCP-018\nSuper Ball"),
        inventory_image =
        "mcl_colorblocks_concrete_red.png",
        stack_max = 1,
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type == "node" then
                local pos = minetest.get_pointed_thing_position(pointed_thing, true)
                local e = minetest.add_entity(pos, "scp:scp_018", minetest.serialize({ spawn_pos = pos }))
                if placer and not minetest.is_creative_enabled(placer:get_player_name()) then itemstack:take_item() end
                return itemstack
            end
        end,
    })
local function clear_scp_018s(itemstack, placer, pointed_thing)
    local objs = minetest.get_objects_inside_radius(placer:get_pos(), 16)
    for _, v in ipairs(objs) do
        local le = v:get_luaentity()
        if le then
            if le.name == "scp:scp_018" then
                v:remove()
                minetest.chat_send_player(placer:get_player_name(),
                    minetest.colorize("#f00", "[SCP Remover] Eliminated instance of SCP-018."))
            end
        end
    end
end
minetest.register_tool(":scp:scp_018_remover",
    {
        description = minetest.colorize("#f00", "SCP Remover\nSCP-018: Super Ball"),
        inventory_image =
        "mcl_colorblocks_concrete_red.png",
        stack_max = 1,
        on_secondary_use = clear_scp_018s,
        on_place = clear_scp_018s,
        on_use =
            clear_scp_018s,
    })
local max_speed = 30
mcl_death_messages.messages.scp_018 = { plain = "@1 experienced fatal blunt trauma from SCP-018." }
mcl_damage.types.scp_018 = { bypasses_armor = false, bypasses_magic = false, bypasses_invulnerability = false, bypasses_totem = false }
minetest.register_entity(":scp:scp_018",
    {
        initial_properties = { physical = true, hp_max = 9999, armor = { immortal = 1, fleshy = 0 }, collide_with_objects = true, visual_size = { x = 0.25, y = 0.25 }, collisionbox = { -0.25, -0.25, -0.25, 0.25, 0.25, 0.25 }, stepheight = 1, visual = "wielditem", wield_item = "mcl_colorblocks:concrete_red", static_save = true, },
        get_staticdata = function(
            self)
            return minetest.serialize(self.data_to_save)
        end,
        on_activate = function(self, staticdata)
            self.data_to_save = minetest.deserialize(staticdata) or {}
            self.object:set_properties({ mass = 2, friction = 0.0, })
            self.object:set_velocity(vector.multiply(vector.random_direction(), max_speed))
        end,
        on_punch = function(self, clicker)
            local player_dir = clicker:get_look_dir()
            local push_force = 20
            self.object:add_velocity({
                x = player_dir.x * push_force,
                y = player_dir.y * push_force,
                z = player_dir.z *
                    push_force,
            })
        end,
        on_rightclick = function(self, clicker)
            if clicker and clicker:is_player() then
                local inv = clicker:get_inventory()
                local item_to_give = "scp:scp_018_spawner"
                if inv:room_for_item("main", item_to_give) then
                    inv:add_item("main", item_to_give)
                    self.object:remove()
                else
                    minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
                end
            end
        end,
        on_step = function(self, dtime, moveresult)
            local velocity = self.object:get_velocity()
            local change_vec = vector.new(1, 1, 1)
            if moveresult.collides and moveresult.collisions then
                for _, coll in pairs(moveresult.collisions) do change_vec[coll.axis] = -1 end
                if moveresult.collisions[1] then
                    velocity = vector.multiply(moveresult.collisions[1].old_velocity,
                    change_vec)
                end
            end
            local gravity_force = 9.81
            velocity.y = velocity.y - gravity_force * dtime
            velocity = vector.add(velocity, vector.random_direction())
            local rotation = self.object:get_rotation()
            local roll_speed = 1.5
            rotation.x = rotation.x + velocity.x * roll_speed * dtime
            rotation.z = rotation.z + velocity.z * roll_speed * dtime
            self.object:set_velocity(vector.multiply(velocity, 1.0))
            self.object:set_rotation(rotation)
            local pos = self.object:get_pos()
            local players_nearby = minetest.get_objects_inside_radius(pos, 2)
            local speed = vector.length(self.object:get_velocity())
            for _, player in ipairs(players_nearby) do
                if player:is_player() then
                    local player_dir = vector.direction(pos, player:get_pos())
                    local push_force = 10
                    mcl_util.deal_damage(player, 1, { type = "scp_018" })
                    self.object:add_velocity({
                        x = player_dir.x * push_force,
                        y = player_dir.y * push_force,
                        z = player_dir
                            .z * push_force,
                    })
                end
            end
            if speed > max_speed then
                self.object:set_velocity(vector.multiply(vector.normalize(self.object:get_velocity()),
                    max_speed))
            end
            local props = assert(loadstring(self:get_staticdata()))()
            if props and props.spawn_pos then
                if vector.distance(props.spawn_pos, self.object:get_pos()) > 128 then
                    self.object:set_pos(props.spawn_pos)
                    self.object:set_velocity(vector.multiply(vector.random_direction(), max_speed))
                end
            end
        end,
    })
