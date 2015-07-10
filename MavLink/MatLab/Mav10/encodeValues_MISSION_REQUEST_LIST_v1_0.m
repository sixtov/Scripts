%%%%  case: 43
%%~ Request the overall list of mission items from the system/component.
function p = encodeValues_MISSION_REQUEST_LIST_v1_0(target_system,target_component)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	p = encode_MISSION_REQUEST_LIST_v1_0(S);
return
