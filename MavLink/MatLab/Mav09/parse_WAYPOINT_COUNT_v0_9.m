%%  case: 44
%%~ This message is emitted as response to WAYPOINT_REQUEST_LIST by the MAV. The GCS 
%%~ can then request the individual waypoints based on the knowledge of the total number 
%%~ of waypoints.
function S = parse_WAYPOINT_COUNT_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'count'}			 ... %% Number of Waypoints in the Sequence
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

