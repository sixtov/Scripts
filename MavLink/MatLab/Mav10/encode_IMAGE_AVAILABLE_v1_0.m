%%  case: 154
function p = encode_IMAGE_AVAILABLE_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(92);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(154);
	name = [ ...
		{'cam_id'}			 ... %% Camera id
		{'cam_no'}			 ... %% Camera # (starts with 0)
		{'timestamp'}		 ... %% Timestamp
		{'valid_until'}		 ... %% Until which timestamp this buffer will stay valid
		{'img_seq'}			 ... %% The image sequence number
		{'img_buf_index'}	 ... %% Position of the image in the buffer, starts with 0
		{'width'}			 ... %% Image width
		{'height'}			 ... %% Image height
		{'depth'}			 ... %% Image depth
		{'channels'}		 ... %% Image channels
		{'key'}				 ... %% Shared memory area key
		{'exposure'}		 ... %% Exposure time, in microseconds
		{'gain'}			 ... %% Camera gain
		{'roll'}			 ... %% Roll angle in rad
		{'pitch'}			 ... %% Pitch angle in rad
		{'yaw'}				 ... %% Yaw angle in rad
		{'local_z'}			 ... %% Local frame Z coordinate (height over ground)
		{'lat'}				 ... %% GPS X coordinate
		{'lon'}				 ... %% GPS Y coordinate
		{'alt'}				 ... %% Global frame altitude
		{'ground_x'}		 ... %% Ground truth X
		{'ground_y'}		 ... %% Ground truth Y
		{'ground_z'}		 ... %% Ground truth Z
		];
	byte = [ 8 1 8 8 4 4 2 2 2 1 4 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'uint8'} {'uint64'} {'uint64'} {'uint32'} {'uint32'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} {'uint32'} {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode cam_id data field
	val = typecast(S.cam_id,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode cam_no data field
	val = typecast(S.cam_no,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode timestamp data field
	val = typecast(S.timestamp,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode valid_until data field
	val = typecast(S.valid_until,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode img_seq data field
	val = typecast(S.img_seq,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode img_buf_index data field
	val = typecast(S.img_buf_index,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode width data field
	val = typecast(S.width,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode height data field
	val = typecast(S.height,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode depth data field
	val = typecast(S.depth,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode channels data field
	val = typecast(S.channels,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode key data field
	val = typecast(S.key,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode exposure data field
	val = typecast(S.exposure,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode gain data field
	val = typecast(S.gain,'single');
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
