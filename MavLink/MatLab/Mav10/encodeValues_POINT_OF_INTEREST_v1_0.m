%%%%  case: 191
%%~ Notifies the operator about a point of interest (POI). This can be anything detected 
%%~ by the                 system. This generic message is intented to help interfacing 
%%~ to generic visualizations and to display                 the POI on a map. 
%%~             
function p = encodeValues_POINT_OF_INTEREST_v1_0(type,color,coordinate_system,timeout,x,y,z,name)
	S.type = typecast(uint8(type),'uint8');		% 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
	S.color = typecast(uint8(color),'uint8');		% 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
	S.coordinate_system = typecast(uint8(coordinate_system),'uint8');		% 0: global, 1:local
	S.timeout = typecast(uint16(timeout),'uint16');		% 0: no timeout, >1: timeout in seconds
	S.x = typecast(single(x),'single');		% X Position
	S.y = typecast(single(y),'single');		% Y Position
	S.z = typecast(single(z),'single');		% Z Position
	S.name = typecast(uint8(name),'uint8');		% POI name
	p = encode_POINT_OF_INTEREST_v1_0(S);
return
