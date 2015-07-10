%%%%  case: 192
%%~ Notifies the operator about the connection of two point of interests (POI). This 
%%~ can be anything detected by the                 system. This generic message is 
%%~ intented to help interfacing to generic visualizations and to display          
%%~        the POI on a map.             
function p = encodeValues_POINT_OF_INTEREST_CONNECTION_v1_0(type,color,coordinate_system,timeout,xp1,yp1,zp1,xp2,yp2,zp2,name)
	S.type = typecast(uint8(type),'uint8');		% 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
	S.color = typecast(uint8(color),'uint8');		% 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
	S.coordinate_system = typecast(uint8(coordinate_system),'uint8');		% 0: global, 1:local
	S.timeout = typecast(uint16(timeout),'uint16');		% 0: no timeout, >1: timeout in seconds
	S.xp1 = typecast(single(xp1),'single');		% X1 Position
	S.yp1 = typecast(single(yp1),'single');		% Y1 Position
	S.zp1 = typecast(single(zp1),'single');		% Z1 Position
	S.xp2 = typecast(single(xp2),'single');		% X2 Position
	S.yp2 = typecast(single(yp2),'single');		% Y2 Position
	S.zp2 = typecast(single(zp2),'single');		% Z2 Position
	S.name = typecast(uint8(name),'uint8');		% POI connection name
	p = encode_POINT_OF_INTEREST_CONNECTION_v1_0(S);
return
