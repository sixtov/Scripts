%%  case: 3
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function S = parse_PING_v0_9(S,p)
	name = [ ...
		{'seq'}				 ... %% PING sequence
		{'target_system'}	 ... %% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'target_component'} ... %% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'time'}			 ... %% Unix timestamp in microseconds
		];
	byte = [ 4 1 1 8 ];
	type = [ {'uint32'} {'uint8'} {'uint8'} {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

