%%  case: 89
%%~ The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
%%~ the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
%%~ Z-axis down (aeronautical frame, NED / north-east-down convention)
function p = encode_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(28);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(89);
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'x'}			 ... %% X Position
		{'y'}			 ... %% Y Position
		{'z'}			 ... %% Z Position
		{'roll'}		 ... %% Roll
		{'pitch'}		 ... %% Pitch
		{'yaw'}			 ... %% Yaw
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_boot_ms data field
	val = typecast(S.time_boot_ms,'uint32');
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
