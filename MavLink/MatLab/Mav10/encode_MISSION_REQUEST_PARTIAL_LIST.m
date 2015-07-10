%%  case: 37
%%~ Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
%%~ If start and end index are the same, just 
%%~ send one waypoint.
function p = encode_MISSION_REQUEST_PARTIAL_LIST(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start_index'}		 ... %% Start index, 0 by default
		{'end_index'}		 ... %% End index, -1 by default (-1: send list to end). Else a valid index of the list
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode start_index data field
	val = typecast(S.start_index,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode end_index data field
	val = typecast(S.end_index,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
