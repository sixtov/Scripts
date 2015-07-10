%%%%  case: 12
%%~ Set the system navigation mode, as defined by enum MAV_NAV_MODE in mavlink/include/mavlink_types.h. 
%%~ The navigation mode applies to the whole aircraft and thus all 
%%~ components.
function p = encodeValues_SET_NAV_MODE_v0_9(target,nav_mode)
	S.target = typecast(uint8(target),'uint8');		% The system setting the mode
	S.nav_mode = typecast(uint8(nav_mode),'uint8');		% The new navigation mode
	p = encode_SET_NAV_MODE_v0_9(S);
return
