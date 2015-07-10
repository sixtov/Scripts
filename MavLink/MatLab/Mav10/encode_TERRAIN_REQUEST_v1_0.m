%%  case: 133
%%~ Request for terrain data and terrain status
function p = encode_TERRAIN_REQUEST_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(18);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(133);
	name = [ ...
		{'lat'}			 ... %% Latitude of SW corner of first grid (degrees *10^7)
		{'lon'}			 ... %% Longitude of SW corner of first grid (in degrees *10^7)
		{'grid_spacing'} ... %% Grid spacing in meters
		{'mask'}		 ... %% Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits)
		];
	byte = [ 4 4 2 8 ];
	type = [ {'int32'} {'int32'} {'uint16'} {'uint64'} ];

	p = [head len pnum sysid id messid];
	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode grid_spacing data field
	val = typecast(S.grid_spacing,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mask data field
	val = typecast(S.mask,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
