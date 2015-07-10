%%  case: 138
%%~ Motion capture attitude and position
function p = encode_ATT_POS_MOCAP_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(36);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(138);
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (micros since boot or Unix epoch)
		{'q'}			 ... %% Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
		{'x'}			 ... %% X position in meters (NED)
		{'y'}			 ... %% Y position in meters (NED)
		{'z'}			 ... %% Z position in meters (NED)
		];
	byte = [ 8 16 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode q data field
	val = typecast(S.q,'single');
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
