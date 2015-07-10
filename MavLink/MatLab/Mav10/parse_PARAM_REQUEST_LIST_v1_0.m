%%  case: 21
%%~ Request all parameters of this component. After his request, all parameters are 
%%~ emitted.
function S = parse_PARAM_REQUEST_LIST_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

