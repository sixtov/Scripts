%%%%  case: 164
%%~ Status of simulation environment, if used
function p = encodeValues_SIMSTATE_v1_0(roll,pitch,yaw,xacc,yacc,zacc,xgyro,ygyro,zgyro,lat,lng)
	S.roll = typecast(single(roll),'single');		% Roll angle (rad)
	S.pitch = typecast(single(pitch),'single');		% Pitch angle (rad)
	S.yaw = typecast(single(yaw),'single');		% Yaw angle (rad)
	S.xacc = typecast(single(xacc),'single');		% X acceleration m/s/s
	S.yacc = typecast(single(yacc),'single');		% Y acceleration m/s/s
	S.zacc = typecast(single(zacc),'single');		% Z acceleration m/s/s
	S.xgyro = typecast(single(xgyro),'single');		% Angular speed around X axis rad/s
	S.ygyro = typecast(single(ygyro),'single');		% Angular speed around Y axis rad/s
	S.zgyro = typecast(single(zgyro),'single');		% Angular speed around Z axis rad/s
	S.lat = typecast(int32(lat),'int32');		% Latitude in degrees * 1E7
	S.lng = typecast(int32(lng),'int32');		% Longitude in degrees * 1E7
	p = encode_SIMSTATE_v1_0(S);
return
