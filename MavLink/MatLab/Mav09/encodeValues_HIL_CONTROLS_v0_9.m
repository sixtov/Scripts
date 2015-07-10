%%%%  case: 68
%%~ Hardware in the loop control outputs
function p = encodeValues_HIL_CONTROLS_v0_9(time_us,roll_ailerons,pitch_elevator,yaw_rudder,throttle,mode,nav_mode)
	S.time_us = typecast(uint64(time_us),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.roll_ailerons = typecast(single(roll_ailerons),'single');		% Control output -3 .. 1
	S.pitch_elevator = typecast(single(pitch_elevator),'single');		% Control output -1 .. 1
	S.yaw_rudder = typecast(single(yaw_rudder),'single');		% Control output -1 .. 1
	S.throttle = typecast(single(throttle),'single');		% Throttle 0 .. 1
	S.mode = typecast(uint8(mode),'uint8');		% System mode (MAV_MODE)
	S.nav_mode = typecast(uint8(nav_mode),'uint8');		% Navigation mode (MAV_NAV_MODE)
	p = encode_HIL_CONTROLS_v0_9(S);
return
