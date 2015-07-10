%%  case: 37
%%~ Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
%%~ If start and end index are the same, just 
%%~ send one waypoint.
function S = parse_MISSION_REQUEST_PARTIAL_LIST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start_index'}		 ... %% Start index, 0 by default
		{'end_index'}		 ... %% End index, -1 by default (-1: send list to end). Else a valid index of the list
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

