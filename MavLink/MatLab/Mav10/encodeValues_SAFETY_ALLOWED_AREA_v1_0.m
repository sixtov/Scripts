%%%%  case: 55
%%~ Read out the safety zone the MAV currently assumes.
function p = encodeValues_SAFETY_ALLOWED_AREA_v1_0(frame,p1x,p1y,p1z,p2x,p2y,p2z)
	S.frame = typecast(uint8(frame),'uint8');		% Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
	S.p1x = typecast(single(p1x),'single');		% x position 1 / Latitude 1
	S.p1y = typecast(single(p1y),'single');		% y position 1 / Longitude 1
	S.p1z = typecast(single(p1z),'single');		% z position 1 / Altitude 1
	S.p2x = typecast(single(p2x),'single');		% x position 2 / Latitude 2
	S.p2y = typecast(single(p2y),'single');		% y position 2 / Longitude 2
	S.p2z = typecast(single(p2z),'single');		% z position 2 / Altitude 2
	p = encode_SAFETY_ALLOWED_AREA_v1_0(S);
return
