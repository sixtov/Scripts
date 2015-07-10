%%  case: 42
%%~ Message that announces the sequence number of the current active waypoint. The MAV 
%%~ will fly towards this waypoint.
function S = parse_WAYPOINT_CURRENT(S,p)
	name = [ ...
		{'seq'}	 ... %% Sequence
		];
	byte = [ 2 ];
	type = [ {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

