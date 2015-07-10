%%  case: 154
function S = parse_IMAGE_AVAILABLE_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

