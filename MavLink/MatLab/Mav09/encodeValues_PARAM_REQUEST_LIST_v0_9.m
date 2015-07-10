%%%%  case: 21
%%~ Request all parameters of this component. After his request, all parameters are 
%%~ emitted.
function p = encodeValues_PARAM_REQUEST_LIST_v0_9(target_system,target_component)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	p = encode_PARAM_REQUEST_LIST_v0_9(S);
return
