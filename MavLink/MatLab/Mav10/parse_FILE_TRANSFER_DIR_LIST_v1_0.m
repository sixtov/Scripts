%%  case: 111
%%~ Get directory listing
function S = parse_FILE_TRANSFER_DIR_LIST_v1_0(S,p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dir_path'}	 ... %% Directory path to list
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

