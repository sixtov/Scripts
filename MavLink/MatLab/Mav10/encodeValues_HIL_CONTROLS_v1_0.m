%%%%  case: 91
%%~ Sent from autopilot to simulation. Hardware in the loop control outputs
function p = encodeValues_HIL_CONTROLS_v1_0(time_usec,roll_ailerons,pitch_elevator,yaw_rudder,throttle,aux1,aux2,aux3,aux4,mode,nav_mode)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.roll_ailerons = typecast(single(roll_ailerons),'single');		% Control output -1 .. 1
	S.pitch_elevator = typecast(single(pitch_elevator),'single');		% Control output -1 .. 1
	S.yaw_rudder = typecast(single(yaw_rudder),'single');		% Control output -1 .. 1
	S.throttle = typecast(single(throttle),'single');		% Throttle 0 .. 1
	S.aux1 = typecast(single(aux1),'single');		% Aux 1, -1 .. 1
	S.aux2 = typecast(single(aux2),'single');		% Aux 2, -1 .. 1
	S.aux3 = typecast(single(aux3),'single');		% Aux 3, -1 .. 1
	S.aux4 = typecast(single(aux4),'single');		% Aux 4, -1 .. 1
	S.mode = typecast(uint8(mode),'uint8');		% System mode (MAV_MODE)
	S.nav_mode = typecast(uint8(nav_mode),'uint8');		% Navigation mode (MAV_NAV_MODE)
	p = encode_HIL_CONTROLS_v1_0(S);
return
