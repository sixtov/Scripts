%%  case: 26
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
%%~ the scaled values to the described units
function S = parse_SCALED_IMU_v0_9(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'xacc'}	 ... %% X acceleration (mg)
		{'yacc'}	 ... %% Y acceleration (mg)
		{'zacc'}	 ... %% Z acceleration (mg)
		{'xgyro'}	 ... %% Angular speed around X axis (millirad /sec)
		{'ygyro'}	 ... %% Angular speed around Y axis (millirad /sec)
		{'zgyro'}	 ... %% Angular speed around Z axis (millirad /sec)
		{'xmag'}	 ... %% X Magnetic field (milli tesla)
		{'ymag'}	 ... %% Y Magnetic field (milli tesla)
		{'zmag'}	 ... %% Z Magnetic field (milli tesla)
		];
	byte = [ 8 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

