%%%%  case: 126
%%~ Control a serial port. This can be used for raw access to an onboard serial peripheral 
%%~ such as a GPS or telemetry radio. It is designed to make it possible to update 
%%~ the devices firmware via MAVLink messages or change the devices settings. 
%%~ A message with zero bytes can be used to change just the baudrate.
function p = encodeValues_SERIAL_CONTROL_v1_0(device,flags,timeout,baudrate,count,data)
	S.device = typecast(uint8(device),'uint8');		% See SERIAL_CONTROL_DEV enum
	S.flags = typecast(uint8(flags),'uint8');		% See SERIAL_CONTROL_FLAG enum
	S.timeout = typecast(uint16(timeout),'uint16');		% Timeout for reply data in milliseconds
	S.baudrate = typecast(uint32(baudrate),'uint32');		% Baudrate of transfer. Zero means no change.
	S.count = typecast(uint8(count),'uint8');		% how many bytes in this transfer
	S.data = typecast(uint8(data),'uint8');		% serial data
	p = encode_SERIAL_CONTROL_v1_0(S);
return
