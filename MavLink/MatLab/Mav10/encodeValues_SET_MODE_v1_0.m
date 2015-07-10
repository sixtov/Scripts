%%%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE. There is no target component id 
%%~ as the mode is by definition for the overall aircraft, not only for one component.
function p = encodeValues_SET_MODE_v1_0(target_system,base_mode,custom_mode)
	S.target_system = typecast(uint8(target_system),'uint8');		% The system setting the mode
	S.base_mode = typecast(uint8(base_mode),'uint8');		% The new base mode
	S.custom_mode = typecast(uint32(custom_mode),'uint32');		% The new autopilot-specific mode. This field can be ignored by an autopilot.
	p = encode_SET_MODE_v1_0(S);
return
