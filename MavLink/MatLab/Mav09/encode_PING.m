%%  case: 3
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function p = encode_PING(S)
	name = [ ...
		{'seq'}				 ... %% PING sequence
		{'target_system'}	 ... %% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'target_component'} ... %% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'time'}			 ... %% Unix timestamp in microseconds
		];
	byte = [ 4 1 1 8 ];
	type = [ {'uint32'} {'uint8'} {'uint8'} {'uint64'} ];

	%% Encode seq data field
	val = typecast(S.seq,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time data field
	val = typecast(S.time,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
