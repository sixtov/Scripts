%%%%  case: 44
%%~ This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
%%~ a write transaction. The GCS can then request the individual mission item 
%%~ based on the knowledge of the total number of MISSIONs.
function p = encodeValues_MISSION_COUNT_v1_0(target_system,target_component,count)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.count = typecast(uint16(count),'uint16');		% Number of mission items in the sequence
	p = encode_MISSION_COUNT_v1_0(S);
return
