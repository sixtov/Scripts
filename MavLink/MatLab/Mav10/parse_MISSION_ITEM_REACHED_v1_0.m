%%  case: 46
%%~ A certain mission item has been reached. The system will either hold this position 
%%~ (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
%%~ to the next MISSION.
function S = parse_MISSION_ITEM_REACHED_v1_0(p)
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

