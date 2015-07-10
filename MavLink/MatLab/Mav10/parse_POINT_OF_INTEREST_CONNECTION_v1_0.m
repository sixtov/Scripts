%%  case: 192
%%~ Notifies the operator about the connection of two point of interests (POI). This 
%%~ can be anything detected by the                 system. This generic message is 
%%~ intented to help interfacing to generic visualizations and to display          
%%~        the POI on a map.             
function S = parse_POINT_OF_INTEREST_CONNECTION_v1_0(p)
	name = [ ...
		{'type'}				 ... %% 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
		{'color'}				 ... %% 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
		{'coordinate_system'}	 ... %% 0: global, 1:local
		{'timeout'}				 ... %% 0: no timeout, >1: timeout in seconds
		{'xp1'}					 ... %% X1 Position
		{'yp1'}					 ... %% Y1 Position
		{'zp1'}					 ... %% Z1 Position
		{'xp2'}					 ... %% X2 Position
		{'yp2'}					 ... %% Y2 Position
		{'zp2'}					 ... %% Z2 Position
		{'name'}				 ... %% POI connection name
		];
	byte = [ 1 1 1 2 4 4 4 4 4 4 26 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

