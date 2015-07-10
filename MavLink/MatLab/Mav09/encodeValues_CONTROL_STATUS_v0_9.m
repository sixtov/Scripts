%%%%  case: 52
function p = encodeValues_CONTROL_STATUS_v0_9(position_fix,vision_fix,gps_fix,ahrs_health,control_att,control_pos_xy,control_pos_z,control_pos_yaw)
	S.position_fix = typecast(uint8(position_fix),'uint8');		% Position fix: 0: lost, 2: 2D position fix, 3: 3D position fix 
	S.vision_fix = typecast(uint8(vision_fix),'uint8');		% Vision position fix: 0: lost, 1: 2D local position hold, 2: 2D global position fix, 3: 3D global position fix 
	S.gps_fix = typecast(uint8(gps_fix),'uint8');		% GPS position fix: 0: no reception, 1: Minimum 1 satellite, but no position fix, 2: 2D position fix, 3: 3D position fix 
	S.ahrs_health = typecast(uint8(ahrs_health),'uint8');		% Attitude estimation health: 0: poor, 255: excellent
	S.control_att = typecast(uint8(control_att),'uint8');		% 0: Attitude control disabled, 1: enabled
	S.control_pos_xy = typecast(uint8(control_pos_xy),'uint8');		% 0: X, Y position control disabled, 1: enabled
	S.control_pos_z = typecast(uint8(control_pos_z),'uint8');		% 0: Z position control disabled, 1: enabled
	S.control_pos_yaw = typecast(uint8(control_pos_yaw),'uint8');		% 0: Yaw angle control disabled, 1: enabled
	p = encode_CONTROL_STATUS_v0_9(S);
return
