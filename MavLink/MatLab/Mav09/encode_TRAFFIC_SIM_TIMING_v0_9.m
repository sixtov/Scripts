%%  case: 116
%%~ Message that provides timing information about the traffic simulation
function p = encode_TRAFFIC_SIM_TIMING_v0_9(S)
	name = [ ...
		{'sim_time'}	 ... %% Traffic simulation absolute time
		{'time_to_wpt'}	 ... %% Absolute time to reach the next waypoint
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	p = [];
	%% Encode sim_time data field
	val = typecast(S.sim_time,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time_to_wpt data field
	val = typecast(S.time_to_wpt,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
