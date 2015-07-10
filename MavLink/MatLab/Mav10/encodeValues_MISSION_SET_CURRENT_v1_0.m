%%%%  case: 41
%%~ Set the mission item with sequence number seq as current item. This means that the 
%%~ MAV will continue to this mission item on the shortest path (not following the 
%%~ mission items in-between).
function p = encodeValues_MISSION_SET_CURRENT_v1_0(target_system,target_component,seq)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	p = encode_MISSION_SET_CURRENT_v1_0(S);
return
