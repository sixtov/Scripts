%%%%  case: 140
%%~ Object has been detected
function p = encodeValues_OBJECT_DETECTION_EVENT_v0_9(time,object_id,type,name,quality,bearing,distance)
	S.time = typecast(uint32(time),'uint32');		% Timestamp in milliseconds since system boot
	S.object_id = typecast(uint16(object_id),'uint16');		% Object ID
	S.type = typecast(uint8(type),'uint8');		% Object type: 0: image, 1: letter, 2: ground vehicle, 3: air vehicle, 4: surface vehicle, 5: sub-surface vehicle, 6: human, 7: animal
	S.name = typecast(uint8(name),'uint8');		% Name of the object as defined by the detector
	S.quality = typecast(uint8(quality),'uint8');		% Detection quality / confidence. 0: bad, 255: maximum confidence
	S.bearing = typecast(single(bearing),'single');		% Angle of the object with respect to the body frame in NED coordinates in radians. 0: front
	S.distance = typecast(single(distance),'single');		% Ground distance in meters
	p = encode_OBJECT_DETECTION_EVENT_v0_9(S);
return
