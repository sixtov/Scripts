%%  case: 68
%%~ Hardware in the loop control outputs
function S = parse_HIL_CONTROLS(S,p)
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
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

