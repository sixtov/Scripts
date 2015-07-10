%%  case: 134
%%~ Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon 
%%~ from a TERRAIN_REQUEST
function p = encode_TERRAIN_DATA_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(43);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(134);
	name = [ ...
		{'lat'}			 ... %% Latitude of SW corner of first grid (degrees *10^7)
		{'lon'}			 ... %% Longitude of SW corner of first grid (in degrees *10^7)
		{'grid_spacing'} ... %% Grid spacing in meters
		{'gridbit'}		 ... %% bit within the terrain request mask
		{'data'}		 ... %% Terrain data in meters AMSL
		];
	byte = [ 4 4 2 1 32 ];
	type = [ {'int32'} {'int32'} {'uint16'} {'uint8'} {'int16'} ];

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

	%% Encode gridbit data field
	val = typecast(S.gridbit,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode data data field
	val = typecast(S.data,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
