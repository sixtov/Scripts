%%  case: 110
%%~ File transfer message
function S = parse_FILE_TRANSFER_PROTOCOL_v1_0(p)
	name = [ ...
		{'target_network'}	 ... %% Network ID (0 for broadcast)
		{'target_system'}	 ... %% System ID (0 for broadcast)
		{'target_component'} ... %% Component ID (0 for broadcast)
		{'payload'}			 ... %% Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
		];
	byte = [ 1 1 1 251 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

