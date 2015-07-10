%%%%  case: 9
%%~ This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
%%~ negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
%%~ ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function p = encodeValues_ACTION_ACK_v0_9(action,result)
	S.action = typecast(uint8(action),'uint8');		% The action id
	S.result = typecast(uint8(result),'uint8');		% 0: Action DENIED, 1: Action executed
	p = encode_ACTION_ACK_v0_9(S);
return
