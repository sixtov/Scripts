%%%%  case: 162
%%~ Status of geo-fencing. Sent in extended      status stream when fencing enabled
function p = encodeValues_FENCE_STATUS_v0_9(breach_status,breach_count,breach_type,breach_time)
	S.breach_status = typecast(uint8(breach_status),'uint8');		% 0 if currently inside fence, 1 if outside
	S.breach_count = typecast(uint16(breach_count),'uint16');		% number of fence breaches
	S.breach_type = typecast(uint8(breach_type),'uint8');		% last breach type (see FENCE_BREACH_* enum)
	S.breach_time = typecast(uint32(breach_time),'uint32');		% time of last breach in milliseconds since boot
	p = encode_FENCE_STATUS_v0_9(S);
return
