%%  case: 3
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function p = encode_PING_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(14);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(3);
	name = [ ...
		{'seq'}				 ... %% PING sequence
		{'target_system'}	 ... %% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'target_component'} ... %% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'time'}			 ... %% Unix timestamp in microseconds
		];
	byte = [ 4 1 1 8 ];
	type = [ {'uint32'} {'uint8'} {'uint8'} {'uint64'} ];

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
