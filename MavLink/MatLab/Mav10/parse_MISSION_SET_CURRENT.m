%%  case: 41
%%~ Set the mission item with sequence number seq as current item. This means that the 
%%~ MAV will continue to this mission item on the shortest path (not following the 
%%~ mission items in-between).
function S = parse_MISSION_SET_CURRENT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

