%%  case: 148
%%~ Set the 8 DOF setpoint for a controller.
function S = parse_SETPOINT_8DOF_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

