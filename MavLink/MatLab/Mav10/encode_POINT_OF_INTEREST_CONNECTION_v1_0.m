%%  case: 192
%%~ Notifies the operator about the connection of two point of interests (POI). This 
%%~ can be anything detected by the                 system. This generic message is 
%%~ intented to help interfacing to generic visualizations and to display          
%%~        the POI on a map.             
function p = encode_POINT_OF_INTEREST_CONNECTION_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(55);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(192);
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

	%% Encode xp1 data field
	val = typecast(S.xp1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yp1 data field
	val = typecast(S.yp1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zp1 data field
	val = typecast(S.zp1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode xp2 data field
	val = typecast(S.xp2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yp2 data field
	val = typecast(S.yp2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode zp2 data field
	val = typecast(S.zp2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode name data field
	val = typecast(S.name,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
