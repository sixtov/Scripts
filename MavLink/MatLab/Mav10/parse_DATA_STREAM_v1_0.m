%%  case: 67
function S = parse_DATA_STREAM_v1_0(S,p)
	name = [ ...
		{'stream_id'}	 ... %% The ID of the requested data stream
		{'message_rate'} ... %% The requested interval between two messages of this type
		{'on_off'}		 ... %% 1 stream is enabled, 0 stream is stopped.
		];
	byte = [ 1 2 1 ];
	type = [ {'uint8'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

