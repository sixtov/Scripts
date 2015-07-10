%%  case: 86
%%~ Set vehicle position, velocity and acceleration setpoint in the WGS84 coordinate 
%%~ system.
function S = parse_SET_POSITION_TARGET_GLOBAL_INT_v1_0(p)
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp in milliseconds since system boot. The rationale for the timestamp in the setpoint is to allow the system to compensate for the transport delay of the setpoint. This allows the system to compensate processing latency.
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'coordinate_frame'} ... %% Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11
		{'type_mask'}		 ... %% Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
		{'lat_int'}			 ... %% X Position in WGS84 frame in 1e7 * meters
		{'lon_int'}			 ... %% Y Position in WGS84 frame in 1e7 * meters
		{'alt'}				 ... %% Altitude in meters in AMSL altitude, not WGS84 if absolute or relative, above terrain if GLOBAL_TERRAIN_ALT_INT
		{'vx'}				 ... %% X velocity in NED frame in meter / s
		{'vy'}				 ... %% Y velocity in NED frame in meter / s
		{'vz'}				 ... %% Z velocity in NED frame in meter / s
		{'afx'}				 ... %% X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		{'afy'}				 ... %% Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		{'afz'}				 ... %% Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		{'yaw'}				 ... %% yaw setpoint in rad
		{'yaw_rate'}		 ... %% yaw rate setpoint in rad/s
		];
	byte = [ 4 1 1 1 2 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'int32'} {'int32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

