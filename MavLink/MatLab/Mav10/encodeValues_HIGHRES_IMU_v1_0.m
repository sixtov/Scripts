%%%%  case: 105
%%~ The IMU readings in SI units in NED body frame
function p = encodeValues_HIGHRES_IMU_v1_0(time_usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag,abs_pressure,diff_pressure,pressure_alt,temperature,fields_updated)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (microseconds, synced to UNIX time or since system boot)
	S.xacc = typecast(single(xacc),'single');		% X acceleration (m/s^2)
	S.yacc = typecast(single(yacc),'single');		% Y acceleration (m/s^2)
	S.zacc = typecast(single(zacc),'single');		% Z acceleration (m/s^2)
	S.xgyro = typecast(single(xgyro),'single');		% Angular speed around X axis (rad / sec)
	S.ygyro = typecast(single(ygyro),'single');		% Angular speed around Y axis (rad / sec)
	S.zgyro = typecast(single(zgyro),'single');		% Angular speed around Z axis (rad / sec)
	S.xmag = typecast(single(xmag),'single');		% X Magnetic field (Gauss)
	S.ymag = typecast(single(ymag),'single');		% Y Magnetic field (Gauss)
	S.zmag = typecast(single(zmag),'single');		% Z Magnetic field (Gauss)
	S.abs_pressure = typecast(single(abs_pressure),'single');		% Absolute pressure in millibar
	S.diff_pressure = typecast(single(diff_pressure),'single');		% Differential pressure in millibar
	S.pressure_alt = typecast(single(pressure_alt),'single');		% Altitude calculated from pressure
	S.temperature = typecast(single(temperature),'single');		% Temperature in degrees celsius
	S.fields_updated = typecast(uint16(fields_updated),'uint16');		% Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
	p = encode_HIGHRES_IMU_v1_0(S);
return
