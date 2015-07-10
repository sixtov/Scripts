%%  case: 4
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function p = encode_PING_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(14);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(4);
	name = [ ...
		{'time_usec'}		 ... %% Unix timestamp in microseconds or since system boot if smaller than MAVLink epoch (1.1.2009)
		{'seq'}				 ... %% PING sequence
		{'target_system'}	 ... %% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'target_component'} ... %% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
		];
	byte = [ 8 4 1 1 ];
	type = [ {'uint64'} {'uint32'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
