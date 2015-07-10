%%%%  case: 168
%%~ Wind estimation
function p = encodeValues_WIND_v1_0(direction,speed,speed_z)
	S.direction = typecast(single(direction),'single');		% wind direction that wind is coming from (degrees)
	S.speed = typecast(single(speed),'single');		% wind speed in ground plane (m/s)
	S.speed_z = typecast(single(speed_z),'single');		% vertical wind speed (m/s)
	p = encode_WIND_v1_0(S);
return
