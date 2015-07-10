%%  case: 27
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
%%~ contain the true raw values without any scaling to allow data capture and system 
%%~ debugging.
function p = encode_RAW_IMU(S)
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

	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xacc data field
	val = typecast(S.xacc,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yacc data field
	val = typecast(S.yacc,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zacc data field
	val = typecast(S.zacc,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xgyro data field
	val = typecast(S.xgyro,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ygyro data field
	val = typecast(S.ygyro,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zgyro data field
	val = typecast(S.zgyro,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xmag data field
	val = typecast(S.xmag,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ymag data field
	val = typecast(S.ymag,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zmag data field
	val = typecast(S.zmag,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
