%%  case: 248
%%~ Message implementing parts of the V2 payload specs in V1 frames for transitional 
%%~ support.
function S = parse_V2_EXTENSION_v1_0(p)
	name = [ ...
		{'target_network'}	 ... %% Network ID (0 for broadcast)
		{'target_system'}	 ... %% System ID (0 for broadcast)
		{'target_component'} ... %% Component ID (0 for broadcast)
		{'message_type'}	 ... %% A code that identifies the software component that understands this message (analogous to usb device classes or mime type strings).  If this code is less than 32768, it is considered a 'registered' protocol extension and the corresponding entry should be added to https://github.com/mavlink/mavlink/extension-message-ids.xml.  Software creators can register blocks of message IDs as needed (useful for GCS specific metadata, etc...). Message_types greater than 32767 are considered local experiments and should not be checked in to any widely distributed codebase.
		{'payload'}			 ... %% Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
		];
	byte = [ 1 1 1 2 249 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

