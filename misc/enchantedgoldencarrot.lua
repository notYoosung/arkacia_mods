minetest.register_craftitem(":mcl_core:carrot_gold_enchanted", {
    description = minetest.colorize(tt.COLOR_GOOD, "Enchanted Golden Carrot\nHunger points: 100\nSaturation points: 1,000"),
    _doc_items_longdesc = ("Enchanted golden carrots are precious food items which can be eaten."),
    wield_image = "farming_carrot_gold.png" .. mcl_enchanting.overlay,
    inventory_image = "farming_carrot_gold.png" .. mcl_enchanting.overlay,
    on_place = minetest.item_eat(100),
    on_secondary_use = minetest.item_eat(100),
    groups = { food = 100, eatable = 100, can_eat_when_full = 1 },
    _mcl_saturation = 1000,
})
