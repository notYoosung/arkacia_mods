local gs_interval = 0.5

if not mcl_util.holoschem_render_init then
    
end

local function render_schem()
	for i in voxel_area:iterp(vector_1, size) do
		local pos = voxel_area:position(i)
		local name = schematic.data[i].name
		if not node_black_list[i] and math.random() < probability then
			local attach_pos = vector.multiply(pos, 10)
			local attach_rot
			local objref = minetest.add_entity(player_pos, "edit:preview_node")
			objref:set_properties({wield_item = name})
			local node_def = minetest.registered_nodes[name]
			if node_def and node_def.paramtype2 == "facedir" then
				local param2 = schematic.data[i].param2
				attach_rot = param2_to_rotation[param2]
			end
			objref:set_attach(base_objref, "", attach_pos, attach_rot)
		end
	end
end

mcl_util.holoschem_render_init = true