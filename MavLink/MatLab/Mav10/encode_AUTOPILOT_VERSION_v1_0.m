%%  case: 148
%%~ Version and capability of autopilot software
function p = encode_AUTOPILOT_VERSION_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(60);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(148);
	name = [ ...
		{'capabilities'}				 ... %% bitmask of capabilities (see MAV_PROTOCOL_CAPABILITY enum)
		{'flight_sw_version'}			 ... %% Firmware version number
		{'middleware_sw_version'}		 ... %% Middleware version number
		{'os_sw_version'}				 ... %% Operating system version number
		{'board_version'}				 ... %% HW / board version (last 8 bytes should be silicon ID, if any)
		{'flight_custom_version'}		 ... %% Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
		{'middleware_custom_version'}	 ... %% Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
		{'os_custom_version'}			 ... %% Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
		{'vendor_id'}					 ... %% ID of the board vendor
		{'product_id'}					 ... %% ID of the product
		{'uid'}							 ... %% UID if provided by hardware
		];
	byte = [ 8 4 4 4 4 8 8 8 2 2 8 ];
	type = [ {'uint64'} {'uint32'} {'uint32'} {'uint32'} {'uint32'} {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'uint64'} ];

	p = [head len pnum sysid id messid];
	%% Encode capabilities data field
	val = typecast(S.capabilities,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flight_sw_version data field
	val = typecast(S.flight_sw_version,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode middleware_sw_version data field
	val = typecast(S.middleware_sw_version,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode os_sw_version data field
	val = typecast(S.os_sw_version,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode board_version data field
	val = typecast(S.board_version,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flight_custom_version data field
	val = typecast(S.flight_custom_version,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode middleware_custom_version data field
	val = typecast(S.middleware_custom_version,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode os_custom_version data field
	val = typecast(S.os_custom_version,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode vendor_id data field
	val = typecast(S.vendor_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode product_id data field
	val = typecast(S.product_id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode uid data field
	val = typecast(S.uid,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
