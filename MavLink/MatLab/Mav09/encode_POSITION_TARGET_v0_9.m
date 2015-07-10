%%  case: 63
%%~ The goal position of the system. This position is the input to any navigation or 
%%~ path planning algorithm and does NOT represent the current controller setpoint.
function p = encode_POSITION_TARGET_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(16);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(63);
	name = [ ...
		{'x'}	 ... %% x position
		{'y'}	 ... %% y position
		{'z'}	 ... %% z position
		{'yaw'}	 ... %% yaw orientation in radians, 0 = NORTH
		];
	byte = [ 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
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

	%% Encode yaw data field
	val = typecast(S.yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
