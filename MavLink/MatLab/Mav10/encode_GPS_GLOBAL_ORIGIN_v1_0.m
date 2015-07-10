%%  case: 49
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
function p = encode_GPS_GLOBAL_ORIGIN_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(12);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(49);
	name = [ ...
		{'latitude'}	 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}	 ... %% Longitude (WGS84), in degrees * 1E7
		{'altitude'}	 ... %% Altitude (AMSL), in meters * 1000 (positive for up)
		];
	byte = [ 4 4 4 ];
	type = [ {'int32'} {'int32'} {'int32'} ];

	p = [head len pnum sysid id messid];
	%% Encode latitude data field
	val = typecast(S.latitude,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode longitude data field
	val = typecast(S.longitude,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode altitude data field
	val = typecast(S.altitude,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
