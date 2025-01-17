local rotations = {}
local d = 180
local r = d / 2

rotations.facedir = {
	[0] = vector.new(0, 0, 0),
	vector.new( 0,  r,  0),
	vector.new( 0,  d,  0),
	vector.new( 0, -r,  0),

	vector.new( r,  0,  0),
	vector.new( r,  0,  r),
	vector.new( r,  0,  d),
	vector.new( r,  0, -r),

	vector.new(-r,  0,  0),
	vector.new(-r,  0, -r),
	vector.new(-r,  0,  d),
	vector.new(-r,  0,  r),

	vector.new( 0,  0, -r),
	vector.new( 0,  r, -r),
	vector.new( 0,  d, -r),
	vector.new( 0, -r, -r),

	vector.new( 0,  0,  r),
	vector.new( 0,  r,  r),
	vector.new( 0,  d,  r),
	vector.new( 0,  -r,  r),

	vector.new( 0,  0,  d),
	vector.new( 0,  r,  d),
	vector.new( 0,  d,  d),
	vector.new( 0, -r,  d),
}



local gs_interval = 0.5

if not mcl_util.holoschem_render_init then
    
end

local function render_schem()
	if holoschem.render_particlespwaner_ids == nil then
		holoschem.render_particlespwaner_ids = {}
	else
		if type(holoschem.render_particlespwaner_ids) == "table" then
			for _, render_particlespwaner_id in ipairs(holoschem.render_particlespwaner_ids) do
				minetest.delete_particlespawner(render_particlespwaner_id, holoschem.localplayername)
			end
		end
	end
	local particlespawnerdef = {
		-------------------
		-- Common fields --
		-------------------
		-- (same name and meaning in both new and legacy syntax)

		amount = 1,
		-- Number of particles spawned over the time period `time`.

		time = 0,
		-- Lifespan of spawner in seconds.
		-- If time is 0 spawner has infinite lifespan and spawns the `amount` on
		-- a per-second basis.

		collisiondetection = true,
		-- If true collide with `walkable` nodes and, depending on the
		-- `object_collision` field, objects too.

		collision_removal = true,
		-- If true particles are removed when they collide.
		-- Requires collisiondetection = true to have any effect.

		object_collision = false,
		-- If true particles collide with objects that are defined as
		-- `physical = true,` and `collide_with_objects = true,`.
		-- Requires collisiondetection = true to have any effect.

		attached = ObjectRef,
		-- If defined, particle positions, velocities and accelerations are
		-- relative to this object's position and yaw

		vertical = false,
		-- If true face player using y axis only

		texture = "blank.png",
		-- The texture of the particle
		-- v5.6.0 and later: also supports the table format described in the
		-- following section.

		playername = holoschem.localplayername or "",
		-- Optional, if specified spawns particles only on the player's client

		animation = {Tile Animation definition},
		-- Optional, specifies how to animate the particles' texture
		-- v5.6.0 and later: set length to -1 to synchronize the length
		-- of the animation with the expiration time of individual particles.
		-- (-2 causes the animation to be played twice, and so on)

		glow = 14,
		-- Optional, specify particle self-luminescence in darkness.
		-- Values 0-14.

		-- node = {name = "ignore", param2 = 0},
		-- Optional, if specified the particles will have the same appearance as
		-- node dig particles for the given node.
		-- `texture` and `animation` will be ignored if this is set.

		-- node_tile = 0,
		-- Optional, only valid in combination with `node`
		-- If set to a valid number 1-6, specifies the tile from which the
		-- particle texture is picked.
		-- Otherwise, the default behavior is used. (currently: any random tile)
	}

	local player_pos = player:get_pos()
	local schematic = edit.player_data[player].schematic
	local vector_1 = vector.new(1, 1, 1)
	local size = schematic.size
	local voxel_area = VoxelArea:new({MinEdge = vector_1, MaxEdge = size})
	local schem_data = schematic.data
	local count = size.x * size.y * size.z
	local node_black_list = {}

	-- Remove air from the schematic preview
	for i, map_node in pairs(schem_data) do
		if map_node.name == "air" then
			count = count - 1
			node_black_list[i] = true
		end
	end
	for i in voxel_area:iterp(vector_1, size) do
		local pos = voxel_area:position(i)
		local node_name = schematic.data[i].name
		if not node_black_list[i] and math.random() < probability then
			local attach_pos = vector.multiply(pos, 10)
			local node_def = core.get_node_def(node_name) or core.get_item_def(node_name)
			--[[
* `core.get_node_def(nodename)`
    * Returns [node definition](#node-definition) table of `nodename`
* `core.get_item_def(itemstring)`
    * Returns item definition table of `itemstring`
			]]
			minetest.add_particlespawner(particlespawnerdef)
			
		end
	end
end

mcl_util.holoschem_render_init = true








--[[
particledef
]]
local particledeftemplate = {
    pos = {x=0, y=0, z=0},
    velocity = {x=0, y=0, z=0},
    acceleration = {x=0, y=0, z=0},
    -- Spawn particle at pos with velocity and acceleration

    expirationtime = 1,
    -- Disappears after expirationtime seconds

    size = 1,
    -- Scales the visual size of the particle texture.
    -- If `node` is set, size can be set to 0 to spawn a randomly-sized
    -- particle (just like actual node dig particles).

    collisiondetection = false,
    -- If true collides with `walkable` nodes and, depending on the
    -- `object_collision` field, objects too.

    collision_removal = false,
    -- If true particle is removed when it collides.
    -- Requires collisiondetection = true to have any effect.

    object_collision = false,
    -- If true particle collides with objects that are defined as
    -- `physical = true,` and `collide_with_objects = true,`.
    -- Requires collisiondetection = true to have any effect.

    vertical = false,
    -- If true faces player using y axis only

    texture = "image.png",
    -- The texture of the particle
    -- v5.6.0 and later: also supports the table format described in the
    -- following section, but due to a bug this did not take effect
    -- (beyond the texture name).
    -- v5.9.0 and later: fixes the bug.
    -- Note: "texture.animation" is ignored here. Use "animation" below instead.

    playername = "singleplayer",
    -- Optional, if specified spawns particle only on the player's client

    animation = {Tile Animation definition},
    -- Optional, specifies how to animate the particle texture

    glow = 0
    -- Optional, specify particle self-luminescence in darkness.
    -- Values 0-14.

    node = {name = "ignore", param2 = 0},
    -- Optional, if specified the particle will have the same appearance as
    -- node dig particles for the given node.
    -- `texture` and `animation` will be ignored if this is set.

    node_tile = 0,
    -- Optional, only valid in combination with `node`
    -- If set to a valid number 1-6, specifies the tile from which the
    -- particle texture is picked.
    -- Otherwise, the default behavior is used. (currently: any random tile)

    drag = {x=0, y=0, z=0},
    -- v5.6.0 and later: Optional drag value, consult the following section
    -- Note: Only a vector is supported here. Alternative forms like a single
    -- number are not supported.

    jitter = {min = ..., max = ..., bias = 0},
    -- v5.6.0 and later: Optional jitter range, consult the following section

    bounce = {min = ..., max = ..., bias = 0},
    -- v5.6.0 and later: Optional bounce range, consult the following section
}




--[[
particlespawner
]]
local particlespawnerdeftemplate = {
    -------------------
    -- Common fields --
    -------------------
    -- (same name and meaning in both new and legacy syntax)

    amount = 1,
    -- Number of particles spawned over the time period `time`.

    time = 1,
    -- Lifespan of spawner in seconds.
    -- If time is 0 spawner has infinite lifespan and spawns the `amount` on
    -- a per-second basis.

    collisiondetection = false,
    -- If true collide with `walkable` nodes and, depending on the
    -- `object_collision` field, objects too.

    collision_removal = false,
    -- If true particles are removed when they collide.
    -- Requires collisiondetection = true to have any effect.

    object_collision = false,
    -- If true particles collide with objects that are defined as
    -- `physical = true,` and `collide_with_objects = true,`.
    -- Requires collisiondetection = true to have any effect.

    attached = ObjectRef,
    -- If defined, particle positions, velocities and accelerations are
    -- relative to this object's position and yaw

    vertical = false,
    -- If true face player using y axis only

    texture = "image.png",
    -- The texture of the particle
    -- v5.6.0 and later: also supports the table format described in the
    -- following section.

    playername = "singleplayer",
    -- Optional, if specified spawns particles only on the player's client

    animation = {Tile Animation definition},
    -- Optional, specifies how to animate the particles' texture
    -- v5.6.0 and later: set length to -1 to synchronize the length
    -- of the animation with the expiration time of individual particles.
    -- (-2 causes the animation to be played twice, and so on)

    glow = 0,
    -- Optional, specify particle self-luminescence in darkness.
    -- Values 0-14.

    node = {name = "ignore", param2 = 0},
    -- Optional, if specified the particles will have the same appearance as
    -- node dig particles for the given node.
    -- `texture` and `animation` will be ignored if this is set.

    node_tile = 0,
    -- Optional, only valid in combination with `node`
    -- If set to a valid number 1-6, specifies the tile from which the
    -- particle texture is picked.
    -- Otherwise, the default behavior is used. (currently: any random tile)

    -------------------
    -- Legacy fields --
    -------------------

    minpos = {x=0, y=0, z=0},
    maxpos = {x=0, y=0, z=0},
    minvel = {x=0, y=0, z=0},
    maxvel = {x=0, y=0, z=0},
    minacc = {x=0, y=0, z=0},
    maxacc = {x=0, y=0, z=0},
    minexptime = 1,
    maxexptime = 1,
    minsize = 1,
    maxsize = 1,
    -- The particles' properties are random values between the min and max
    -- values.
    -- applies to: pos, velocity, acceleration, expirationtime, size
    -- If `node` is set, min and maxsize can be set to 0 to spawn
    -- randomly-sized particles (just like actual node dig particles).
}


local newparticlespawnerdeftemplate = {
  -- old syntax
  maxpos = {x = 0, y = 0, z = 0},
  minpos = {x = 0, y = 0, z = 0},

  -- absolute value
  pos = 0,
  -- all components of every particle's position vector will be set to this
  -- value

  -- vec3
  pos = vector.new(0,0,0),
  -- all particles will appear at this exact position throughout the lifetime
  -- of the particlespawner

  -- vec3 range
  pos = {
        -- the particle will appear at a position that is picked at random from
        -- within a cubic range

        min = vector.new(0,0,0),
        -- `min` is the minimum value this property will be set to in particles
        -- spawned by the generator

        max = vector.new(0,0,0),
        -- `max` is the minimum value this property will be set to in particles
        -- spawned by the generator

        bias = 0,
        -- when `bias` is 0, all random values are exactly as likely as any
        -- other. when it is positive, the higher it is, the more likely values
        -- will appear towards the minimum end of the allowed spectrum. when
        -- it is negative, the lower it is, the more likely values will appear
        -- towards the maximum end of the allowed spectrum. the curve is
        -- exponential and there is no particular maximum or minimum value
    },

    -- tween table
    pos_tween = {...},
    -- a tween table should consist of a list of frames in the same form as the
    -- untweened pos property above, which the engine will interpolate between,
    -- and optionally a number of properties that control how the interpolation
    -- takes place. currently **only two frames**, the first and the last, are
    -- used, but extra frames are accepted for the sake of forward compatibility.
    -- any of the above definition styles can be used here as well in any combination
    -- supported by the property type

    pos_tween = {
        style = "fwd",
        -- linear animation from first to last frame (default)
        style = "rev",
        -- linear animation from last to first frame
        style = "pulse",
        -- linear animation from first to last then back to first again
        style = "flicker",
        -- like "pulse", but slightly randomized to add a bit of stutter

        reps = 1,
        -- number of times the animation is played over the particle's lifespan

        start = 0.0,
        -- point in the spawner's lifespan at which the animation begins. 0 is
        -- the very beginning, 1 is the very end

        -- frames can be defined in a number of different ways, depending on the
        -- underlying type of the property. for now, all but the first and last
        -- frame are ignored

        -- frames

            -- floats
            0, 0,

            -- vec3s
            vector.new(0,0,0),
            vector.new(0,0,0),

            -- vec3 ranges
            { min = vector.new(0,0,0), max = vector.new(0,0,0), bias = 0 },
            { min = vector.new(0,0,0), max = vector.new(0,0,0), bias = 0 },

            -- mixed
            0, { min = vector.new(0,0,0), max = vector.new(0,0,0), bias = 0 },
    },
}
--[[

#### List of particlespawner properties

All properties in this list of type "vec3 range", "float range" or "vec3" can
be animated with `*_tween` tables. For example, `jitter` can be tweened by
setting a `jitter_tween` table instead of (or in addition to) a `jitter`
table/value.

In this section, a float range is a table defined as so: { min = A, max = B }
A and B are your supplemented values. For a vec3 range this means they are vectors.
Types used are defined in the previous section.

* vec3 range `pos`: the position at which particles can appear

* vec3 range `vel`: the initial velocity of the particle

* vec3 range `acc`: the direction and speed with which the particle
  accelerates

* float range `size`: scales the visual size of the particle texture.
  if `node` is set, this can be set to 0 to spawn randomly-sized particles
  (just like actual node dig particles).

* vec3 range `jitter`: offsets the velocity of each particle by a random
  amount within the specified range each frame. used to create Brownian motion.

* vec3 range `drag`: the amount by which absolute particle velocity along
  each axis is decreased per second.  a value of 1.0 means that the particle
  will be slowed to a stop over the space of a second; a value of -1.0 means
  that the particle speed will be doubled every second. to avoid interfering
  with gravity provided by `acc`, a drag vector like `vector.new(1,0,1)` can
  be used instead of a uniform value.

* float range `bounce`: how bouncy the particles are when `collisiondetection`
  is turned on. values less than or equal to `0` turn off particle bounce;
  `1` makes the particles bounce without losing any velocity, and `2` makes
  them double their velocity with every bounce.  `bounce` is not bounded but
  values much larger than `1.0` probably aren't very useful.

* float range `exptime`: the number of seconds after which the particle
  disappears.

* table `attract`: sets the birth orientation of particles relative to various
  shapes defined in world coordinate space. this is an alternative means of
  setting the velocity which allows particles to emerge from or enter into
  some entity or node on the map, rather than simply being assigned random
  velocity values within a range. the velocity calculated by this method will
  be **added** to that specified by `vel` if `vel` is also set, so in most
  cases **`vel` should be set to 0**. `attract` has the fields:

  * string `kind`: selects the kind of shape towards which the particles will
    be oriented. it must have one of the following values:

    * `"none"`: no attractor is set and the `attractor` table is ignored
    * `"point"`: the particles are attracted to a specific point in space.
      use this also if you want a sphere-like effect, in combination with
      the `radius` property.
    * `"line"`: the particles are attracted to an (infinite) line passing
      through the points `origin` and `angle`. use this for e.g. beacon
      effects, energy beam effects, etc.
    * `"plane"`: the particles are attracted to an (infinite) plane on whose
      surface `origin` designates a point in world coordinate space. use this
      for e.g. particles entering or emerging from a portal.

  * float range `strength`: the speed with which particles will move towards
    `attractor`. If negative, the particles will instead move away from that
    point.

  * vec3 `origin`: the origin point of the shape towards which particles will
    initially be oriented. functions as an offset if `origin_attached` is also
    set.

  * vec3 `direction`: sets the direction in which the attractor shape faces. for
    lines, this sets the angle of the line; e.g. a vector of (0,1,0) will
    create a vertical line that passes through `origin`. for planes, `direction`
    is the surface normal of an infinite plane on whose surface `origin` is
    a point. functions as an offset if `direction_attached` is also set.

  * ObjectRef `origin_attached`: allows the origin to be specified as an offset
    from the position of an entity rather than a coordinate in world space.

  * ObjectRef `direction_attached`: allows the direction to be specified as an
    offset from the position of an entity rather than a coordinate in world space.

  * bool `die_on_contact`: if true, the particles' lifetimes are adjusted so
    that they will die as they cross the attractor threshold. this behavior
    is the default but is undesirable for some kinds of animations; set it to
    false to allow particles to live out their natural lives.

* vec3 range `radius`: if set, particles will be arranged in a sphere around
  `pos`. A constant can be used to create a spherical shell of particles, a
  vector to create an ovoid shell, and a range to create a volume; e.g.
  `{min = 0.5, max = 1, bias = 1}` will allow particles to appear between 0.5
  and 1 nodes away from `pos` but will cluster them towards the center of the
  sphere. Usually if `radius` is used, `pos` should be a single point, but it
  can still be a range if you really know what you're doing (e.g. to create a
  "roundcube" emitter volume).
]]