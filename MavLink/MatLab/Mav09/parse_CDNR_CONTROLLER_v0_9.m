%%  case: 113
%%~ Message from Conflict Detection and Resolution monitor to aircraft. This is a command 
%%~ to resolve conflicts and includes flags and values for heading,altitude,and 
%%~ speed changes as well as a max time duration
function S = parse_CDNR_CONTROLLER_v0_9(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

