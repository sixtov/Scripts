%%%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
%%~ There is no target component id as the mode is by definition for the overall 
%%~ aircraft, not only for one component.
function p = encodeValues_SET_MODE_v0_9(target,mode)
	S.target = typecast(uint8(target),'uint8');		% The system setting the mode
	S.mode = typecast(uint8(mode),'uint8');		% The new mode
	p = encode_SET_MODE_v0_9(S);
return
