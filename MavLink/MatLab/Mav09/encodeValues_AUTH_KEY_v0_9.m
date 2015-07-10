%%%%  case: 7
%%~ Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
%%~ has been kept simple, so transmitting the key requires an encrypted channel 
%%~ for true safety.
function p = encodeValues_AUTH_KEY_v0_9(key)
	S.key = typecast(uint8(key),'uint8');		% key
	p = encode_AUTH_KEY_v0_9(S);
return
