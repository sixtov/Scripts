%%  case: 60
%%~ Setpoint in the four motor speeds
function S = parse_SET_QUAD_MOTORS_SETPOINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID of the system that should set these motor commands
		{'motor_front_nw'}	 ... %% Front motor in + configuration, front left motor in x configuration
		{'motor_right_ne'}	 ... %% Right motor in + configuration, front right motor in x configuration
		{'motor_back_se'}	 ... %% Back motor in + configuration, back right motor in x configuration
		{'motor_left_sw'}	 ... %% Left motor in + configuration, back left motor in x configuration
		];
	byte = [ 1 2 2 2 2 ];
	type = [ {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

