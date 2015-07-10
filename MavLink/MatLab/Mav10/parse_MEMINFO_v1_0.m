%%  case: 152
%%~ state of APM memory
function S = parse_MEMINFO_v1_0(p)
	name = [ ...
		{'brkval'}	 ... %% heap top
		{'freemem'}	 ... %% free memory
		];
	byte = [ 2 2 ];
	type = [ {'uint16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

