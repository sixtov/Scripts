%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE. There is no target component id 
%%~ as the mode is by definition for the overall aircraft, not only for one component.
function S = parse_SET_MODE_v1_0(S,p)
	name = [ ...
		{'target_system'}	 ... %% The system setting the mode
		{'base_mode'}		 ... %% The new base mode
		{'custom_mode'}		 ... %% The new autopilot-specific mode. This field can be ignored by an autopilot.
		];
	byte = [ 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

