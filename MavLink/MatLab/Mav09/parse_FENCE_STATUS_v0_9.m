%%  case: 162
%%~ Status of geo-fencing. Sent in extended      status stream when fencing enabled
function S = parse_FENCE_STATUS_v0_9(p)
	name = [ ...
		{'breach_status'}	 ... %% 0 if currently inside fence, 1 if outside
		{'breach_count'}	 ... %% number of fence breaches
		{'breach_type'}		 ... %% last breach type (see FENCE_BREACH_* enum)
		{'breach_time'}		 ... %% time of last breach in milliseconds since boot
		];
	byte = [ 1 2 1 4 ];
	type = [ {'uint8'} {'uint16'} {'uint8'} {'uint32'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

