%%  case: 105
%%~ The IMU readings in SI units in NED body frame
function p = encode_HIGHRES_IMU(S)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'xacc'}			 ... %% X acceleration (m/s^2)
		{'yacc'}			 ... %% Y acceleration (m/s^2)
		{'zacc'}			 ... %% Z acceleration (m/s^2)
		{'xgyro'}			 ... %% Angular speed around X axis (rad / sec)
		{'ygyro'}			 ... %% Angular speed around Y axis (rad / sec)
		{'zgyro'}			 ... %% Angular speed around Z axis (rad / sec)
		{'xmag'}			 ... %% X Magnetic field (Gauss)
		{'ymag'}			 ... %% Y Magnetic field (Gauss)
		{'zmag'}			 ... %% Z Magnetic field (Gauss)
		{'abs_pressure'}	 ... %% Absolute pressure in millibar
		{'diff_pressure'}	 ... %% Differential pressure in millibar
		{'pressure_alt'}	 ... %% Altitude calculated from pressure
		{'temperature'}		 ... %% Temperature in degrees celsius
		{'fields_updated'}	 ... %% Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
		];
	byte = [ 8 4 4 4 4 4 4 4 4 4 4 4 4 4 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint16'} ];

	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xacc data field
	val = typecast(S.xacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yacc data field
	val = typecast(S.yacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zacc data field
	val = typecast(S.zacc,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xgyro data field
	val = typecast(S.xgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ygyro data field
	val = typecast(S.ygyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zgyro data field
	val = typecast(S.zgyro,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xmag data field
	val = typecast(S.xmag,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ymag data field
	val = typecast(S.ymag,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zmag data field
	val = typecast(S.zmag,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode abs_pressure data field
	val = typecast(S.abs_pressure,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode diff_pressure data field
	val = typecast(S.diff_pressure,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pressure_alt data field
	val = typecast(S.pressure_alt,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode temperature data field
	val = typecast(S.temperature,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode fields_updated data field
	val = typecast(S.fields_updated,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
