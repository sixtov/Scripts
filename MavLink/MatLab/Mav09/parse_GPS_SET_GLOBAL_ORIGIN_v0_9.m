%%  case: 48
%%~ As local waypoints exist, the global waypoint reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should 
%%~ move from in- to outdoor.
function S = parse_GPS_SET_GLOBAL_ORIGIN_v0_9(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'latitude'}		 ... %% global position * 1E7
		{'longitude'}		 ... %% global position * 1E7
		{'altitude'}		 ... %% global position * 1000
		];
	byte = [ 1 1 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

