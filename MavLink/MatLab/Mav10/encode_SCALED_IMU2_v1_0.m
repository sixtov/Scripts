%%  case: 116
%%~ The RAW IMU readings for secondary 9DOF sensor setup. This message should contain 
%%~ the scaled values to the described units
function p = encode_SCALED_IMU2_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(22);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(116);
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

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
