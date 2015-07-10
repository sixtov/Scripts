%%  case: 52
function p = encode_CONTROL_STATUS_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(8);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(52);
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

	p = [head len pnum sysid id messid];
	%% Encode position_fix data field
	val = typecast(S.position_fix,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vision_fix data field
	val = typecast(S.vision_fix,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode gps_fix data field
	val = typecast(S.gps_fix,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ahrs_health data field
	val = typecast(S.ahrs_health,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode control_att data field
	val = typecast(S.control_att,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode control_pos_xy data field
	val = typecast(S.control_pos_xy,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode control_pos_z data field
	val = typecast(S.control_pos_z,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode control_pos_yaw data field
	val = typecast(S.control_pos_yaw,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
