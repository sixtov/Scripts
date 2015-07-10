%%  case: 106
%%~ Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
function S = parse_OMNIDIRECTIONAL_FLOW_v1_0(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'sensor_id'}		 ... %% Sensor ID
		{'left'}			 ... %% Flow in deci pixels (1 = 0.1 pixel) on left hemisphere
		{'right'}			 ... %% Flow in deci pixels (1 = 0.1 pixel) on right hemisphere
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'front_distance_m'} ... %% Front distance in meters. Positive value (including zero): distance known. Negative value: Unknown distance
		];
	byte = [ 8 1 20 20 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

