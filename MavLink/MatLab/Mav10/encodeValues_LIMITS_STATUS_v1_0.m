%%%%  case: 167
%%~ Status of AP_Limits. Sent in extended      status stream when AP_Limits is enabled
function p = encodeValues_LIMITS_STATUS_v1_0(limits_state,last_trigger,last_action,last_recovery,last_clear,breach_count,mods_enabled,mods_required,mods_triggered)
	S.limits_state = typecast(uint8(limits_state),'uint8');		% state of AP_Limits, (see enum LimitState, LIMITS_STATE)
	S.last_trigger = typecast(uint32(last_trigger),'uint32');		% time of last breach in milliseconds since boot
	S.last_action = typecast(uint32(last_action),'uint32');		% time of last recovery action in milliseconds since boot
	S.last_recovery = typecast(uint32(last_recovery),'uint32');		% time of last successful recovery in milliseconds since boot
	S.last_clear = typecast(uint32(last_clear),'uint32');		% time of last all-clear in milliseconds since boot
	S.breach_count = typecast(uint16(breach_count),'uint16');		% number of fence breaches
	S.mods_enabled = typecast(uint8(mods_enabled),'uint8');		% AP_Limit_Module bitfield of enabled modules, (see enum moduleid or LIMIT_MODULE)
	S.mods_required = typecast(uint8(mods_required),'uint8');		% AP_Limit_Module bitfield of required modules, (see enum moduleid or LIMIT_MODULE)
	S.mods_triggered = typecast(uint8(mods_triggered),'uint8');		% AP_Limit_Module bitfield of triggered modules, (see enum moduleid or LIMIT_MODULE)
	p = encode_LIMITS_STATUS_v1_0(S);
return
