%%  case: 110
%%~ Begin file transfer
function S = parse_FILE_TRANSFER_START(S,p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dest_path'}	 ... %% Destination path
		{'direction'}	 ... %% Transfer direction: 0: from requester, 1: to requester
		{'file_size'}	 ... %% File size in bytes
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 4 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} {'uint32'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

