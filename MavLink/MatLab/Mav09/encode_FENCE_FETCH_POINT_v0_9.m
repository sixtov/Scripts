%%  case: 161
%%~ Request a current fence point from MAV
function p = encode_FENCE_FETCH_POINT_v0_9(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 1, 0 is for return point)
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	p = [];
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

return
