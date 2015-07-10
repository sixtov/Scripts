%%  case: 113
%%~ Message from Conflict Detection and Resolution monitor to aircraft. This is a command 
%%~ to resolve conflicts and includes flags and values for heading,altitude,and 
%%~ speed changes as well as a max time duration
function p = encode_CDNR_CONTROLLER_v0_9(S)
	name = [ ...
		{'h_flag'}		 ... %% enables/disables new heading command
		{'s_flag'}		 ... %% enables/disables new airspeed command
		{'a_flag'}		 ... %% enables/disables new altitude command
		{'t_flag'}		 ... %% enables/disables max time command
		{'new_heading'}	 ... %% value for new heading
		{'new_airspeed'} ... %% value for new airspeed
		{'new_altitude'} ... %% value for new altitude
		{'max_time'}	 ... %% maximum time to hold this command
		];
	byte = [ 1 1 1 1 2 2 2 2 ];
	type = [ {'int8'} {'int8'} {'int8'} {'int8'} {'int16'} {'int16'} {'int16'} {'int16'} ];

	p = [];
	%% Encode h_flag data field
	val = typecast(S.h_flag,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode s_flag data field
	val = typecast(S.s_flag,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode a_flag data field
	val = typecast(S.a_flag,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode t_flag data field
	val = typecast(S.t_flag,'int8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode new_heading data field
	val = typecast(S.new_heading,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode new_airspeed data field
	val = typecast(S.new_airspeed,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode new_altitude data field
	val = typecast(S.new_altitude,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode max_time data field
	val = typecast(S.max_time,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
