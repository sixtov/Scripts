%%  case: 111
%%~ Get directory listing
function S = parse_FILE_TRANSFER_DIR_LIST_v1_0(p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dir_path'}	 ... %% Directory path to list
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

