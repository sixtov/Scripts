%%  case: 49
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
function S = parse_GPS_LOCAL_ORIGIN_SET_v0_9(p)
	name = [ ...
		{'latitude'}	 ... %% Latitude (WGS84), expressed as * 1E7
		{'longitude'}	 ... %% Longitude (WGS84), expressed as * 1E7
		{'altitude'}	 ... %% Altitude(WGS84), expressed as * 1000
		];
	byte = [ 4 4 4 ];
	type = [ {'int32'} {'int32'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

