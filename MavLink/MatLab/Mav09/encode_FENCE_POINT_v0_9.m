%%  case: 160
%%~ A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
%%~ a point from MAV -> GCS
function p = encode_FENCE_POINT_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(12);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(160);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 1, 0 is for return point)
		{'count'}			 ... %% total number of points (for sanity checking)
		{'lat'}				 ... %% Latitude of point
		{'lng'}				 ... %% Longitude of point
		];
	byte = [ 1 1 1 1 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode idx data field
	val = typecast(S.idx,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode count data field
	val = typecast(S.count,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lng data field
	val = typecast(S.lng,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
