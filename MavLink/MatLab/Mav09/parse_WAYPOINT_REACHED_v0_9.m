%%  case: 46
%%~ A certain waypoint has been reached. The system will either hold this position (or 
%%~ circle on the orbit) or (if the autocontinue on the WP was set) continue to the 
%%~ next waypoint.
function S = parse_WAYPOINT_REACHED_v0_9(p)
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

