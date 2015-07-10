%%  case: 40
%%~ Request the information of the mission item with the sequence number seq. The response 
%%~ of the system to this message should be a MISSION_ITEM message. http://qgroundcontrol.org/mavlink/waypoint_protocol
function S = parse_MISSION_REQUEST_v1_0(p)
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

