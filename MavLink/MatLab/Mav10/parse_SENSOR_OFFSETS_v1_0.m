%%  case: 150
%%~ Offsets and calibrations values for hardware         sensors. This makes it easier 
%%~ to debug the calibration process.
function S = parse_SENSOR_OFFSETS_v1_0(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

