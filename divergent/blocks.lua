local yc_top = "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAADNJREFUWEft0EERAAAEAEG6CiyGFsTw2UtwszldG4+lAQIECBAgQIAAAQIECBAgQOBb4ACURmOBcF2uRAAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC"
local yc_side = "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAAAQ9JREFUWEftl2sLgjAUho+3eSlKu2BRP68f3D8IiqKIMtQydWb4JVmrhK2LxPZRdsazd+95OUrr6SSHHy6pVgDnOKO0UGQJNE1m1gjjC1WrquV5hAI7LwE/SIiC8dDiApjNQ+I8y1TB7Ru3bwKgXgp4B/L9i4dqNlQuD+z2MWXCbkd/7AFmq3MU1isHOC7CXPp5BR4FvVTyEgB+mFI3MXWFy4SL5RFwVlIgpMBoYH4viATAzxXYbCPKV27/iQeOJ0xtRprMZcKq/vx8G1YQCID/ViBOMogies602+h5EgZ3cVzEJutQWgCs1mQb2i0Ejv0C4J1DqQBgUiBJSdP0HJ3LAzn9XwKGoYiZUChwU+AKZisOkEoUKLEAAAAOZVhJZk1NACoAAAAIAAAAAAAAANJTkwAAAABJRU5ErkJggg=="

local wood_groups = {
	handy = 1,
	axey = 1,
	material_wood = 1,
	flammable = 3,
	fire_encouragement = 5,
	fire_flammability = 20
}

minetest.register_node(":scp:railroad_metal_yellow", {
	description = "Yellow Railroad Metal",
	tiles = {yc_top, yc_top, yc_side, yc_side, yc_side, yc_side},
	is_ground_content = false,
	sounds = mcl_sounds.node_sound_metal_defaults(),
	paramtype2 = "facedir",
	groups = table.merge(wood_groups, {
		tree = 1, building_block = 1, supports_mushrooms=1,
		dig_immediate = 3,
	}),
	on_place = mcl_util.rotate_axis,
	on_rotate = screwdriver.rotate_3way,
})

