%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
%%~ There is no target component id as the mode is by definition for the overall 
%%~ aircraft, not only for one component.
function p = encode_SET_MODE(S)
	name = [ ...
		{'target'}	 ... %% The system setting the mode
		{'mode'}	 ... %% The new mode
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];

	%% Encode target data field
	val = typecast(S.target,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
