%%  case: 7
%%~ Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
%%~ has been kept simple, so transmitting the key requires an encrypted channel 
%%~ for true safety.
function p = encode_AUTH_KEY_v1_0(S)
	name = [ ...
		{'key'}	 ... %% key
		];
	byte = [ 32 ];
	type = [ {'uint8'} ];

	p = [];
	%% Encode key data field
	val = typecast(S.key,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
