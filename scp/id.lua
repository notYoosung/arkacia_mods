local function register_id(name, itemname, class, mission, clearance_level, texture_id)
    minetest.register_craftitem(":bear:id_card_" .. itemname, {description = minetest.colorize("#ff0", "ID Card - " .. name .. "\nClass: " .. class .. "\nMission: " .. mission) .. minetest.colorize("#FF1", "\nClearance: " .. tostring(clearance_level)), inventory_image = "mcl_maps_map_texture_" .. tostring(texture_id) .. ".tga"})
end

register_id("CI", "ci", "Chaos Insurgency", "Breach SCPs and attack the Foundation.", 5, 60)

register_id("Class-D", "class_d", "Personnel", "Escape the Foundation", 2, 87)

register_id("Dr. Charm", "dr_charm", "Site Staff", "", 3, 83)
register_id("Dr. Azure", "dr_azure", "Site Staff", "", 3, 82)
register_id("Blank", "blank", "", "", 1, 60)


register_id("Containment Specialist", "containment_specialist", "Site Staff", "Find and contain anomalous activity.", 3, 60)
register_id("Researcher", "researcher", "Site Staff", "", 3, 60)
register_id("Guard", "guard", "Site Staff", "", 3, 60)
register_id("Tactical Response Officer", "tactical_response_officer", "Site Staff", "", 3, 60)

register_id("Field Agent", "field_agent", "Field Personnel", "Look for and investigate signs of anomalous activity.", 4, 60)
register_id("MTF", "mtf", "Field Personnel", "", 4, 60)

register_id("Site Director", "site_director", "Administration", "", 5, 60)
register_id("O5 Council Member", "o5_council_member", "Administration", "Direct all top operations.", 5, 60)


