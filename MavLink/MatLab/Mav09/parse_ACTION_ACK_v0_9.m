%%  case: 9
%%~ This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
%%~ negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
%%~ ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function S = parse_ACTION_ACK_v0_9(p)
	name = [ ...
		{'action'}	 ... %% The action id
		{'result'}	 ... %% 0: Action DENIED, 1: Action executed
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

