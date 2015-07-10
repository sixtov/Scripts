%%%%  case: 130
function p = encodeValues_DATA_TRANSMISSION_HANDSHAKE_v1_0(type,size,width,height,packets,payload,jpg_quality)
	S.type = typecast(uint8(type),'uint8');		% type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h)
	S.size = typecast(uint32(size),'uint32');		% total data size in bytes (set on ACK only)
	S.width = typecast(uint16(width),'uint16');		% Width of a matrix or image
	S.height = typecast(uint16(height),'uint16');		% Height of a matrix or image
	S.packets = typecast(uint16(packets),'uint16');		% number of packets beeing sent (set on ACK only)
	S.payload = typecast(uint8(payload),'uint8');		% payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only)
	S.jpg_quality = typecast(uint8(jpg_quality),'uint8');		% JPEG quality out of [1,100]
	p = encode_DATA_TRANSMISSION_HANDSHAKE_v1_0(S);
return
