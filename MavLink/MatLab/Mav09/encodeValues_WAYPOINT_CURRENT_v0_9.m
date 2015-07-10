%%%%  case: 42
%%~ Message that announces the sequence number of the current active waypoint. The MAV 
%%~ will fly towards this waypoint.
function p = encodeValues_WAYPOINT_CURRENT_v0_9(seq)
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	p = encode_WAYPOINT_CURRENT_v0_9(S);
return
