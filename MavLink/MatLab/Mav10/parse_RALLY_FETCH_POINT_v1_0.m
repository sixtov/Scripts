%%  case: 176
%%~ Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
%%~ MAV should not respond if the request is invalid.
function S = parse_RALLY_FETCH_POINT_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 0)
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

