%%  case: 4
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function S = parse_PING_v1_0(p)
	name = [ ...
		{'time_usec'}		 ... %% Unix timestamp in microseconds or since system boot if smaller than MAVLink epoch (1.1.2009)
		{'seq'}				 ... %% PING sequence
		{'target_system'}	 ... %% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'target_component'} ... %% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
		];
	byte = [ 8 4 1 1 ];
	type = [ {'uint64'} {'uint32'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

