%%  case: 22
%%~ Emit the value of a onboard parameter. The inclusion of param_count and param_index 
%%~ in the message allows the recipient to keep track of received parameters and 
%%~ allows him to re-request missing parameters after a loss or timeout.
function S = parse_PARAM_VALUE_v0_9(p)
	name = [ ...
		{'param_id'}	 ... %% Onboard parameter id
		{'param_value'}	 ... %% Onboard parameter value
		{'param_count'}	 ... %% Total number of onboard parameters
		{'param_index'}	 ... %% Index of this onboard parameter
		];
	byte = [ 15 4 2 2 ];
	type = [ {'uint8'} {'single'} {'uint16'} {'uint16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

