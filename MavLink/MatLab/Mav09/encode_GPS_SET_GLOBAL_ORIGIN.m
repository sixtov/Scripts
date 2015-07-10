%%  case: 48
%%~ As local waypoints exist, the global waypoint reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should 
%%~ move from in- to outdoor.
function p = encode_GPS_SET_GLOBAL_ORIGIN(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'latitude'}		 ... %% global position * 1E7
		{'longitude'}		 ... %% global position * 1E7
		{'altitude'}		 ... %% global position * 1000
		];
	byte = [ 1 1 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

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
