%%  case: 37
%%~ The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
%%~ messages). The standard PPM modulation is as follows: 1000 microseconds: 
%%~ 0%, 2000 microseconds: 100%.
function S = parse_SERVO_OUTPUT_RAW_v0_9(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

