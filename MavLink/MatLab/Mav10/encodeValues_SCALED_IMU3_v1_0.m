%%%%  case: 129
%%~ The RAW IMU readings for 3rd 9DOF sensor setup. This message should contain the 
%%~ scaled values to the described units
function p = encodeValues_SCALED_IMU3_v1_0(time_boot_ms,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp (milliseconds since system boot)
	S.xacc = typecast(int16(xacc),'int16');		% X acceleration (mg)
	S.yacc = typecast(int16(yacc),'int16');		% Y acceleration (mg)
	S.zacc = typecast(int16(zacc),'int16');		% Z acceleration (mg)
	S.xgyro = typecast(int16(xgyro),'int16');		% Angular speed around X axis (millirad /sec)
	S.ygyro = typecast(int16(ygyro),'int16');		% Angular speed around Y axis (millirad /sec)
	S.zgyro = typecast(int16(zgyro),'int16');		% Angular speed around Z axis (millirad /sec)
	S.xmag = typecast(int16(xmag),'int16');		% X Magnetic field (milli tesla)
	S.ymag = typecast(int16(ymag),'int16');		% Y Magnetic field (milli tesla)
	S.zmag = typecast(int16(zmag),'int16');		% Z Magnetic field (milli tesla)
	p = encode_SCALED_IMU3_v1_0(S);
return
