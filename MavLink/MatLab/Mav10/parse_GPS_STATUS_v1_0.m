%%  case: 25
%%~ The positioning status, as reported by GPS. This message is intended to display 
%%~ status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
%%~ for the global position estimate. This message can contain information 
%%~ for up to 20 satellites.
function S = parse_GPS_STATUS_v1_0(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

