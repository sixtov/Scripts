%%  case: 46
%%~ A certain waypoint has been reached. The system will either hold this position (or 
%%~ circle on the orbit) or (if the autocontinue on the WP was set) continue to the 
%%~ next waypoint.
function S = parse_WAYPOINT_REACHED(S,p)
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

