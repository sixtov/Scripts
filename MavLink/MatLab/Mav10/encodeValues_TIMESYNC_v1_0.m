%%%%  case: 111
%%~ Time synchronization message.
function p = encodeValues_TIMESYNC_v1_0(tc1,ts1)
	S.tc1 = typecast(int64(tc1),'int64');		% Time sync timestamp 1
	S.ts1 = typecast(int64(ts1),'int64');		% Time sync timestamp 2
	p = encode_TIMESYNC_v1_0(S);
return
