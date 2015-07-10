%%%%  case: 46
%%~ A certain mission item has been reached. The system will either hold this position 
%%~ (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
%%~ to the next MISSION.
function p = encodeValues_MISSION_ITEM_REACHED_v1_0(seq)
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	p = encode_MISSION_ITEM_REACHED_v1_0(S);
return
