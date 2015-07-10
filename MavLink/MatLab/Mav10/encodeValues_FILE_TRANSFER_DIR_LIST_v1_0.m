%%%%  case: 111
%%~ Get directory listing
function p = encodeValues_FILE_TRANSFER_DIR_LIST_v1_0(transfer_uid,dir_path,flags)
	S.transfer_uid = typecast(uint64(transfer_uid),'uint64');		% Unique transfer ID
	S.dir_path = typecast(uint8(dir_path),'uint8');		% Directory path to list
	S.flags = typecast(uint8(flags),'uint8');		% RESERVED
	p = encode_FILE_TRANSFER_DIR_LIST_v1_0(S);
return
