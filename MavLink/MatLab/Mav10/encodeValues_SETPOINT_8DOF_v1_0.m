%%%%  case: 148
%%~ Set the 8 DOF setpoint for a controller.
function p = encodeValues_SETPOINT_8DOF_v1_0(target_system,val1,val2,val3,val4,val5,val6,val7,val8)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.val1 = typecast(single(val1),'single');		% Value 1
	S.val2 = typecast(single(val2),'single');		% Value 2
	S.val3 = typecast(single(val3),'single');		% Value 3
	S.val4 = typecast(single(val4),'single');		% Value 4
	S.val5 = typecast(single(val5),'single');		% Value 5
	S.val6 = typecast(single(val6),'single');		% Value 6
	S.val7 = typecast(single(val7),'single');		% Value 7
	S.val8 = typecast(single(val8),'single');		% Value 8
	p = encode_SETPOINT_8DOF_v1_0(S);
return
