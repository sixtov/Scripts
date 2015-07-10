%%  case: 135
%%~ Request that the vehicle report terrain height at the given location. Used by GCS 
%%~ to check if vehicle has all terrain data needed for a mission.
function p = encode_TERRAIN_CHECK_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(8);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(135);
	name = [ ...
		{'lat'}	 ... %% Latitude (degrees *10^7)
		{'lon'}	 ... %% Longitude (degrees *10^7)
		];
	byte = [ 4 4 ];
	type = [ {'int32'} {'int32'} ];

	p = [head len pnum sysid id messid];
	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
