%%  case: 190
function S = parse_PATTERN_DETECTED_v1_0(p)
	name = [ ...
		{'type'}		 ... %% 0: Pattern, 1: Letter
		{'confidence'}	 ... %% Confidence of detection
		{'file'}		 ... %% Pattern file name
		{'detected'}	 ... %% Accepted as true detection, 0 no, 1 yes
		];
	byte = [ 1 4 100 1 ];
	type = [ {'uint8'} {'single'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

