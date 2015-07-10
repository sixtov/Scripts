%%  case: 125
%%~ Power supply status
function S = parse_POWER_STATUS_v1_0(p)
	name = [ ...
		{'Vcc'}		 ... %% 5V rail voltage in millivolts
		{'Vservo'}	 ... %% servo rail voltage in millivolts
		{'flags'}	 ... %% power supply status flags (see MAV_POWER_STATUS enum)
		];
	byte = [ 2 2 2 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

