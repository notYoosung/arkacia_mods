local default_dirt = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAFVBMVEW5hVyHh4eWbEpsbGx0WER5VTpZPSnqDkA3AAAAbklEQVR42hXLwQnDQAwEwOVA7uDyNgq6AtJD/mLD6m0Muv5LCJ7/YES6OhNsvjLGhpXJtA1vW+nMQJy31o+Ncu4uJUwzDSQE13I5giyGGuxqCQTTxnX4RPDkJ+5ChZskgPp6HemIqwp8+ojp8voDZ2EdYwBe7AYAAAAASUVORK5CYII="
local mcl_core_grass_block_side_overlay = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAeElEQVQ4T+2NsQrAIAxE/WtHUdxUUARXZwcXfzDtXRFa6Cd4IPHlLokaY0jOWVprEmOUzajo4fXeyahrLbHW8g9PwXgPIqBugZ1zZATBtVbWnQ8hiOKWWwh672mAsWwv2tfmnOxprZ/rfyqlfAxjDDml9D9wdHREXc8PflIHcVV8AAAAAElFTkSuQmCC"
local mcl_core_grass_block_top = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAAAAAA6mKC9AAAA8UlEQVR42gUAWW+CMPj7yXuZ0ylHOWwpR6EFC0ERh8gh+ELGEl9mwh8zEC9iv2eaVxwodpoPHxKvlJmeGVp3E4uHXah8xXJIGMbndsRf+gwrm8ooU7hm+pK5jQI/5mgODzI8P/XmrhIfsnR9Q4ckxwkx1ySIQT3WITepZuHfIWokA4ZPbri7WnLEiJVaB00+9wMaj1NvcFsUKkjjz/fSXscR74KJIcgLWRtzIF6bxmREMrDGfSUt7kjubSdNofCUiGaR/U0jqpzrjQTUrriSoeUi2rwk7QOqy2s73WOhJgnuTu4G7ANxrmksgv9dZ4WkeAPz+JNw8txdwAAAAABJRU5ErkJggg=="

minetest.register_node(":arkacia:fake_grass",
    {
        description = "Fake Grass",
        tiles = {
            "blank.png^[png:" .. mcl_core_grass_block_top .. "^[colorize:#2a5a37:90",
            "blank.png^[png:" .. default_dirt,
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:#2a5a37:90)",
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:#2a5a37:90)",
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:#2a5a37:90)",
            "blank.png^[png:" .. default_dirt .. "^(blank.png^[png:" .. mcl_core_grass_block_side_overlay .. "^[colorize:#2a5a37:90)"
        },
        groups = { dig_immediate = 3, },
        is_ground_content = false,
        sounds = mcl_sounds.node_sound_dirt_defaults(),
    })
