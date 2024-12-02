minetest.register_node(":arkacia:coarse_dirt_waterlogged", {
	description = ("WATERLOGGED Coarse Dirt"),
	_doc_items_longdesc = ("Coarse dirt acts as a soil for some plants and is similar to dirt, but it will never grow a cover. ALSO #WATERLOGGED XFDXDDFDX"),
	tiles = {"mcl_core_coarse_dirt.png"},
	groups = { handy=1, shovely=1, dirt=3, soil=1, soil_sugarcane=1, soil_bamboo=1, soil_fungus=1, cultivatable=1, enderman_takable=1, building_block=1, soil_sapling=2, converts_to_moss=1, water=1, dig_immediate=3},
	sounds = mcl_sounds.node_sound_dirt_defaults(),
	_on_shovel_place = mcl_core.make_dirtpath,
	_mcl_blast_resistance = 0.5,
	_mcl_hardness = 0.5,
})