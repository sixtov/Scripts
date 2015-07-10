%%  case: 255
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function S = parse_DEBUG(S,p)
	name = [ ...
		{'ind'}		 ... %% index of debug variable
		{'value'}	 ... %% DEBUG value
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

