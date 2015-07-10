%%  case: 126
%%~ Control a serial port. This can be used for raw access to an onboard serial peripheral 
%%~ such as a GPS or telemetry radio. It is designed to make it possible to update 
%%~ the devices firmware via MAVLink messages or change the devices settings. 
%%~ A message with zero bytes can be used to change just the baudrate.
function S = parse_SERIAL_CONTROL_v1_0(p)
	name = [ ...
		{'device'}	 ... %% See SERIAL_CONTROL_DEV enum
		{'flags'}	 ... %% See SERIAL_CONTROL_FLAG enum
		{'timeout'}	 ... %% Timeout for reply data in milliseconds
		{'baudrate'} ... %% Baudrate of transfer. Zero means no change.
		{'count'}	 ... %% how many bytes in this transfer
		{'data'}	 ... %% serial data
		];
	byte = [ 1 1 2 4 1 70 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint32'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

