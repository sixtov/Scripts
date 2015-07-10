%%  case: 148
%%~ Version and capability of autopilot software
function S = parse_AUTOPILOT_VERSION_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

