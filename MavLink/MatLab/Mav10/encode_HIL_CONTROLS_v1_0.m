%%  case: 91
%%~ Sent from autopilot to simulation. Hardware in the loop control outputs
function p = encode_HIL_CONTROLS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(42);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(91);
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll_ailerons'}	 ... %% Control output -1 .. 1
		{'pitch_elevator'}	 ... %% Control output -1 .. 1
		{'yaw_rudder'}		 ... %% Control output -1 .. 1
		{'throttle'}		 ... %% Throttle 0 .. 1
		{'aux1'}			 ... %% Aux 1, -1 .. 1
		{'aux2'}			 ... %% Aux 2, -1 .. 1
		{'aux3'}			 ... %% Aux 3, -1 .. 1
		{'aux4'}			 ... %% Aux 4, -1 .. 1
		{'mode'}			 ... %% System mode (MAV_MODE)
		{'nav_mode'}		 ... %% Navigation mode (MAV_NAV_MODE)
		];
	byte = [ 8 4 4 4 4 4 4 4 4 1 1 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode time_usec data field
	val = typecast(S.time_usec,'uint64');
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

	%% Encode aux1 data field
	val = typecast(S.aux1,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode aux2 data field
	val = typecast(S.aux2,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode aux3 data field
	val = typecast(S.aux3,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode aux4 data field
	val = typecast(S.aux4,'single');
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

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
