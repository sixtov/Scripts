%%  case: 42
%%~ Message that announces the sequence number of the current active mission item. The 
%%~ MAV will fly towards this mission item.
function S = parse_MISSION_CURRENT_v1_0(p)
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

