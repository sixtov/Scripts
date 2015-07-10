%%  case: 41
%%~ Set the waypoint with sequence number seq as current waypoint. This means that the 
%%~ MAV will continue to this waypoint on the shortest path (not following the waypoints 
%%~ in-between).
function S = parse_WAYPOINT_SET_CURRENT_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

