%%  case: 138
%%~ Motion capture attitude and position
function S = parse_ATT_POS_MOCAP_v1_0(p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (micros since boot or Unix epoch)
		{'q'}			 ... %% Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
		{'x'}			 ... %% X position in meters (NED)
		{'y'}			 ... %% Y position in meters (NED)
		{'z'}			 ... %% Z position in meters (NED)
		];
	byte = [ 8 16 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

