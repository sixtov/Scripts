%%  case: 47
%%~ Ack message during waypoint handling. The type field states if this message is a 
%%~ positive ack (type=0) or if an error happened (type=non-zero).
function S = parse_WAYPOINT_ACK_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'type'}			 ... %% 0: OK, 1: Error
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

