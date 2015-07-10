%%  case: 151
function S = parse_SET_CAM_SHUTTER_v1_0(p)
	name = [ ...
		{'cam_no'}		 ... %% Camera id
		{'cam_mode'}	 ... %% Camera mode: 0 = auto, 1 = manual
		{'trigger_pin'}	 ... %% Trigger pin, 0-3 for PtGrey FireFly
		{'interval'}	 ... %% Shutter interval, in microseconds
		{'exposure'}	 ... %% Exposure time, in microseconds
		{'gain'}		 ... %% Camera gain
		];
	byte = [ 1 1 1 2 2 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

