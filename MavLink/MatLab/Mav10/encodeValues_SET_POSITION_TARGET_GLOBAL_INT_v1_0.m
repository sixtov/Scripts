%%%%  case: 86
%%~ Set vehicle position, velocity and acceleration setpoint in the WGS84 coordinate 
%%~ system.
function p = encodeValues_SET_POSITION_TARGET_GLOBAL_INT_v1_0(time_boot_ms,target_system,target_component,coordinate_frame,type_mask,lat_int,lon_int,alt,vx,vy,vz,afx,afy,afz,yaw,yaw_rate)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp in milliseconds since system boot. The rationale for the timestamp in the setpoint is to allow the system to compensate for the transport delay of the setpoint. This allows the system to compensate processing latency.
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.coordinate_frame = typecast(uint8(coordinate_frame),'uint8');		% Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11
	S.type_mask = typecast(uint16(type_mask),'uint16');		% Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
	S.lat_int = typecast(int32(lat_int),'int32');		% X Position in WGS84 frame in 1e7 * meters
	S.lon_int = typecast(int32(lon_int),'int32');		% Y Position in WGS84 frame in 1e7 * meters
	S.alt = typecast(single(alt),'single');		% Altitude in meters in AMSL altitude, not WGS84 if absolute or relative, above terrain if GLOBAL_TERRAIN_ALT_INT
	S.vx = typecast(single(vx),'single');		% X velocity in NED frame in meter / s
	S.vy = typecast(single(vy),'single');		% Y velocity in NED frame in meter / s
	S.vz = typecast(single(vz),'single');		% Z velocity in NED frame in meter / s
	S.afx = typecast(single(afx),'single');		% X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
	S.afy = typecast(single(afy),'single');		% Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
	S.afz = typecast(single(afz),'single');		% Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
	S.yaw = typecast(single(yaw),'single');		% yaw setpoint in rad
	S.yaw_rate = typecast(single(yaw_rate),'single');		% yaw rate setpoint in rad/s
	p = encode_SET_POSITION_TARGET_GLOBAL_INT_v1_0(S);
return
