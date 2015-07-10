%%  case: 116
%%~ Message that provides timing information about the traffic simulation
function S = parse_TRAFFIC_SIM_TIMING_v0_9(S,p)
	name = [ ...
		{'sim_time'}	 ... %% Traffic simulation absolute time
		{'time_to_wpt'}	 ... %% Absolute time to reach the next waypoint
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

