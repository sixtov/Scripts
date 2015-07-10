%%%%  case: 74
%%~ Metrics typically displayed on a HUD for fixed wing aircraft
function p = encodeValues_VFR_HUD_v1_0(airspeed,groundspeed,heading,throttle,alt,climb)
	S.airspeed = typecast(single(airspeed),'single');		% Current airspeed in m/s
	S.groundspeed = typecast(single(groundspeed),'single');		% Current ground speed in m/s
	S.heading = typecast(int16(heading),'int16');		% Current heading in degrees, in compass units (0..360, 0=north)
	S.throttle = typecast(uint16(throttle),'uint16');		% Current throttle setting in integer percent, 0 to 100
	S.alt = typecast(single(alt),'single');		% Current altitude (MSL), in meters
	S.climb = typecast(single(climb),'single');		% Current climb rate in meters/second
	p = encode_VFR_HUD_v1_0(S);
return
