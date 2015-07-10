%%%%  case: 84
%%~ Set vehicle position, velocity and acceleration setpoint in local frame.
function p = encodeValues_SET_POSITION_TARGET_LOCAL_NED_v1_0(time_boot_ms,target_system,target_component,coordinate_frame,type_mask,x,y,z,vx,vy,vz,afx,afy,afz,yaw,yaw_rate)
	S.time_boot_ms = typecast(uint32(time_boot_ms),'uint32');		% Timestamp in milliseconds since system boot
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.coordinate_frame = typecast(uint8(coordinate_frame),'uint8');		% Valid options are: MAV_FRAME_LOCAL_NED = 1, MAV_FRAME_LOCAL_OFFSET_NED = 7, MAV_FRAME_BODY_NED = 8, MAV_FRAME_BODY_OFFSET_NED = 9
	S.type_mask = typecast(uint16(type_mask),'uint16');		% Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
	S.x = typecast(single(x),'single');		% X Position in NED frame in meters
	S.y = typecast(single(y),'single');		% Y Position in NED frame in meters
	S.z = typecast(single(z),'single');		% Z Position in NED frame in meters (note, altitude is negative in NED)
	S.vx = typecast(single(vx),'single');		% X velocity in NED frame in meter / s
	S.vy = typecast(single(vy),'single');		% Y velocity in NED frame in meter / s
	S.vz = typecast(single(vz),'single');		% Z velocity in NED frame in meter / s
	S.afx = typecast(single(afx),'single');		% X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
	S.afy = typecast(single(afy),'single');		% Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
	S.afz = typecast(single(afz),'single');		% Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
	S.yaw = typecast(single(yaw),'single');		% yaw setpoint in rad
	S.yaw_rate = typecast(single(yaw_rate),'single');		% yaw rate setpoint in rad/s
	p = encode_SET_POSITION_TARGET_LOCAL_NED_v1_0(S);
return
