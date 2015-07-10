%%  case: 149
%%~ Set the 6 DOF setpoint for a attitude and position controller.
function S = parse_SETPOINT_6DOF(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'trans_x'}			 ... %% Translational Component in x
		{'trans_y'}			 ... %% Translational Component in y
		{'trans_z'}			 ... %% Translational Component in z
		{'rot_x'}			 ... %% Rotational Component in x
		{'rot_y'}			 ... %% Rotational Component in y
		{'rot_z'}			 ... %% Rotational Component in z
		];
	byte = [ 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

