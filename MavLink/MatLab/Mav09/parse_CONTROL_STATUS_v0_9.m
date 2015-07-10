%%  case: 52
function S = parse_CONTROL_STATUS_v0_9(S,p)
	name = [ ...
		{'position_fix'}	 ... %% Position fix: 0: lost, 2: 2D position fix, 3: 3D position fix 
		{'vision_fix'}		 ... %% Vision position fix: 0: lost, 1: 2D local position hold, 2: 2D global position fix, 3: 3D global position fix 
		{'gps_fix'}			 ... %% GPS position fix: 0: no reception, 1: Minimum 1 satellite, but no position fix, 2: 2D position fix, 3: 3D position fix 
		{'ahrs_health'}		 ... %% Attitude estimation health: 0: poor, 255: excellent
		{'control_att'}		 ... %% 0: Attitude control disabled, 1: enabled
		{'control_pos_xy'}	 ... %% 0: X, Y position control disabled, 1: enabled
		{'control_pos_z'}	 ... %% 0: Z position control disabled, 1: enabled
		{'control_pos_yaw'}	 ... %% 0: Yaw angle control disabled, 1: enabled
		];
	byte = [ 1 1 1 1 1 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

