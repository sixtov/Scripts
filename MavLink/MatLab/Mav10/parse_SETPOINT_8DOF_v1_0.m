%%  case: 148
%%~ Set the 8 DOF setpoint for a controller.
function S = parse_SETPOINT_8DOF_v1_0(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'val1'}			 ... %% Value 1
		{'val2'}			 ... %% Value 2
		{'val3'}			 ... %% Value 3
		{'val4'}			 ... %% Value 4
		{'val5'}			 ... %% Value 5
		{'val6'}			 ... %% Value 6
		{'val7'}			 ... %% Value 7
		{'val8'}			 ... %% Value 8
		];
	byte = [ 1 4 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

