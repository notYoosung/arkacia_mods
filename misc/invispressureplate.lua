mcl_redstone.register_pressure_plate(
	"mcl_pressureplates:pressure_plate_invisible",
	("Invisible Pressure Plate"),
	{ "blank.png" },
	{ "blank.png" },
	"blank.png",
	nil,
	{ { "mcl_core:barrier", "mcl_core:barrier" } },
	mcl_sounds.node_sound_stone_defaults(),
	{ pickaxey = 1, material_stone = 1, dig_immediate = 3 },
	{ player = true, mob = true },
	(
	"An invisible pressure plate is a redstone component which supplies its surrounding blocks with redstone power while a player or mob stands on top of it. It is not triggered by anything else."))

		
minetest.register_alias("mesecons_pressureplates:pressure_plate_invisible", "mcl_pressureplates:pressure_plate_invisible")
