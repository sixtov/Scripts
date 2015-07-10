%%%%  case: 116
%%~ Message that provides timing information about the traffic simulation
function p = encodeValues_TRAFFIC_SIM_TIMING_v0_9(sim_time,time_to_wpt)
	S.sim_time = typecast(single(sim_time),'single');		% Traffic simulation absolute time
	S.time_to_wpt = typecast(single(time_to_wpt),'single');		% Absolute time to reach the next waypoint
	p = encode_TRAFFIC_SIM_TIMING_v0_9(S);
return
