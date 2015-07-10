%%%%  case: 47
%%~ Ack message during MISSION handling. The type field states if this message is a 
%%~ positive ack (type=0) or if an error happened (type=non-zero).
function p = encodeValues_MISSION_ACK_v1_0(target_system,target_component,type)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.type = typecast(uint8(type),'uint8');		% See MAV_MISSION_RESULT enum
	p = encode_MISSION_ACK_v1_0(S);
return
