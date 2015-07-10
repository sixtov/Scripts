%%  case: 152
function p = encode_IMAGE_TRIGGERED_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(52);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(152);
	name = [ ...
		{'timestamp'}	 ... %% Timestamp
		{'seq'}			 ... %% IMU seq
		{'roll'}		 ... %% Roll angle in rad
		{'pitch'}		 ... %% Pitch angle in rad
		{'yaw'}			 ... %% Yaw angle in rad
		{'local_z'}		 ... %% Local frame Z coordinate (height over ground)
		{'lat'}			 ... %% GPS X coordinate
		{'lon'}			 ... %% GPS Y coordinate
		{'alt'}			 ... %% Global frame altitude
		{'ground_x'}	 ... %% Ground truth X
		{'ground_y'}	 ... %% Ground truth Y
		{'ground_z'}	 ... %% Ground truth Z
		];
	byte = [ 8 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode timestamp data field
	val = typecast(S.timestamp,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode seq data field
	val = typecast(S.seq,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll data field
	val = typecast(S.roll,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch data field
	val = typecast(S.pitch,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode local_z data field
	val = typecast(S.local_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ground_x data field
	val = typecast(S.ground_x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ground_y data field
	val = typecast(S.ground_y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ground_z data field
	val = typecast(S.ground_z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
