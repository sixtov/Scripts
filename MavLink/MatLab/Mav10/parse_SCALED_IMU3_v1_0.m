%%  case: 129
%%~ The RAW IMU readings for 3rd 9DOF sensor setup. This message should contain the 
%%~ scaled values to the described units
function S = parse_SCALED_IMU3_v1_0(p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'xacc'}		 ... %% X acceleration (mg)
		{'yacc'}		 ... %% Y acceleration (mg)
		{'zacc'}		 ... %% Z acceleration (mg)
		{'xgyro'}		 ... %% Angular speed around X axis (millirad /sec)
		{'ygyro'}		 ... %% Angular speed around Y axis (millirad /sec)
		{'zgyro'}		 ... %% Angular speed around Z axis (millirad /sec)
		{'xmag'}		 ... %% X Magnetic field (milli tesla)
		{'ymag'}		 ... %% Y Magnetic field (milli tesla)
		{'zmag'}		 ... %% Z Magnetic field (milli tesla)
		];
	byte = [ 4 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint32'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

