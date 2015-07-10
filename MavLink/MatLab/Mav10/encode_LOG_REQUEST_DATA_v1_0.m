%%  case: 119
%%~ Request a chunk of a log
function p = encode_LOG_REQUEST_DATA_v1_0(S)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'id'}				 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}				 ... %% Offset into the log
		{'count'}			 ... %% Number of bytes
		];
	byte = [ 1 1 2 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint32'} {'uint32'} ];

	p = [];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode id data field
	val = typecast(S.id,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode ofs data field
	val = typecast(S.ofs,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode count data field
	val = typecast(S.count,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
