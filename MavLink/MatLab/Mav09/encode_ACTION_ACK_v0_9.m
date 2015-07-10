%%  case: 9
%%~ This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
%%~ negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
%%~ ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function p = encode_ACTION_ACK_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(2);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(9);
	name = [ ...
		{'action'}	 ... %% The action id
		{'result'}	 ... %% 0: Action DENIED, 1: Action executed
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode action data field
	val = typecast(S.action,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode result data field
	val = typecast(S.result,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
