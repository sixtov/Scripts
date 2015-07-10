%%  case: 116
%%~ Message that provides timing information about the traffic simulation
function S = parse_TRAFFIC_SIM_TIMING_v0_9(p)
	name = [ ...
		{'sim_time'}	 ... %% Traffic simulation absolute time
		{'time_to_wpt'}	 ... %% Absolute time to reach the next waypoint
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

