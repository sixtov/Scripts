%%%%  case: 153
function p = encodeValues_IMAGE_TRIGGER_CONTROL_v1_0(enable)
	S.enable = typecast(uint8(enable),'uint8');		% 0 to disable, 1 to enable
	p = encode_IMAGE_TRIGGER_CONTROL_v1_0(S);
return
