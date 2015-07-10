%%%%  case: 148
%%~ Version and capability of autopilot software
function p = encodeValues_AUTOPILOT_VERSION_v1_0(capabilities,flight_sw_version,middleware_sw_version,os_sw_version,board_version,flight_custom_version,middleware_custom_version,os_custom_version,vendor_id,product_id,uid)
	S.capabilities = typecast(uint64(capabilities),'uint64');		% bitmask of capabilities (see MAV_PROTOCOL_CAPABILITY enum)
	S.flight_sw_version = typecast(uint32(flight_sw_version),'uint32');		% Firmware version number
	S.middleware_sw_version = typecast(uint32(middleware_sw_version),'uint32');		% Middleware version number
	S.os_sw_version = typecast(uint32(os_sw_version),'uint32');		% Operating system version number
	S.board_version = typecast(uint32(board_version),'uint32');		% HW / board version (last 8 bytes should be silicon ID, if any)
	S.flight_custom_version = typecast(uint8(flight_custom_version),'uint8');		% Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
	S.middleware_custom_version = typecast(uint8(middleware_custom_version),'uint8');		% Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
	S.os_custom_version = typecast(uint8(os_custom_version),'uint8');		% Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
	S.vendor_id = typecast(uint16(vendor_id),'uint16');		% ID of the board vendor
	S.product_id = typecast(uint16(product_id),'uint16');		% ID of the product
	S.uid = typecast(uint64(uid),'uint64');		% UID if provided by hardware
	p = encode_AUTOPILOT_VERSION_v1_0(S);
return
