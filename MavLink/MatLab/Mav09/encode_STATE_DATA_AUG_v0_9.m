%%  case: 117
%%~ Message that provides information about the state of the aircraft
function p = encode_STATE_DATA_AUG_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(12);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(117);
	name = [ ...
		{'num'}		 ... %% Vehicle number, e.g. 1 for R1, 2 for R2, 3 for R3
		{'atloiter'} ... %% if 0, vehicle is not currently loitering, if 1, vehicle is loitering
		{'mode'}	 ... %% mode: MANUAL=0, CIRCLE=1, STABILIZE=2, FLY_BY_WIRE_A=5, FLY_BY_WIRE_B=6, FLY_BY_WIRE_C=7, AUTO=10, RTL=11, LOITER=12, GUIDED=15, INITIALISING=16
		{'RC_state'} ... %% state: OFF=0, ON=1, FAILSAFE=255
		{'usec'}	 ... %% time
		];
	byte = [ 1 1 1 1 8 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint64'} ];

	p = [head len pnum sysid id messid];
	%% Encode num data field
	val = typecast(S.num,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode atloiter data field
	val = typecast(S.atloiter,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode RC_state data field
	val = typecast(S.RC_state,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode usec data field
	val = typecast(S.usec,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
