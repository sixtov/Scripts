%%  case: 73
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up)
function p = encode_GLOBAL_POSITION_INT(S)
	name = [ ...
		{'lat'}	 ... %% Latitude, expressed as * 1E7
		{'lon'}	 ... %% Longitude, expressed as * 1E7
		{'alt'}	 ... %% Altitude in meters, expressed as * 1000 (millimeters)
		{'vx'}	 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}	 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}	 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		];
	byte = [ 4 4 4 2 2 2 ];
	type = [ {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} ];

	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lon data field
	val = typecast(S.lon,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vx data field
	val = typecast(S.vx,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vy data field
	val = typecast(S.vy,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vz data field
	val = typecast(S.vz,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
