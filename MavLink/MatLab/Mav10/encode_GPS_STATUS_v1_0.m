%%  case: 25
%%~ The positioning status, as reported by GPS. This message is intended to display 
%%~ status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
%%~ for the global position estimate. This message can contain information 
%%~ for up to 20 satellites.
function p = encode_GPS_STATUS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(101);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(25);
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

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
