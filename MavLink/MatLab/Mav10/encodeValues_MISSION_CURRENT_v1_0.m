%%%%  case: 42
%%~ Message that announces the sequence number of the current active mission item. The 
%%~ MAV will fly towards this mission item.
function p = encodeValues_MISSION_CURRENT_v1_0(seq)
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	p = encode_MISSION_CURRENT_v1_0(S);
return
