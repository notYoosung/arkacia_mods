local top = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAyklEQVQ4jYWTQQuEIBCFnw5GsCHEdtlT//9nLexxQZBgBQ/uISudapzbx5PifaPKGJMAAERQjw7J/wAiADiY5wVrECHGqGIICrYHAMQQai5zdl6jnHHY/37LbFT3tAm2P8L3F5gnwC0r+4A9d8vB+YPKGJOanXlesD51bjkhqlhXHa9GysfhxsHWsXSwSdzyfL528LJIH3d2IHDtIAfS3iueJ+aA77nFbhEc8L1z9gGYp+yg1Vm4J6sDvvfWPRAdSHwxtQOpM38ref7QQbadQmP0/AAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC"
local side = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAICAYAAADwdn+XAAABDmlDQ1BJQ0MgUHJvZmlsZQAAGJVjYGB8klhQkMPkwMCQm1dSFOTupBARGaXA/oKBm4GHQYRBj4E/Mbm4wDEgwIcBCGA0Kvh2jYERRF/WBZmFKY8XcKakFicD6Q9AHJ9cUFTCwMAYAGQrl5cUgNhAzCBSBHQUkN0BYqdD2HNA7CQIewNYTUiQM5B9BMhWSEJipyOxoXaBAGsx0LMkupUgKEmtALmXwTm/oLIoMz2jRMERGCKpCp55yXo6CkYGRiYMDKDwhaj+7A8ON0axQwix/PkMDBZfGBiYJyLEkqYxMGxvZ2CQuIMQU1nIwMDfysCw7XJBYlEiWIgZiJnS0hgYPi1nYOCNZGAQvsDAwBUNALAqR3qzgOjNAAAAeGVYSWZNTQAqAAAACAAFARIAAwAAAAEAAQAAARoABQAAAAEAAABKARsABQAAAAEAAABSASgAAwAAAAEAAgAAh2kABAAAAAEAAABaAAAAAAAAAGAAAAABAAAAYAAAAAEAAqACAAQAAAABAAAAEKADAAQAAAABAAAACAAAAABXyS6lAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABWWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgIDwvcmRmOkRlc2NyaXB0aW9uPgogICA8L3JkZjpSREY+CjwveDp4bXBtZXRhPgoZXuEHAAAAnUlEQVQoFYVQywrCMBCcbUkRlIDoxZP//1mCR6FQBAM5xJ2tKYnEuJDH7COTGXHOJYwjGHLxSPfZ7szJfkJaXl08sBpDEC7r1MEY44r9DnzoJ76eMWR2Gz4e7Ni2f3h+QqaTTyBTbr49sGFtwBLamHn9gZgHpOxp1hqj5cnqQalZGyvNxNmjb0+aHnzYyGiySmzJeqs96GkuPVLmHG/33F9nkGdUlQAAAABJRU5ErkJggg=="
local blank = "blank.png^[png:"
minetest.register_node(":arkacia:bouncy_net",
    {
        description = "Bouncy Net",
        _doc_items_longdesc = "Bouncy nets are very very bouncy and prevent fall damage.",
        paramtype = "light",
        is_ground_content = false,
        tiles = {
            blank .. top,
        },
        use_texture_alpha = "clip",
        groups = { dig_immediate = 3, bouncy = 80, fall_damage_add_percent = -100, deco_block = 1 },
        sounds = { dug = { name = "slimenodes_dug", gain = 0.6 }, place = { name = "slimenodes_place", gain = 0.6 }, footstep = { name = "slimenodes_step", gain = 0.3 }, },
        _mcl_blast_resistance = 0,
        _mcl_hardness = 0,
    })
mcl_stairs.register_stair_and_slab("bouncy_net", {
	baseitem = "arkacia:bouncy_net",
	description_stair = ("Bouncy Net Stairs"),
	description_slab = ("Bouncy Net Slab"),
	overrides = { _mcl_stonecutter_recipes = {"arkacia:bouncy_slab"}, groups = {dig_immediate = 3, bouncy = 80, fall_damage_add_percent = -100, }, use_texture_alpha = "clip"},
})
local function combine_groups(itemname)
    minetest.override_item(itemname, {groups = {dig_immediate = 3, bouncy = 80, fall_damage_add_percent = -100, }})
end
combine_groups("mcl_stairs:slab_bouncy_net")
combine_groups("mcl_stairs:stair_bouncy_net")
minetest.register_alias("arkacia:bouncy_slab", "mcl_stairs:slab_bouncy_net")