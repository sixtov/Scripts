%%  case: 42
%%~ Message that announces the sequence number of the current active waypoint. The MAV 
%%~ will fly towards this waypoint.
function p = encode_WAYPOINT_CURRENT(S)
	name = [ ...
		{'seq'}	 ... %% Sequence
		];
	byte = [ 2 ];
	type = [ {'uint16'} ];

	%% Encode seq data field
	val = typecast(S.seq,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
