%%  case: 171
function p = encode_MARKER_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(26);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(171);
	name = [ ...
		{'id'}		 ... %% ID
		{'x'}		 ... %% x position
		{'y'}		 ... %% y position
		{'z'}		 ... %% z position
		{'roll'}	 ... %% roll orientation
		{'pitch'}	 ... %% pitch orientation
		{'yaw'}		 ... %% yaw orientation
		];
	byte = [ 2 4 4 4 4 4 4 ];
	type = [ {'uint16'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode id data field
	val = typecast(S.id,'uint16');
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
