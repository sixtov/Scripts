%%%%  case: 28
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
%%~ contain the true raw values without any scaling to allow data capture and system 
%%~ debugging.
function p = encodeValues_RAW_IMU_v0_9(usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.xacc = typecast(int16(xacc),'int16');		% X acceleration (raw)
	S.yacc = typecast(int16(yacc),'int16');		% Y acceleration (raw)
	S.zacc = typecast(int16(zacc),'int16');		% Z acceleration (raw)
	S.xgyro = typecast(int16(xgyro),'int16');		% Angular speed around X axis (raw)
	S.ygyro = typecast(int16(ygyro),'int16');		% Angular speed around Y axis (raw)
	S.zgyro = typecast(int16(zgyro),'int16');		% Angular speed around Z axis (raw)
	S.xmag = typecast(int16(xmag),'int16');		% X Magnetic field (raw)
	S.ymag = typecast(int16(ymag),'int16');		% Y Magnetic field (raw)
	S.zmag = typecast(int16(zmag),'int16');		% Z Magnetic field (raw)
	p = encode_RAW_IMU_v0_9(S);
return
