%%  case: 167
%%~ Status of AP_Limits. Sent in extended      status stream when AP_Limits is enabled
function p = encode_LIMITS_STATUS_v1_0(S)
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

	p = [];
	%% Encode limits_state data field
	val = typecast(S.limits_state,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode last_trigger data field
	val = typecast(S.last_trigger,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode last_action data field
	val = typecast(S.last_action,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode last_recovery data field
	val = typecast(S.last_recovery,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode last_clear data field
	val = typecast(S.last_clear,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode breach_count data field
	val = typecast(S.breach_count,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mods_enabled data field
	val = typecast(S.mods_enabled,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mods_required data field
	val = typecast(S.mods_required,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mods_triggered data field
	val = typecast(S.mods_triggered,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
