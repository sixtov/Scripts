%%%%  case: 47
%%~ Ack message during waypoint handling. The type field states if this message is a 
%%~ positive ack (type=0) or if an error happened (type=non-zero).
function p = encodeValues_WAYPOINT_ACK_v0_9(target_system,target_component,type)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.type = typecast(uint8(type),'uint8');		% 0: OK, 1: Error
	p = encode_WAYPOINT_ACK_v0_9(S);
return
