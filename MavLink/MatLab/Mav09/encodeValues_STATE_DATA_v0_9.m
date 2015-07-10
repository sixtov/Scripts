%%%%  case: 115
%%~ Message that provides information about the state of the aircraft
function p = encodeValues_STATE_DATA_v0_9(num,atloiter,mode,usec)
	S.num = typecast(uint8(num),'uint8');		% Vehicle number, e.g. 1 for R1, 2 for R2, 3 for R3
	S.atloiter = typecast(uint8(atloiter),'uint8');		% if 0, vehicle is not currently loitering, if 1, vehicle is loitering
	S.mode = typecast(uint8(mode),'uint8');		% mode: MANUAL=0, CIRCLE=1, STABILIZE=2, FLY_BY_WIRE_A=5, FLY_BY_WIRE_B=6, FLY_BY_WIRE_C=7, AUTO=10, RTL=11, LOITER=12, GUIDED=15, INITIALISING=16
	S.usec = typecast(uint64(usec),'uint64');		% time
	p = encode_STATE_DATA_v0_9(S);
return
