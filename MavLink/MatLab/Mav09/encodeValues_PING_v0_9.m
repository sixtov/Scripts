%%%%  case: 3
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function p = encodeValues_PING_v0_9(seq,target_system,target_component,time)
	S.seq = typecast(uint32(seq),'uint32');		% PING sequence
	S.target_system = typecast(uint8(target_system),'uint8');		% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
	S.target_component = typecast(uint8(target_component),'uint8');		% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
	S.time = typecast(uint64(time),'uint64');		% Unix timestamp in microseconds
	p = encode_PING_v0_9(S);
return
