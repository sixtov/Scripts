%%  case: 110
%%~ Begin file transfer
function S = parse_FILE_TRANSFER_START_v1_0(p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dest_path'}	 ... %% Destination path
		{'direction'}	 ... %% Transfer direction: 0: from requester, 1: to requester
		{'file_size'}	 ... %% File size in bytes
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 4 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} {'uint32'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

