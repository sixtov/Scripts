%%  case: 69
function S = parse_MANUAL_CONTROL_v0_9(S,p)
	name = [ ...
		{'target'}			 ... %% The system to be controlled
		{'roll'}			 ... %% roll
		{'pitch'}			 ... %% pitch
		{'yaw'}				 ... %% yaw
		{'thrust'}			 ... %% thrust
		{'roll_manual'}		 ... %% roll control enabled auto:0, manual:1
		{'pitch_manual'}	 ... %% pitch auto:0, manual:1
		{'yaw_manual'}		 ... %% yaw auto:0, manual:1
		{'thrust_manual'}	 ... %% thrust auto:0, manual:1
		];
	byte = [ 1 4 4 4 4 1 1 1 1 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

