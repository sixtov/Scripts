%%%%  case: 40
%%~ Request the information of the waypoint with the sequence number seq. The response 
%%~ of the system to this message should be a WAYPOINT message.
function p = encodeValues_WAYPOINT_REQUEST_v0_9(target_system,target_component,seq)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	p = encode_WAYPOINT_REQUEST_v0_9(S);
return
