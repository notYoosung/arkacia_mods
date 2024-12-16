local default_dirt = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAFVBMVEW5hVyHh4eWbEpsbGx0WER5VTpZPSnqDkA3AAAAbklEQVR42hXLwQnDQAwEwOVA7uDyNgq6AtJD/mLD6m0Muv5LCJ7/YES6OhNsvjLGhpXJtA1vW+nMQJy31o+Ncu4uJUwzDSQE13I5giyGGuxqCQTTxnX4RPDkJ+5ChZskgPp6HemIqwp8+ojp8voDZ2EdYwBe7AYAAAAASUVORK5CYII="
local mcl_core_grass_block_side_overlay = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAeElEQVQ4T+2NsQrAIAxE/WtHUdxUUARXZwcXfzDtXRFa6Cd4IPHlLokaY0jOWVprEmOUzajo4fXeyahrLbHW8g9PwXgPIqBugZ1zZATBtVbWnQ8hiOKWWwh672mAsWwv2tfmnOxprZ/rfyqlfAxjDDml9D9wdHREXc8PflIHcVV8AAAAAElFTkSuQmCC"
local mcl_core_grass_block_top = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAAAAAA6mKC9AAAA8UlEQVR42gUAWW+CMPj7yXuZ0ylHOWwpR6EFC0ERh8gh+ELGEl9mwh8zEC9iv2eaVxwodpoPHxKvlJmeGVp3E4uHXah8xXJIGMbndsRf+gwrm8ooU7hm+pK5jQI/5mgODzI8P/XmrhIfsnR9Q4ckxwkx1ySIQT3WITepZuHfIWokA4ZPbri7WnLEiJVaB00+9wMaj1NvcFsUKkjjz/fSXscR74KJIcgLWRtzIF6bxmREMrDGfSUt7kjubSdNofCUiGaR/U0jqpzrjQTUrriSoeUi2rwk7QOqy2s73WOhJgnuTu4G7ANxrmksgv9dZ4WkeAPz+JNw8txdwAAAAABJRU5ErkJggg=="
local c = "#4c763c"
minetest.register_node(":arkacia:fake_grass",
    {
        description = "Fake Grass",
        tiles = {
			"blank.png^[png:" .. mcl_core_grass_block_top .. "^[colorize:" .. c .. ":150",
            "blank.png^[png:" .. default_dirt,
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:" .. c .. ":150)",
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:" .. c .. ":150)",
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:" .. c .. ":150)",
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:" .. c .. ":150)"
        },
        groups = { dig_immediate = 3, },
        is_ground_content = false,
        sounds = mcl_sounds.node_sound_dirt_defaults(),
    })



minetest.register_node(":arkacia:fake_grass2", {
	description = ("Biome-Colored Fake Grass"),
	_doc_items_longdesc = ("A grass block is dirt with a grass cover. Grass blocks are resourceful blocks which allow the growth of all sorts of plants. They can be turned into farmland with a hoe and turned into grass paths with a shovel. In light, the grass slowly spreads onto dirt nearby. Under an opaque block or a liquid, a grass block may turn back to dirt."),
	_doc_items_hidden = false,
	paramtype2 = "color",
	tiles = {"mcl_core_grass_block_top.png", { name="default_dirt.png", color="white" }, { name="default_dirt.png^mcl_dirt_grass_shadow.png", color="white" }},
	overlay_tiles = {"mcl_core_grass_block_top.png", "blank.png", {name="mcl_core_grass_block_side_overlay.png", tileable_vertical=false}},
	palette = "mcl_core_palette_grass.png",
	palette_index = 0,
	color = "#8EB971",
	_on_shovel_place = mcl_core.make_dirtpath,
	groups = {
		handy=1, shovely=1, dirt=2, grass_block=1, grass_block_no_snow=1,
		soil=1, soil_sapling=2, soil_sugarcane=1, soil_bamboo=1, soil_fungus=1, cultivatable=2,
		--[[spreading_dirt_type=1, enderman_takable=1,]] building_block=1,
		compostability=30, biomecolor=1, converts_to_moss=1, dig_immediate=3,
	},
	sounds = mcl_sounds.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		if node.param2 == 0 then
			local new_node = mcl_core.get_grass_block_type(pos)
			if new_node.param2 ~= 0 or new_node.name ~= "mcl_core:dirt_with_grass" then
				minetest.set_node(pos, new_node)
			end
		end
		return mcl_core.on_snowable_construct(pos)
	end,
	_mcl_snowed = "mcl_core:dirt_with_grass_snow",
	_mcl_blast_resistance = 0.6,
	_mcl_hardness = 0.6,
	_on_bone_meal = mcl_core.bone_meal_grass,
})
