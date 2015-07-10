%%  case: 136
%%~ Response from a TERRAIN_CHECK request
function p = encode_TERRAIN_REPORT_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(22);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(136);
	name = [ ...
		{'lat'}				 ... %% Latitude (degrees *10^7)
		{'lon'}				 ... %% Longitude (degrees *10^7)
		{'spacing'}			 ... %% grid spacing (zero if terrain at this location unavailable)
		{'terrain_height'}	 ... %% Terrain height in meters AMSL
		{'current_height'}	 ... %% Current vehicle height above lat/lon terrain height (meters)
		{'pending'}			 ... %% Number of 4x4 terrain blocks waiting to be received or read from disk
		{'loaded'}			 ... %% Number of 4x4 terrain blocks in memory
		];
	byte = [ 4 4 2 4 4 2 2 ];
	type = [ {'int32'} {'int32'} {'uint16'} {'single'} {'single'} {'uint16'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode spacing data field
	val = typecast(S.spacing,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode terrain_height data field
	val = typecast(S.terrain_height,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode current_height data field
	val = typecast(S.current_height,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pending data field
	val = typecast(S.pending,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode loaded data field
	val = typecast(S.loaded,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
