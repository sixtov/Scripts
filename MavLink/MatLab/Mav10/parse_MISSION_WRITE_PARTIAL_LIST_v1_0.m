%%  case: 38
%%~ This message is sent to the MAV to write a partial list. If start index == end index, 
%%~ only one item will be transmitted / updated. If the start index is NOT 0 and 
%%~ above the current list size, this request should be REJECTED!
function S = parse_MISSION_WRITE_PARTIAL_LIST_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start_index'}		 ... %% Start index, 0 by default and smaller / equal to the largest index of the current onboard list.
		{'end_index'}		 ... %% End index, equal or greater than start index.
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

