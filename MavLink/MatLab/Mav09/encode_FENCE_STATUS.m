%%  case: 162
%%~ Status of geo-fencing. Sent in extended      status stream when fencing enabled
function p = encode_FENCE_STATUS(S)
	name = [ ...
		{'breach_status'}	 ... %% 0 if currently inside fence, 1 if outside
		{'breach_count'}	 ... %% number of fence breaches
		{'breach_type'}		 ... %% last breach type (see FENCE_BREACH_* enum)
		{'breach_time'}		 ... %% time of last breach in milliseconds since boot
		];
	byte = [ 1 2 1 4 ];
	type = [ {'uint8'} {'uint16'} {'uint8'} {'uint32'} ];

	%% Encode breach_status data field
	val = typecast(S.breach_status,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode breach_count data field
	val = typecast(S.breach_count,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode breach_type data field
	val = typecast(S.breach_type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode breach_time data field
	val = typecast(S.breach_time,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
