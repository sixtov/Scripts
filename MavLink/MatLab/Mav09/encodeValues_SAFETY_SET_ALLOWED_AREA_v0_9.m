%%%%  case: 53
%%~ Set a safety zone (volume), which is defined by two corners of a cube. This message 
%%~ can be used to tell the MAV which setpoints/waypoints to accept and which to 
%%~ reject. Safety areas are often enforced by national or competition regulations.
function p = encodeValues_SAFETY_SET_ALLOWED_AREA_v0_9(target_system,target_component,frame,p1x,p1y,p1z,p2x,p2y,p2z)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.frame = typecast(uint8(frame),'uint8');		% Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
	S.p1x = typecast(single(p1x),'single');		% x position 1 / Latitude 1
	S.p1y = typecast(single(p1y),'single');		% y position 1 / Longitude 1
	S.p1z = typecast(single(p1z),'single');		% z position 1 / Altitude 1
	S.p2x = typecast(single(p2x),'single');		% x position 2 / Latitude 2
	S.p2y = typecast(single(p2y),'single');		% y position 2 / Longitude 2
	S.p2z = typecast(single(p2z),'single');		% z position 2 / Altitude 2
	p = encode_SAFETY_SET_ALLOWED_AREA_v0_9(S);
return
