%%  case: 57
%%~ Setpoint in roll, pitch, yaw currently active on the system.
function p = encode_ROLL_PITCH_YAW_THRUST_SETPOINT(S)
	name = [ ...
		{'time_us'}	 ... %% Timestamp in micro seconds since unix epoch
		{'roll'}	 ... %% Desired roll angle in radians
		{'pitch'}	 ... %% Desired pitch angle in radians
		{'yaw'}		 ... %% Desired yaw angle in radians
		{'thrust'}	 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 8 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} ];

	%% Encode time_us data field
	val = typecast(S.time_us,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll data field
	val = typecast(S.roll,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch data field
	val = typecast(S.pitch,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw data field
	val = typecast(S.yaw,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode thrust data field
	val = typecast(S.thrust,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
