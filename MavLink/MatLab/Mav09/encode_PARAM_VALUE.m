%%  case: 22
%%~ Emit the value of a onboard parameter. The inclusion of param_count and param_index 
%%~ in the message allows the recipient to keep track of received parameters and 
%%~ allows him to re-request missing parameters after a loss or timeout.
function p = encode_PARAM_VALUE(S)
	name = [ ...
		{'param_id'}	 ... %% Onboard parameter id
		{'param_value'}	 ... %% Onboard parameter value
		{'param_count'}	 ... %% Total number of onboard parameters
		{'param_index'}	 ... %% Index of this onboard parameter
		];
	byte = [ 15 4 2 2 ];
	type = [ {'uint8'} {'single'} {'uint16'} {'uint16'} ];

	%% Encode param_id data field
	val = typecast(S.param_id,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_value data field
	val = typecast(S.param_value,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_count data field
	val = typecast(S.param_count,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode param_index data field
	val = typecast(S.param_index,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
