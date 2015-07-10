%%%%  case: 149
%%~ Set the 6 DOF setpoint for a attitude and position controller.
function p = encodeValues_SETPOINT_6DOF_v1_0(target_system,trans_x,trans_y,trans_z,rot_x,rot_y,rot_z)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.trans_x = typecast(single(trans_x),'single');		% Translational Component in x
	S.trans_y = typecast(single(trans_y),'single');		% Translational Component in y
	S.trans_z = typecast(single(trans_z),'single');		% Translational Component in z
	S.rot_x = typecast(single(rot_x),'single');		% Rotational Component in x
	S.rot_y = typecast(single(rot_y),'single');		% Rotational Component in y
	S.rot_z = typecast(single(rot_z),'single');		% Rotational Component in z
	p = encode_SETPOINT_6DOF_v1_0(S);
return
