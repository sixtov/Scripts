%%%%  case: 60
%%~ Setpoint in the four motor speeds
function p = encodeValues_SET_QUAD_MOTORS_SETPOINT_v1_0(target_system,motor_front_nw,motor_right_ne,motor_back_se,motor_left_sw)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID of the system that should set these motor commands
	S.motor_front_nw = typecast(uint16(motor_front_nw),'uint16');		% Front motor in + configuration, front left motor in x configuration
	S.motor_right_ne = typecast(uint16(motor_right_ne),'uint16');		% Right motor in + configuration, front right motor in x configuration
	S.motor_back_se = typecast(uint16(motor_back_se),'uint16');		% Back motor in + configuration, back right motor in x configuration
	S.motor_left_sw = typecast(uint16(motor_left_sw),'uint16');		% Left motor in + configuration, back left motor in x configuration
	p = encode_SET_QUAD_MOTORS_SETPOINT_v1_0(S);
return
