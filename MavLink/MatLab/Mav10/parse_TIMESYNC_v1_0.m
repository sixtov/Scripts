%%  case: 111
%%~ Time synchronization message.
function S = parse_TIMESYNC_v1_0(p)
	name = [ ...
		{'tc1'}	 ... %% Time sync timestamp 1
		{'ts1'}	 ... %% Time sync timestamp 2
		];
	byte = [ 8 8 ];
	type = [ {'int64'} {'int64'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

