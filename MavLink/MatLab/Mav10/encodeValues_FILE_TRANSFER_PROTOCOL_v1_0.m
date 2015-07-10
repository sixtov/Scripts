%%%%  case: 110
%%~ File transfer message
function p = encodeValues_FILE_TRANSFER_PROTOCOL_v1_0(target_network,target_system,target_component,payload)
	S.target_network = typecast(uint8(target_network),'uint8');		% Network ID (0 for broadcast)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID (0 for broadcast)
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID (0 for broadcast)
	S.payload = typecast(uint8(payload),'uint8');		% Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
	p = encode_FILE_TRANSFER_PROTOCOL_v1_0(S);
return
