%%  case: 167
%%~ Status of AP_Limits. Sent in extended      status stream when AP_Limits is enabled
function S = parse_LIMITS_STATUS_v1_0(p)
	name = [ ...
		{'limits_state'}	 ... %% state of AP_Limits, (see enum LimitState, LIMITS_STATE)
		{'last_trigger'}	 ... %% time of last breach in milliseconds since boot
		{'last_action'}		 ... %% time of last recovery action in milliseconds since boot
		{'last_recovery'}	 ... %% time of last successful recovery in milliseconds since boot
		{'last_clear'}		 ... %% time of last all-clear in milliseconds since boot
		{'breach_count'}	 ... %% number of fence breaches
		{'mods_enabled'}	 ... %% AP_Limit_Module bitfield of enabled modules, (see enum moduleid or LIMIT_MODULE)
		{'mods_required'}	 ... %% AP_Limit_Module bitfield of required modules, (see enum moduleid or LIMIT_MODULE)
		{'mods_triggered'}	 ... %% AP_Limit_Module bitfield of triggered modules, (see enum moduleid or LIMIT_MODULE)
		];
	byte = [ 1 4 4 4 4 2 1 1 1 ];
	type = [ {'uint8'} {'uint32'} {'uint32'} {'uint32'} {'uint32'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

