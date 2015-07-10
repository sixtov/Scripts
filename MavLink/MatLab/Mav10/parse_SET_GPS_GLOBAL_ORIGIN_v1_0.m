%%  case: 48
%%~ As local waypoints exist, the global MISSION reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should move 
%%~ from in- to outdoor.
function S = parse_SET_GPS_GLOBAL_ORIGIN_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'latitude'}		 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}		 ... %% Longitude (WGS84, in degrees * 1E7
		{'altitude'}		 ... %% Altitude (AMSL), in meters * 1000 (positive for up)
		];
	byte = [ 1 4 4 4 ];
	type = [ {'uint8'} {'int32'} {'int32'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

