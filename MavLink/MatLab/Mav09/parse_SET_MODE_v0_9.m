%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
%%~ There is no target component id as the mode is by definition for the overall 
%%~ aircraft, not only for one component.
function S = parse_SET_MODE_v0_9(p)
	name = [ ...
		{'target'}	 ... %% The system setting the mode
		{'mode'}	 ... %% The new mode
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

