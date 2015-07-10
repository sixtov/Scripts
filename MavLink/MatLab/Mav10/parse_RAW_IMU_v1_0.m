%%  case: 27
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
%%~ contain the true raw values without any scaling to allow data capture and system 
%%~ debugging.
function S = parse_RAW_IMU_v1_0(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'xacc'}		 ... %% X acceleration (raw)
		{'yacc'}		 ... %% Y acceleration (raw)
		{'zacc'}		 ... %% Z acceleration (raw)
		{'xgyro'}		 ... %% Angular speed around X axis (raw)
		{'ygyro'}		 ... %% Angular speed around Y axis (raw)
		{'zgyro'}		 ... %% Angular speed around Z axis (raw)
		{'xmag'}		 ... %% X Magnetic field (raw)
		{'ymag'}		 ... %% Y Magnetic field (raw)
		{'zmag'}		 ... %% Z Magnetic field (raw)
		];
	byte = [ 8 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

