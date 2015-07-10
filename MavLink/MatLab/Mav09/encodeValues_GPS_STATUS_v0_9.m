%%%%  case: 27
%%~ The positioning status, as reported by GPS. This message is intended to display 
%%~ status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
%%~ for the global position estimate. This message can contain information 
%%~ for up to 20 satellites.
function p = encodeValues_GPS_STATUS_v0_9(satellites_visible,satellite_prn,satellite_used,satellite_elevation,satellite_azimuth,satellite_snr)
	S.satellites_visible = typecast(uint8(satellites_visible),'uint8');		% Number of satellites visible
	S.satellite_prn = typecast(uint8(satellite_prn),'uint8');		% Global satellite ID
	S.satellite_used = typecast(uint8(satellite_used),'uint8');		% 0: Satellite not used, 1: used for localization
	S.satellite_elevation = typecast(uint8(satellite_elevation),'uint8');		% Elevation (0: right on top of receiver, 90: on the horizon) of satellite
	S.satellite_azimuth = typecast(uint8(satellite_azimuth),'uint8');		% Direction of satellite, 0: 0 deg, 255: 360 deg.
	S.satellite_snr = typecast(uint8(satellite_snr),'uint8');		% Signal to noise ratio of satellite
	p = encode_GPS_STATUS_v0_9(S);
return
