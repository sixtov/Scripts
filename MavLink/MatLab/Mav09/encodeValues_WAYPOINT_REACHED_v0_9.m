%%%%  case: 46
%%~ A certain waypoint has been reached. The system will either hold this position (or 
%%~ circle on the orbit) or (if the autocontinue on the WP was set) continue to the 
%%~ next waypoint.
function p = encodeValues_WAYPOINT_REACHED_v0_9(seq)
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	p = encode_WAYPOINT_REACHED_v0_9(S);
return
