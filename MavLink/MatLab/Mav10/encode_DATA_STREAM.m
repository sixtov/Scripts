%%  case: 67
function p = encode_DATA_STREAM(S)
	name = [ ...
		{'stream_id'}	 ... %% The ID of the requested data stream
		{'message_rate'} ... %% The requested interval between two messages of this type
		{'on_off'}		 ... %% 1 stream is enabled, 0 stream is stopped.
		];
	byte = [ 1 2 1 ];
	type = [ {'uint8'} {'uint16'} {'uint8'} ];

	%% Encode stream_id data field
	val = typecast(S.stream_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode message_rate data field
	val = typecast(S.message_rate,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode on_off data field
	val = typecast(S.on_off,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
