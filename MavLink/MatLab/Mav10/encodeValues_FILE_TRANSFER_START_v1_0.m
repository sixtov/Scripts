%%%%  case: 110
%%~ Begin file transfer
function p = encodeValues_FILE_TRANSFER_START_v1_0(transfer_uid,dest_path,direction,file_size,flags)
	S.transfer_uid = typecast(uint64(transfer_uid),'uint64');		% Unique transfer ID
	S.dest_path = typecast(uint8(dest_path),'uint8');		% Destination path
	S.direction = typecast(uint8(direction),'uint8');		% Transfer direction: 0: from requester, 1: to requester
	S.file_size = typecast(uint32(file_size),'uint32');		% File size in bytes
	S.flags = typecast(uint8(flags),'uint8');		% RESERVED
	p = encode_FILE_TRANSFER_START_v1_0(S);
return
