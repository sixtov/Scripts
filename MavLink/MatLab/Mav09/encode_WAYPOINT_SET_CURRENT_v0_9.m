%%  case: 41
%%~ Set the waypoint with sequence number seq as current waypoint. This means that the 
%%~ MAV will continue to this waypoint on the shortest path (not following the waypoints 
%%~ in-between).
function p = encode_WAYPOINT_SET_CURRENT_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(4);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(41);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode seq data field
	val = typecast(S.seq,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
