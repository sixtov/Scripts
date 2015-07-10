%%  case: 66
function S = parse_REQUEST_DATA_STREAM(S,p)
	name = [ ...
		{'target_system'}	 ... %% The target requested to send the message stream.
		{'target_component'} ... %% The target requested to send the message stream.
		{'req_stream_id'}	 ... %% The ID of the requested data stream
		{'req_message_rate'} ... %% The requested interval between two messages of this type
		{'start_stop'}		 ... %% 1 to start sending, 0 to stop sending.
		];
	byte = [ 1 1 1 2 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

