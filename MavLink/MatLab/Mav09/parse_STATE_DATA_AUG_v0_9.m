%%  case: 117
%%~ Message that provides information about the state of the aircraft
function S = parse_STATE_DATA_AUG_v0_9(S,p)
	name = [ ...
		{'num'}		 ... %% Vehicle number, e.g. 1 for R1, 2 for R2, 3 for R3
		{'atloiter'} ... %% if 0, vehicle is not currently loitering, if 1, vehicle is loitering
		{'mode'}	 ... %% mode: MANUAL=0, CIRCLE=1, STABILIZE=2, FLY_BY_WIRE_A=5, FLY_BY_WIRE_B=6, FLY_BY_WIRE_C=7, AUTO=10, RTL=11, LOITER=12, GUIDED=15, INITIALISING=16
		{'RC_state'} ... %% state: OFF=0, ON=1, FAILSAFE=255
		{'usec'}	 ... %% time
		];
	byte = [ 1 1 1 1 8 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

