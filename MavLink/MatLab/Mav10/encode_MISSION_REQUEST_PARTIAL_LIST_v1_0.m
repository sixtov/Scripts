%%  case: 37
%%~ Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
%%~ If start and end index are the same, just 
%%~ send one waypoint.
function p = encode_MISSION_REQUEST_PARTIAL_LIST_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(6);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(37);
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start_index'}		 ... %% Start index, 0 by default
		{'end_index'}		 ... %% End index, -1 by default (-1: send list to end). Else a valid index of the list
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode start_index data field
	val = typecast(S.start_index,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode end_index data field
	val = typecast(S.end_index,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
