%%  case: 44
%%~ This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
%%~ a write transaction. The GCS can then request the individual mission item 
%%~ based on the knowledge of the total number of MISSIONs.
function p = encode_MISSION_COUNT(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'count'}			 ... %% Number of mission items in the sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode count data field
	val = typecast(S.count,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
