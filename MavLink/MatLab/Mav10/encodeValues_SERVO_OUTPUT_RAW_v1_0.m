%%%%  case: 36
%%~ The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
%%~ messages). The standard PPM modulation is as follows: 1000 microseconds: 
%%~ 0%, 2000 microseconds: 100%.
function p = encodeValues_SERVO_OUTPUT_RAW_v1_0(time_usec,port,servo1_raw,servo2_raw,servo3_raw,servo4_raw,servo5_raw,servo6_raw,servo7_raw,servo8_raw)
	S.time_usec = typecast(uint32(time_usec),'uint32');		% Timestamp (microseconds since system boot)
	S.port = typecast(uint8(port),'uint8');		% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows to encode more than 8 servos.
	S.servo1_raw = typecast(uint16(servo1_raw),'uint16');		% Servo output 1 value, in microseconds
	S.servo2_raw = typecast(uint16(servo2_raw),'uint16');		% Servo output 2 value, in microseconds
	S.servo3_raw = typecast(uint16(servo3_raw),'uint16');		% Servo output 3 value, in microseconds
	S.servo4_raw = typecast(uint16(servo4_raw),'uint16');		% Servo output 4 value, in microseconds
	S.servo5_raw = typecast(uint16(servo5_raw),'uint16');		% Servo output 5 value, in microseconds
	S.servo6_raw = typecast(uint16(servo6_raw),'uint16');		% Servo output 6 value, in microseconds
	S.servo7_raw = typecast(uint16(servo7_raw),'uint16');		% Servo output 7 value, in microseconds
	S.servo8_raw = typecast(uint16(servo8_raw),'uint16');		% Servo output 8 value, in microseconds
	p = encode_SERVO_OUTPUT_RAW_v1_0(S);
return
