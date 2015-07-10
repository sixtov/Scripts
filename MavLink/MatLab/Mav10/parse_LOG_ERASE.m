%%  case: 121
%%~ Erase all logs
function S = parse_LOG_ERASE(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

