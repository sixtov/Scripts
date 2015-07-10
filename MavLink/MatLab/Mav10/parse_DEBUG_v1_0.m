%%  case: 254
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function S = parse_DEBUG_v1_0(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'ind'}			 ... %% index of debug variable
		{'value'}		 ... %% DEBUG value
		];
	byte = [ 4 1 4 ];
	type = [ {'uint32'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

