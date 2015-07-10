%%  case: 37
%%~ The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
%%~ messages). The standard PPM modulation is as follows: 1000 microseconds: 
%%~ 0%, 2000 microseconds: 100%.
function p = encode_SERVO_OUTPUT_RAW(S)
	name = [ ...
		{'servo1_raw'}	 ... %% Servo output 1 value, in microseconds
		{'servo2_raw'}	 ... %% Servo output 2 value, in microseconds
		{'servo3_raw'}	 ... %% Servo output 3 value, in microseconds
		{'servo4_raw'}	 ... %% Servo output 4 value, in microseconds
		{'servo5_raw'}	 ... %% Servo output 5 value, in microseconds
		{'servo6_raw'}	 ... %% Servo output 6 value, in microseconds
		{'servo7_raw'}	 ... %% Servo output 7 value, in microseconds
		{'servo8_raw'}	 ... %% Servo output 8 value, in microseconds
		];
	byte = [ 2 2 2 2 2 2 2 2 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];

	%% Encode servo1_raw data field
	val = typecast(S.servo1_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode servo2_raw data field
	val = typecast(S.servo2_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode servo3_raw data field
	val = typecast(S.servo3_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode servo4_raw data field
	val = typecast(S.servo4_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode servo5_raw data field
	val = typecast(S.servo5_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode servo6_raw data field
	val = typecast(S.servo6_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode servo7_raw data field
	val = typecast(S.servo7_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode servo8_raw data field
	val = typecast(S.servo8_raw,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
