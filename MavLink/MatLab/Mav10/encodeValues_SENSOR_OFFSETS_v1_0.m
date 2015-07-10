%%%%  case: 150
%%~ Offsets and calibrations values for hardware         sensors. This makes it easier 
%%~ to debug the calibration process.
function p = encodeValues_SENSOR_OFFSETS_v1_0(mag_ofs_x,mag_ofs_y,mag_ofs_z,mag_declination,raw_press,raw_temp,gyro_cal_x,gyro_cal_y,gyro_cal_z,accel_cal_x,accel_cal_y,accel_cal_z)
	S.mag_ofs_x = typecast(int16(mag_ofs_x),'int16');		% magnetometer X offset
	S.mag_ofs_y = typecast(int16(mag_ofs_y),'int16');		% magnetometer Y offset
	S.mag_ofs_z = typecast(int16(mag_ofs_z),'int16');		% magnetometer Z offset
	S.mag_declination = typecast(single(mag_declination),'single');		% magnetic declination (radians)
	S.raw_press = typecast(int32(raw_press),'int32');		% raw pressure from barometer
	S.raw_temp = typecast(int32(raw_temp),'int32');		% raw temperature from barometer
	S.gyro_cal_x = typecast(single(gyro_cal_x),'single');		% gyro X calibration
	S.gyro_cal_y = typecast(single(gyro_cal_y),'single');		% gyro Y calibration
	S.gyro_cal_z = typecast(single(gyro_cal_z),'single');		% gyro Z calibration
	S.accel_cal_x = typecast(single(accel_cal_x),'single');		% accel X calibration
	S.accel_cal_y = typecast(single(accel_cal_y),'single');		% accel Y calibration
	S.accel_cal_z = typecast(single(accel_cal_z),'single');		% accel Z calibration
	p = encode_SENSOR_OFFSETS_v1_0(S);
return
