minetest.register_craftitem(":scp:logo_ci", {    description = core.colorize("#f00", "CI Logo"),    inventory_image = "blank.png^[png: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",    groups = {} })