%%  case: 195
function p = encode_BRIEF_FEATURE_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(53);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(195);
	name = [ ...
		{'x'}						 ... %% x position in m
		{'y'}						 ... %% y position in m
		{'z'}						 ... %% z position in m
		{'orientation_assignment'}	 ... %% Orientation assignment 0: false, 1:true
		{'size'}					 ... %% Size in pixels
		{'orientation'}				 ... %% Orientation
		{'descriptor'}				 ... %% Descriptor
		{'response'}				 ... %% Harris operator response at this location
		];
	byte = [ 4 4 4 1 2 2 32 4 ];
	type = [ {'single'} {'single'} {'single'} {'uint8'} {'uint16'} {'uint16'} {'uint8'} {'single'} ];

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

	%% Encode orientation_assignment data field
	val = typecast(S.orientation_assignment,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode size data field
	val = typecast(S.size,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode orientation data field
	val = typecast(S.orientation,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode descriptor data field
	val = typecast(S.descriptor,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode response data field
	val = typecast(S.response,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
