%%  case: 36
%%~ The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
%%~ messages). The standard PPM modulation is as follows: 1000 microseconds: 
%%~ 0%, 2000 microseconds: 100%.
function S = parse_SERVO_OUTPUT_RAW(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since system boot)
		{'port'}		 ... %% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows to encode more than 8 servos.
		{'servo1_raw'}	 ... %% Servo output 1 value, in microseconds
		{'servo2_raw'}	 ... %% Servo output 2 value, in microseconds
		{'servo3_raw'}	 ... %% Servo output 3 value, in microseconds
		{'servo4_raw'}	 ... %% Servo output 4 value, in microseconds
		{'servo5_raw'}	 ... %% Servo output 5 value, in microseconds
		{'servo6_raw'}	 ... %% Servo output 6 value, in microseconds
		{'servo7_raw'}	 ... %% Servo output 7 value, in microseconds
		{'servo8_raw'}	 ... %% Servo output 8 value, in microseconds
		];
	byte = [ 4 1 2 2 2 2 2 2 2 2 ];
	type = [ {'uint32'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

