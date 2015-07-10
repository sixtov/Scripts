%%  case: 42
%%~ Message that announces the sequence number of the current active waypoint. The MAV 
%%~ will fly towards this waypoint.
function S = parse_WAYPOINT_CURRENT_v0_9(p)
	name = [ ...
		{'seq'}	 ... %% Sequence
		];
	byte = [ 2 ];
	type = [ {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

