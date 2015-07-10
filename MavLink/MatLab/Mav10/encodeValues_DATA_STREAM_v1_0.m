%%%%  case: 67
function p = encodeValues_DATA_STREAM_v1_0(stream_id,message_rate,on_off)
	S.stream_id = typecast(uint8(stream_id),'uint8');		% The ID of the requested data stream
	S.message_rate = typecast(uint16(message_rate),'uint16');		% The requested interval between two messages of this type
	S.on_off = typecast(uint8(on_off),'uint8');		% 1 stream is enabled, 0 stream is stopped.
	p = encode_DATA_STREAM_v1_0(S);
return
