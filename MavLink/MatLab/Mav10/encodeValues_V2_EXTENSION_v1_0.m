%%%%  case: 248
%%~ Message implementing parts of the V2 payload specs in V1 frames for transitional 
%%~ support.
function p = encodeValues_V2_EXTENSION_v1_0(target_network,target_system,target_component,message_type,payload)
	S.target_network = typecast(uint8(target_network),'uint8');		% Network ID (0 for broadcast)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID (0 for broadcast)
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID (0 for broadcast)
	S.message_type = typecast(uint16(message_type),'uint16');		% A code that identifies the software component that understands this message (analogous to usb device classes or mime type strings).  If this code is less than 32768, it is considered a 'registered' protocol extension and the corresponding entry should be added to https://github.com/mavlink/mavlink/extension-message-ids.xml.  Software creators can register blocks of message IDs as needed (useful for GCS specific metadata, etc...). Message_types greater than 32767 are considered local experiments and should not be checked in to any widely distributed codebase.
	S.payload = typecast(uint8(payload),'uint8');		% Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
	p = encode_V2_EXTENSION_v1_0(S);
return
