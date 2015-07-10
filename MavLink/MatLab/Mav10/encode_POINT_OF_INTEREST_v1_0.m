%%  case: 191
%%~ Notifies the operator about a point of interest (POI). This can be anything detected 
%%~ by the                 system. This generic message is intented to help interfacing 
%%~ to generic visualizations and to display                 the POI on a map. 
%%~             
function p = encode_POINT_OF_INTEREST_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(43);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(191);
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

	p = [head len pnum sysid id messid];
	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode color data field
	val = typecast(S.color,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode coordinate_system data field
	val = typecast(S.coordinate_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode timeout data field
	val = typecast(S.timeout,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode x data field
	val = typecast(S.x,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode y data field
	val = typecast(S.y,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode z data field
	val = typecast(S.z,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
