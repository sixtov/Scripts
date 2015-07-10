%%  case: 27
%%~ The positioning status, as reported by GPS. This message is intended to display 
%%~ status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
%%~ for the global position estimate. This message can contain information 
%%~ for up to 20 satellites.
function p = encode_GPS_STATUS(S)
	name = [ ...
		{'satellites_visible'}	 ... %% Number of satellites visible
		{'satellite_prn'}		 ... %% Global satellite ID
		{'satellite_used'}		 ... %% 0: Satellite not used, 1: used for localization
		{'satellite_elevation'}	 ... %% Elevation (0: right on top of receiver, 90: on the horizon) of satellite
		{'satellite_azimuth'}	 ... %% Direction of satellite, 0: 0 deg, 255: 360 deg.
		{'satellite_snr'}		 ... %% Signal to noise ratio of satellite
		];
	byte = [ 1 20 20 20 20 20 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	%% Encode satellites_visible data field
	val = typecast(S.satellites_visible,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode satellite_prn data field
	val = typecast(S.satellite_prn,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode satellite_used data field
	val = typecast(S.satellite_used,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode satellite_elevation data field
	val = typecast(S.satellite_elevation,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode satellite_azimuth data field
	val = typecast(S.satellite_azimuth,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode satellite_snr data field
	val = typecast(S.satellite_snr,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
