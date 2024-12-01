local textures = {
    brown_autumnal = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAPUExURUImEXNLJzAYDFs5HTgdDf8ZPWYAAAAJcEhZcwAACxEAAAsRAX9kX5EAAABwSURBVBjTFYzbDcMwDAOZyANUcgaoJQ0gPwYInO4/U5UPEiCIOxyilYQNNdPVBE2iq346VNeYdgimbqN4FPfQd3xB7uVkL8hyIykwukZyjujBa7hijdavVMBd+beDIeXc21uaEZ4PI73lxfDoBDeqf2vIEGS6Fp+NAAAAAElFTkSuQmCC",
    fir = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAPUExURRIrERUyFBhAFxtHGRc2FtRRw5sAAAAJcEhZcwAACxEAAAsRAX9kX5EAAABuSURBVBjTDc3RDQMxCINhgxmAUzsASTtAIt0A5Oj+M5XXT79syFxERuBRXM6H2OseJgzIxtvLC+k/axFIhEVmorR8xnGMiJdSDMW6YrhD6kvSDN25H53Yx4bEit7po1RtoZbs3c3zaV7QSZYc+QPx3Q7EEjOVnQAAAABJRU5ErkJggg==",
    orange_autumnal = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAPUExURbphG++PHY5JGN55HaRVG8Vc3h8AAAAJcEhZcwAACxEAAAsRAX9kX5EAAABwSURBVBjTFYzbDcMwDAOZyANUcgaoJQ0gPwYInO4/U5UPEiCIOxyilYQNNdPVBE2iq346VNeYdgimbqN4FPfQd3xB7uVkL8hyIykwukZyjujBa7hijdavVMBd+beDIeXc21uaEZ4PI73lxfDoBDeqf2vIEGS6Fp+NAAAAAElFTkSuQmCC",
    red_autumnal = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAPUExURX4kF7ZEMGAYEJ01JG0cEgpnL9QAAAAJcEhZcwAACxEAAAsRAX9kX5EAAABwSURBVBjTFYzbDcMwDAOZyANUcgaoJQ0gPwYInO4/U5UPEiCIOxyilYQNNdPVBE2iq346VNeYdgimbqN4FPfQd3xB7uVkL8hyIykwukZyjujBa7hijdavVMBd+beDIeXc21uaEZ4PI73lxfDoBDeqf2vIEGS6Fp+NAAAAAElFTkSuQmCC",
    yellow_autumnal = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAPUExURbmOGOnRMY5xEda1JKSDE/fZayUAAAAJcEhZcwAACxEAAAsRAX9kX5EAAABwSURBVBjTFYzbDcMwDAOZyANUcgaoJQ0gPwYInO4/U5UPEiCIOxyilYQNNdPVBE2iq346VNeYdgimbqN4FPfQd3xB7uVkL8hyIykwukZyjujBa7hijdavVMBd+beDIeXc21uaEZ4PI73lxfDoBDeqf2vIEGS6Fp+NAAAAAElFTkSuQmCC",
    azalea = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAPUExURVBpLDA/HzpMJmyAMXCSLQ6Yf+EAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABwSURBVBjTDcbBFcQgCAXAT6SAgClASQrAaAG60n9Nm8u8AZU0ySSh6TOpr4wK2B4/xWavgUMR15KThuBTTKJjVhtxnF9IOd7CqJc7TwPwzM19dThTtOtL0+KSkaEolMIr8uiVww1pbxPcDeClorf/AXRPD/2XUlv7AAAAAElFTkSuQmCC",
    flowering_azalea = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQBAMAAADt3eJSAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAYUExURVBpLDA/HzpMJmyAMXCSLbpiztB7455QiH0cspkAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAB9SURBVBjTDcYxEoMgEAXQj66xdRdn0gJG6yWYHgOegRNkvP8N4qsejOuzCb5HlFc26bDwAJfPT1BIfX1sgjp/vRsuBk+dBK4J2fNeuynhvJjq2xG2VZVyAMaWC6UjQcnUON+J4vTZYCFwZlg1wO7Jj+1OX0pgLBGgQ1gW/QP0DxGRE2uqGAAAAABJRU5ErkJggg==",
}
for k, v in pairs(textures) do
    minetest.register_node(":arkacia:opaque_leaves_" .. k, {
        description = "Opaque Leaves: " .. k,
        tiles = { "blank.png^[png:" .. v },
        groups = { dig_immediate = 3, }
    })
end



local S = minetest.get_translator(minetest.get_current_modname())

local name = "spruce"
local rname = "Spruce"
local p = {
    leaves = {
    	color = "#2bbb0f",
    },
}

local function register_leaves(subname, def, sapling, drop_apples, sapling_chances)
    local d = mcl_trees.generate_leaves_def("mcl_trees:", subname, def, sapling, drop_apples, sapling_chances)
    minetest.register_node(":" .. d["leaves_id"], table.merge(d["leaves_def"], {
        use_texture_alpha = "none",
    }))
    minetest.register_node(":" .. d["orphan_leaves_id"], table.merge(d["orphan_leaves_def"], {
        use_texture_alpha = "none",
    }))
end
register_leaves("leaves_" .. name,
    table.merge({
        description = S("@1 Leaves", rname),
        _doc_items_longdesc = S("@1 leaves are grown from @2 trees.", rname, rname),
        tiles = { "mcl_core" .. "_leaves_" .. name .. ".png" },
    }, p.leaves or {}),
    p.saplingdrop or ("mcl_trees:sapling_" .. name),
    p.drop_apples or false,
    p.sapling_chances or { 20, 16, 12, 10 }
)
