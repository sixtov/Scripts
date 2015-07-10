%%  case: 48
%%~ As local waypoints exist, the global MISSION reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should move 
%%~ from in- to outdoor.
function p = encode_SET_GPS_GLOBAL_ORIGIN_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(13);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(48);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'latitude'}		 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}		 ... %% Longitude (WGS84, in degrees * 1E7
		{'altitude'}		 ... %% Altitude (AMSL), in meters * 1000 (positive for up)
		];
	byte = [ 1 4 4 4 ];
	type = [ {'uint8'} {'int32'} {'int32'} {'int32'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
