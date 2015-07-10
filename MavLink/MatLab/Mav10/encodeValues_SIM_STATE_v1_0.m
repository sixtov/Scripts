%%%%  case: 108
%%~ Status of simulation environment, if used
function p = encodeValues_SIM_STATE_v1_0(q1,q2,q3,q4,roll,pitch,yaw,xacc,yacc,zacc,xgyro,ygyro,zgyro,lat,lon,alt,std_dev_horz,std_dev_vert,vn,ve,vd)
	S.q1 = typecast(single(q1),'single');		% True attitude quaternion component 1
	S.q2 = typecast(single(q2),'single');		% True attitude quaternion component 2
	S.q3 = typecast(single(q3),'single');		% True attitude quaternion component 3
	S.q4 = typecast(single(q4),'single');		% True attitude quaternion component 4
	S.roll = typecast(single(roll),'single');		% Attitude roll expressed as Euler angles, not recommended except for human-readable outputs
	S.pitch = typecast(single(pitch),'single');		% Attitude pitch expressed as Euler angles, not recommended except for human-readable outputs
	S.yaw = typecast(single(yaw),'single');		% Attitude yaw expressed as Euler angles, not recommended except for human-readable outputs
	S.xacc = typecast(single(xacc),'single');		% X acceleration m/s/s
	S.yacc = typecast(single(yacc),'single');		% Y acceleration m/s/s
	S.zacc = typecast(single(zacc),'single');		% Z acceleration m/s/s
	S.xgyro = typecast(single(xgyro),'single');		% Angular speed around X axis rad/s
	S.ygyro = typecast(single(ygyro),'single');		% Angular speed around Y axis rad/s
	S.zgyro = typecast(single(zgyro),'single');		% Angular speed around Z axis rad/s
	S.lat = typecast(single(lat),'single');		% Latitude in degrees
	S.lon = typecast(single(lon),'single');		% Longitude in degrees
	S.alt = typecast(single(alt),'single');		% Altitude in meters
	S.std_dev_horz = typecast(single(std_dev_horz),'single');		% Horizontal position standard deviation
	S.std_dev_vert = typecast(single(std_dev_vert),'single');		% Vertical position standard deviation
	S.vn = typecast(single(vn),'single');		% True velocity in m/s in NORTH direction in earth-fixed NED frame
	S.ve = typecast(single(ve),'single');		% True velocity in m/s in EAST direction in earth-fixed NED frame
	S.vd = typecast(single(vd),'single');		% True velocity in m/s in DOWN direction in earth-fixed NED frame
	p = encode_SIM_STATE_v1_0(S);
return
