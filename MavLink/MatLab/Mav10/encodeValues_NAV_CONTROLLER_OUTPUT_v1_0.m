%%%%  case: 62
%%~ Outputs of the APM navigation controller. The primary use of this message is to 
%%~ check the response and signs of the controller before actual flight and to assist 
%%~ with tuning controller parameters.
function p = encodeValues_NAV_CONTROLLER_OUTPUT_v1_0(nav_roll,nav_pitch,nav_bearing,target_bearing,wp_dist,alt_error,aspd_error,xtrack_error)
	S.nav_roll = typecast(single(nav_roll),'single');		% Current desired roll in degrees
	S.nav_pitch = typecast(single(nav_pitch),'single');		% Current desired pitch in degrees
	S.nav_bearing = typecast(int16(nav_bearing),'int16');		% Current desired heading in degrees
	S.target_bearing = typecast(int16(target_bearing),'int16');		% Bearing to current MISSION/target in degrees
	S.wp_dist = typecast(uint16(wp_dist),'uint16');		% Distance to active MISSION in meters
	S.alt_error = typecast(single(alt_error),'single');		% Current altitude error in meters
	S.aspd_error = typecast(single(aspd_error),'single');		% Current airspeed error in meters/second
	S.xtrack_error = typecast(single(xtrack_error),'single');		% Current crosstrack error on x-y plane in meters
	p = encode_NAV_CONTROLLER_OUTPUT_v1_0(S);
return
