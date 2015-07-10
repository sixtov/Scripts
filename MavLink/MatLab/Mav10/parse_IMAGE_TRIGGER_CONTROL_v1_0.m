%%  case: 153
function S = parse_IMAGE_TRIGGER_CONTROL_v1_0(p)
	name = [ ...
		{'enable'}	 ... %% 0 to disable, 1 to enable
		];
	byte = [ 1 ];
	type = [ {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

