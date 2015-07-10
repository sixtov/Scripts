%%%%  case: 190
function p = encodeValues_PATTERN_DETECTED_v1_0(type,confidence,file,detected)
	S.type = typecast(uint8(type),'uint8');		% 0: Pattern, 1: Letter
	S.confidence = typecast(single(confidence),'single');		% Confidence of detection
	S.file = typecast(uint8(file),'uint8');		% Pattern file name
	S.detected = typecast(uint8(detected),'uint8');		% Accepted as true detection, 0 no, 1 yes
	p = encode_PATTERN_DETECTED_v1_0(S);
return
