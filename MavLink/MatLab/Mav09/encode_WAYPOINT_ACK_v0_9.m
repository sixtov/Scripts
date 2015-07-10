%%  case: 47
%%~ Ack message during waypoint handling. The type field states if this message is a 
%%~ positive ack (type=0) or if an error happened (type=non-zero).
function p = encode_WAYPOINT_ACK_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(3);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(47);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'type'}			 ... %% 0: OK, 1: Error
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
