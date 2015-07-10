%%  case: 150
%%~ Offsets and calibrations values for hardware         sensors. This makes it easier 
%%~ to debug the calibration process.
function p = encode_SENSOR_OFFSETS_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(42);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(150);
	name = [ ...
		{'mag_ofs_x'}		 ... %% magnetometer X offset
		{'mag_ofs_y'}		 ... %% magnetometer Y offset
		{'mag_ofs_z'}		 ... %% magnetometer Z offset
		{'mag_declination'}	 ... %% magnetic declination (radians)
		{'raw_press'}		 ... %% raw pressure from barometer
		{'raw_temp'}		 ... %% raw temperature from barometer
		{'gyro_cal_x'}		 ... %% gyro X calibration
		{'gyro_cal_y'}		 ... %% gyro Y calibration
		{'gyro_cal_z'}		 ... %% gyro Z calibration
		{'accel_cal_x'}		 ... %% accel X calibration
		{'accel_cal_y'}		 ... %% accel Y calibration
		{'accel_cal_z'}		 ... %% accel Z calibration
		];
	byte = [ 2 2 2 4 4 4 4 4 4 4 4 4 ];
	type = [ {'int16'} {'int16'} {'int16'} {'single'} {'int32'} {'int32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode mag_ofs_x data field
	val = typecast(S.mag_ofs_x,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mag_ofs_y data field
	val = typecast(S.mag_ofs_y,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mag_ofs_z data field
	val = typecast(S.mag_ofs_z,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mag_declination data field
	val = typecast(S.mag_declination,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode raw_press data field
	val = typecast(S.raw_press,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode raw_temp data field
	val = typecast(S.raw_temp,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode gyro_cal_x data field
	val = typecast(S.gyro_cal_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode gyro_cal_y data field
	val = typecast(S.gyro_cal_y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode gyro_cal_z data field
	val = typecast(S.gyro_cal_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode accel_cal_x data field
	val = typecast(S.accel_cal_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode accel_cal_y data field
	val = typecast(S.accel_cal_y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode accel_cal_z data field
	val = typecast(S.accel_cal_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
