%%  case: 126
%%~ Control a serial port. This can be used for raw access to an onboard serial peripheral 
%%~ such as a GPS or telemetry radio. It is designed to make it possible to update 
%%~ the devices firmware via MAVLink messages or change the devices settings. 
%%~ A message with zero bytes can be used to change just the baudrate.
function p = encode_SERIAL_CONTROL_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(79);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(126);
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

	p = [head len pnum sysid id messid];
	%% Encode device data field
	val = typecast(S.device,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flags data field
	val = typecast(S.flags,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode timeout data field
	val = typecast(S.timeout,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode baudrate data field
	val = typecast(S.baudrate,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode count data field
	val = typecast(S.count,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode data data field
	val = typecast(S.data,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
