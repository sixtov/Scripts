%%  case: 54
%%~ Read out the safety zone the MAV currently assumes.
function p = encode_SAFETY_ALLOWED_AREA_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(25);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(54);
	name = [ ...
		{'frame'}	 ... %% Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
		{'p1x'}		 ... %% x position 1 / Latitude 1
		{'p1y'}		 ... %% y position 1 / Longitude 1
		{'p1z'}		 ... %% z position 1 / Altitude 1
		{'p2x'}		 ... %% x position 2 / Latitude 2
		{'p2y'}		 ... %% y position 2 / Longitude 2
		{'p2z'}		 ... %% z position 2 / Altitude 2
		];
	byte = [ 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode frame data field
	val = typecast(S.frame,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p1x data field
	val = typecast(S.p1x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p1y data field
	val = typecast(S.p1y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p1z data field
	val = typecast(S.p1z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p2x data field
	val = typecast(S.p2x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p2y data field
	val = typecast(S.p2y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode p2z data field
	val = typecast(S.p2z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
