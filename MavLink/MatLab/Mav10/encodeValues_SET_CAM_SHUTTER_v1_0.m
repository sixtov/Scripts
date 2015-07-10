%%%%  case: 151
function p = encodeValues_SET_CAM_SHUTTER_v1_0(cam_no,cam_mode,trigger_pin,interval,exposure,gain)
	S.cam_no = typecast(uint8(cam_no),'uint8');		% Camera id
	S.cam_mode = typecast(uint8(cam_mode),'uint8');		% Camera mode: 0 = auto, 1 = manual
	S.trigger_pin = typecast(uint8(trigger_pin),'uint8');		% Trigger pin, 0-3 for PtGrey FireFly
	S.interval = typecast(uint16(interval),'uint16');		% Shutter interval, in microseconds
	S.exposure = typecast(uint16(exposure),'uint16');		% Exposure time, in microseconds
	S.gain = typecast(single(gain),'single');		% Camera gain
	p = encode_SET_CAM_SHUTTER_v1_0(S);
return
