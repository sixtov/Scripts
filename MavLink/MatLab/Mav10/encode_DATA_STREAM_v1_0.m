%%  case: 67
function p = encode_DATA_STREAM_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(4);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(67);
	name = [ ...
		{'stream_id'}	 ... %% The ID of the requested data stream
		{'message_rate'} ... %% The requested interval between two messages of this type
		{'on_off'}		 ... %% 1 stream is enabled, 0 stream is stopped.
		];
	byte = [ 1 2 1 ];
	type = [ {'uint8'} {'uint16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
