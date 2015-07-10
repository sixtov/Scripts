%%  case: 176
%%~ Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
%%~ MAV should not respond if the request is invalid.
function p = encode_RALLY_FETCH_POINT(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 0)
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

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
