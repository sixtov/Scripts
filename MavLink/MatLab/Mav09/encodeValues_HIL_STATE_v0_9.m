%%%%  case: 67
%%~ This packet is useful for high throughput                 applications such as hardware 
%%~ in the loop simulations.             
function p = encodeValues_HIL_STATE_v0_9(usec,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed,lat,lon,alt,vx,vy,vz,xacc,yacc,zacc)
	S.usec = typecast(uint64(usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.roll = typecast(single(roll),'single');		% Roll angle (rad)
	S.pitch = typecast(single(pitch),'single');		% Pitch angle (rad)
	S.yaw = typecast(single(yaw),'single');		% Yaw angle (rad)
	S.rollspeed = typecast(single(rollspeed),'single');		% Roll angular speed (rad/s)
	S.pitchspeed = typecast(single(pitchspeed),'single');		% Pitch angular speed (rad/s)
	S.yawspeed = typecast(single(yawspeed),'single');		% Yaw angular speed (rad/s)
	S.lat = typecast(int32(lat),'int32');		% Latitude, expressed as * 1E7
	S.lon = typecast(int32(lon),'int32');		% Longitude, expressed as * 1E7
	S.alt = typecast(int32(alt),'int32');		% Altitude in meters, expressed as * 1000 (millimeters)
	S.vx = typecast(int16(vx),'int16');		% Ground X Speed (Latitude), expressed as m/s * 100
	S.vy = typecast(int16(vy),'int16');		% Ground Y Speed (Longitude), expressed as m/s * 100
	S.vz = typecast(int16(vz),'int16');		% Ground Z Speed (Altitude), expressed as m/s * 100
	S.xacc = typecast(int16(xacc),'int16');		% X acceleration (mg)
	S.yacc = typecast(int16(yacc),'int16');		% Y acceleration (mg)
	S.zacc = typecast(int16(zacc),'int16');		% Z acceleration (mg)
	p = encode_HIL_STATE_v0_9(S);
return
