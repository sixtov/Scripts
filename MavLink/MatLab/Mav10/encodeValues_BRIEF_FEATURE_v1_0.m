%%%%  case: 195
function p = encodeValues_BRIEF_FEATURE_v1_0(x,y,z,orientation_assignment,size,orientation,descriptor,response)
	S.x = typecast(single(x),'single');		% x position in m
	S.y = typecast(single(y),'single');		% y position in m
	S.z = typecast(single(z),'single');		% z position in m
	S.orientation_assignment = typecast(uint8(orientation_assignment),'uint8');		% Orientation assignment 0: false, 1:true
	S.size = typecast(uint16(size),'uint16');		% Size in pixels
	S.orientation = typecast(uint16(orientation),'uint16');		% Orientation
	S.descriptor = typecast(uint8(descriptor),'uint8');		% Descriptor
	S.response = typecast(single(response),'single');		% Harris operator response at this location
	p = encode_BRIEF_FEATURE_v1_0(S);
return
