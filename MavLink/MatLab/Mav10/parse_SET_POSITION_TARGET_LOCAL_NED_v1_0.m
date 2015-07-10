%%  case: 84
%%~ Set vehicle position, velocity and acceleration setpoint in local frame.
function S = parse_SET_POSITION_TARGET_LOCAL_NED_v1_0(p)
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp in milliseconds since system boot
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'coordinate_frame'} ... %% Valid options are: MAV_FRAME_LOCAL_NED = 1, MAV_FRAME_LOCAL_OFFSET_NED = 7, MAV_FRAME_BODY_NED = 8, MAV_FRAME_BODY_OFFSET_NED = 9
		{'type_mask'}		 ... %% Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
		{'x'}				 ... %% X Position in NED frame in meters
		{'y'}				 ... %% Y Position in NED frame in meters
		{'z'}				 ... %% Z Position in NED frame in meters (note, altitude is negative in NED)
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
	type = [ {'uint32'} {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

