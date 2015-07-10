%%%%  case: 115
%%~ Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. 
%%~ This packet is useful for high throughput applications such as hardware in the 
%%~ loop simulations.
function p = encodeValues_HIL_STATE_QUATERNION_v1_0(time_usec,attitude_quaternion,rollspeed,pitchspeed,yawspeed,lat,lon,alt,vx,vy,vz,ind_airspeed,true_airspeed,xacc,yacc,zacc)
	S.time_usec = typecast(uint64(time_usec),'uint64');		% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	S.attitude_quaternion = typecast(single(attitude_quaternion),'single');		% Vehicle attitude expressed as normalized quaternion in w, x, y, z order (with 1 0 0 0 being the null-rotation)
	S.rollspeed = typecast(single(rollspeed),'single');		% Body frame roll / phi angular speed (rad/s)
	S.pitchspeed = typecast(single(pitchspeed),'single');		% Body frame pitch / theta angular speed (rad/s)
	S.yawspeed = typecast(single(yawspeed),'single');		% Body frame yaw / psi angular speed (rad/s)
	S.lat = typecast(int32(lat),'int32');		% Latitude, expressed as * 1E7
	S.lon = typecast(int32(lon),'int32');		% Longitude, expressed as * 1E7
	S.alt = typecast(int32(alt),'int32');		% Altitude in meters, expressed as * 1000 (millimeters)
	S.vx = typecast(int16(vx),'int16');		% Ground X Speed (Latitude), expressed as m/s * 100
	S.vy = typecast(int16(vy),'int16');		% Ground Y Speed (Longitude), expressed as m/s * 100
	S.vz = typecast(int16(vz),'int16');		% Ground Z Speed (Altitude), expressed as m/s * 100
	S.ind_airspeed = typecast(uint16(ind_airspeed),'uint16');		% Indicated airspeed, expressed as m/s * 100
	S.true_airspeed = typecast(uint16(true_airspeed),'uint16');		% True airspeed, expressed as m/s * 100
	S.xacc = typecast(int16(xacc),'int16');		% X acceleration (mg)
	S.yacc = typecast(int16(yacc),'int16');		% Y acceleration (mg)
	S.zacc = typecast(int16(zacc),'int16');		% Z acceleration (mg)
	p = encode_HIL_STATE_QUATERNION_v1_0(S);
return
