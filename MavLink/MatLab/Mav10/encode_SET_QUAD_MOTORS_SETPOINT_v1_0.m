%%  case: 60
%%~ Setpoint in the four motor speeds
function p = encode_SET_QUAD_MOTORS_SETPOINT_v1_0(S)
	name = [ ...
		{'target_system'}	 ... %% System ID of the system that should set these motor commands
		{'motor_front_nw'}	 ... %% Front motor in + configuration, front left motor in x configuration
		{'motor_right_ne'}	 ... %% Right motor in + configuration, front right motor in x configuration
		{'motor_back_se'}	 ... %% Back motor in + configuration, back right motor in x configuration
		{'motor_left_sw'}	 ... %% Left motor in + configuration, back left motor in x configuration
		];
	byte = [ 1 2 2 2 2 ];
	type = [ {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];

	p = [];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode motor_front_nw data field
	val = typecast(S.motor_front_nw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode motor_right_ne data field
	val = typecast(S.motor_right_ne,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode motor_back_se data field
	val = typecast(S.motor_back_se,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode motor_left_sw data field
	val = typecast(S.motor_left_sw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
