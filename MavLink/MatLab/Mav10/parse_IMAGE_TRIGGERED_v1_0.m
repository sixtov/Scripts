%%  case: 152
function S = parse_IMAGE_TRIGGERED_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

