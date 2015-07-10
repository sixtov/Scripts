%%  case: 49
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
function p = encode_GPS_GLOBAL_ORIGIN_v1_0(S)
	name = [ ...
		{'latitude'}	 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}	 ... %% Longitude (WGS84), in degrees * 1E7
		{'altitude'}	 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		];
	byte = [ 4 4 4 ];
	type = [ {'int32'} {'int32'} {'int32'} ];

	p = [];
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

return
