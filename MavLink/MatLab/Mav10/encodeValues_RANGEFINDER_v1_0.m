%%%%  case: 173
%%~ Rangefinder reporting
function p = encodeValues_RANGEFINDER_v1_0(distance,voltage)
	S.distance = typecast(single(distance),'single');		% distance in meters
	S.voltage = typecast(single(voltage),'single');		% raw voltage if available, zero otherwise
	p = encode_RANGEFINDER_v1_0(S);
return
