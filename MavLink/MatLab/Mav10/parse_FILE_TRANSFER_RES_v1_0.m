%%  case: 112
%%~ File transfer result
function S = parse_FILE_TRANSFER_RES_v1_0(S,p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'result'}		 ... %% 0: OK, 1: not permitted, 2: bad path / file name, 3: no space left on device
		];
	byte = [ 8 1 ];
	type = [ {'uint64'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

