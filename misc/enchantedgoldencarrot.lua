local function do_eat(itemstack, placer, pointed_thing)
    minetest.item_eat(100)(itemstack, placer, pointed_thing)
    if placer then
        mcl_util.deal_damage(placer, -100, { type = "golden_carrot_heal", direct = placer, source = placer })
        if placer:is_player() then
            local ok = mcl_hunger.set_saturation(placer, 65535, mcl_hunger.get_hunger(placer))
        end
        mcl_burning.extinguish(placer)
    end
end

minetest.register_craftitem(":mcl_core:carrot_gold_enchanted", {
    description = minetest.colorize(tt.COLOR_GOOD, "Enchanted Golden Carrot\nHunger points: 100\nSaturation points: 1,000"),
    _doc_items_longdesc = ("Enchanted golden carrots are precious food items which can be eaten."),
    wield_image = "farming_carrot_gold.png" .. mcl_enchanting.overlay,
    inventory_image = "farming_carrot_gold.png" .. mcl_enchanting.overlay,
    on_place = do_eat,
    on_secondary_use = do_eat,
    groups = { food = 100, eatable = 100, can_eat_when_full = 1 },
    _mcl_saturation = 1000,
})
