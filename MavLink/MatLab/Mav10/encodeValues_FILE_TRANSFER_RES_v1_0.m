%%%%  case: 112
%%~ File transfer result
function p = encodeValues_FILE_TRANSFER_RES_v1_0(transfer_uid,result)
	S.transfer_uid = typecast(uint64(transfer_uid),'uint64');		% Unique transfer ID
	S.result = typecast(uint8(result),'uint8');		% 0: OK, 1: not permitted, 2: bad path / file name, 3: no space left on device
	p = encode_FILE_TRANSFER_RES_v1_0(S);
return
