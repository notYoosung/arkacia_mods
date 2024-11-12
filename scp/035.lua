minetest.register_tool(":scp:scp_035", {
    description = core.colorize("#f00", "SCP-035"),
    _doc_items_longdesc = mcl_armor.longdesc,
    _doc_items_usagehelp = mcl_armor.usage,     
    inventory_image = "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAdklEQVQ4jdWSSxKAIAxDG/c5Q0/C/Y8VNzgjtkUc3fhmWBCa8ClmvweZKElpMRDqg1CZq5BhcmfOQrYVw4wQAMCSq5b69ydwdyMZCiv9iiSptaYrJNUfeXjo0AUAVjXjWMv+wxDSdwljtc0D7i6Sz41nXgfM2AG8KkV9KPPvbgAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
    groups = { armor = 1, non_combat_armor = 1, armor_head = 1, non_combat_head = 1, mcl_armor_uses = 10 },
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_leather",
        _mcl_armor_unequip = "mcl_armor_unequip_leather",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "head",
    _mcl_armor_texture = "blank.png^[png:iVBORw0KGgoAAAANSUhEUgAAAEAAAAAgCAYAAACinX6EAAAA4WlDQ1BzUkdCAAAYlWNgYDzNAARMDgwMuXklRUHuTgoRkVEKDEggMbm4gAE3YGRg+HYNRDIwXNYNLGHlx6MWG+AsAloIpD8AsUg6mM3IAmInQdgSIHZ5SUEJkK0DYicXFIHYQBcz8BSFBDkD2T5AtkI6EjsJiZ2SWpwMZOcA2fEIv+XPZ2Cw+MLAwDwRIZY0jYFhezsDg8QdhJjKQgYG/lYGhm2XEWKf/cH+ZRQ7VJJaUQIS8dN3ZChILEoESzODAjQtjYHh03IGBt5IBgbhCwwMXNEQd4ABazEwoEkMJ0IAAHLYNoSjH0ezAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAh0lEQVRoge3UTQqEMAyG4UTc9wzpCXr/y32zmZRBREEdOqPvA1n0DxKa1gwAADyVj05gjyRtrbv7qRqmM4fv4Kc7IG8/LzmbYWV8uI7Hd8A8OoEt7m6STJLVWvt8RFgppe+5rfcT0FJrTZ9ro/P8qix0La4o/i/+AEkWEf05ZAAAAAAAABzxAhJdUbq25Fm/AAAADmVYSWZNTQAqAAAACAAAAAAAAADSU5MAAAAASUVORK5CYII=",
    _on_equip = function(obj, itemstack)
    end,
    _on_unequip = function(obj, itemstack)
    end,
    _on_break = function(obj)
    end,
})
