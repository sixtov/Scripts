%%  case: 68
%%~ Hardware in the loop control outputs
function p = encode_HIL_CONTROLS_v0_9(S)
	name = [ ...
		{'time_us'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll_ailerons'}	 ... %% Control output -3 .. 1
		{'pitch_elevator'}	 ... %% Control output -1 .. 1
		{'yaw_rudder'}		 ... %% Control output -1 .. 1
		{'throttle'}		 ... %% Throttle 0 .. 1
		{'mode'}			 ... %% System mode (MAV_MODE)
		{'nav_mode'}		 ... %% Navigation mode (MAV_NAV_MODE)
		];
	byte = [ 8 4 4 4 4 1 1 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} ];

	p = [];
	%% Encode time_us data field
	val = typecast(S.time_us,'uint64');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode roll_ailerons data field
	val = typecast(S.roll_ailerons,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode pitch_elevator data field
	val = typecast(S.pitch_elevator,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode yaw_rudder data field
	val = typecast(S.yaw_rudder,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode throttle data field
	val = typecast(S.throttle,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mode data field
	val = typecast(S.mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode nav_mode data field
	val = typecast(S.nav_mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
