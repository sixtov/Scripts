%%  case: 12
%%~ Set the system navigation mode, as defined by enum MAV_NAV_MODE in mavlink/include/mavlink_types.h. 
%%~ The navigation mode applies to the whole aircraft and thus all 
%%~ components.
function S = parse_SET_NAV_MODE_v0_9(S,p)
	name = [ ...
		{'target'}	 ... %% The system setting the mode
		{'nav_mode'} ... %% The new navigation mode
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

