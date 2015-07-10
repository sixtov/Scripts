%%%%  case: 66
function p = encodeValues_REQUEST_DATA_STREAM_v1_0(target_system,target_component,req_stream_id,req_message_rate,start_stop)
	S.target_system = typecast(uint8(target_system),'uint8');		% The target requested to send the message stream.
	S.target_component = typecast(uint8(target_component),'uint8');		% The target requested to send the message stream.
	S.req_stream_id = typecast(uint8(req_stream_id),'uint8');		% The ID of the requested data stream
	S.req_message_rate = typecast(uint16(req_message_rate),'uint16');		% The requested interval between two messages of this type
	S.start_stop = typecast(uint8(start_stop),'uint8');		% 1 to start sending, 0 to stop sending.
	p = encode_REQUEST_DATA_STREAM_v1_0(S);
return
