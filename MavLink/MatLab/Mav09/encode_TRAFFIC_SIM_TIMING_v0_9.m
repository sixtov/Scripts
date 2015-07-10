%%  case: 116
%%~ Message that provides timing information about the traffic simulation
function p = encode_TRAFFIC_SIM_TIMING_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(8);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(116);
	name = [ ...
		{'sim_time'}	 ... %% Traffic simulation absolute time
		{'time_to_wpt'}	 ... %% Absolute time to reach the next waypoint
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode sim_time data field
	val = typecast(S.sim_time,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode time_to_wpt data field
	val = typecast(S.time_to_wpt,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
