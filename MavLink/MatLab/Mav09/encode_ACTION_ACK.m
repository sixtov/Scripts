%%  case: 9
%%~ This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
%%~ negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
%%~ ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function p = encode_ACTION_ACK(S)
	name = [ ...
		{'action'}	 ... %% The action id
		{'result'}	 ... %% 0: Action DENIED, 1: Action executed
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	%% Encode action data field
	val = typecast(S.action,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode result data field
	val = typecast(S.result,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
