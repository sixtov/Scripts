%%  case: 66
function p = encode_REQUEST_DATA_STREAM(S)
	name = [ ...
		{'target_system'}	 ... %% The target requested to send the message stream.
		{'target_component'} ... %% The target requested to send the message stream.
		{'req_stream_id'}	 ... %% The ID of the requested data stream
		{'req_message_rate'} ... %% The requested interval between two messages of this type
		{'start_stop'}		 ... %% 1 to start sending, 0 to stop sending.
		];
	byte = [ 1 1 1 2 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} ];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode req_stream_id data field
	val = typecast(S.req_stream_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode req_message_rate data field
	val = typecast(S.req_message_rate,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode start_stop data field
	val = typecast(S.start_stop,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
