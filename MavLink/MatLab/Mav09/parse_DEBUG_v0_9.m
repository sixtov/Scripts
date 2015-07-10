%%  case: 255
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function S = parse_DEBUG_v0_9(p)
	name = [ ...
		{'ind'}		 ... %% index of debug variable
		{'value'}	 ... %% DEBUG value
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

