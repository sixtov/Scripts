%%  case: 45
%%~ Delete all waypoints at once.
function S = parse_WAYPOINT_CLEAR_ALL_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
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

