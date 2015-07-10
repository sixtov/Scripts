%%  case: 191
%%~ Notifies the operator about a point of interest (POI). This can be anything detected 
%%~ by the                 system. This generic message is intented to help interfacing 
%%~ to generic visualizations and to display                 the POI on a map. 
%%~             
function S = parse_POINT_OF_INTEREST_v1_0(p)
	name = [ ...
		{'type'}				 ... %% 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
		{'color'}				 ... %% 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
		{'coordinate_system'}	 ... %% 0: global, 1:local
		{'timeout'}				 ... %% 0: no timeout, >1: timeout in seconds
		{'x'}					 ... %% X Position
		{'y'}					 ... %% Y Position
		{'z'}					 ... %% Z Position
		{'name'}				 ... %% POI name
		];
	byte = [ 1 1 1 2 4 4 4 26 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'single'} {'single'} {'single'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

