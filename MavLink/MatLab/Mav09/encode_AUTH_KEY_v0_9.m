%%  case: 7
%%~ Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
%%~ has been kept simple, so transmitting the key requires an encrypted channel 
%%~ for true safety.
function p = encode_AUTH_KEY_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(32);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(7);
	name = [ ...
		{'key'}	 ... %% key
		];
	byte = [ 32 ];
	type = [ {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode key data field
	val = typecast(S.key,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
