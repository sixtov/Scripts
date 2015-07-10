%%  case: 85
%%~ Set vehicle position, velocity and acceleration setpoint in local frame.
function p = encode_POSITION_TARGET_LOCAL_NED_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(51);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(85);
	name = [ ...
		{'time_boot_ms'}	 ... %% Timestamp in milliseconds since system boot
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
	byte = [ 4 1 2 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'uint8'} {'uint16'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode coordinate_frame data field
	val = typecast(S.coordinate_frame,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode type_mask data field
	val = typecast(S.type_mask,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode x data field
	val = typecast(S.x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode y data field
	val = typecast(S.y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode z data field
	val = typecast(S.z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vx data field
	val = typecast(S.vx,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vy data field
	val = typecast(S.vy,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vz data field
	val = typecast(S.vz,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode afx data field
	val = typecast(S.afx,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode afy data field
	val = typecast(S.afy,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode afz data field
	val = typecast(S.afz,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw_rate data field
	val = typecast(S.yaw_rate,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
