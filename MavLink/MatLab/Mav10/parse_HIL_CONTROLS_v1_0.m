%%  case: 91
%%~ Sent from autopilot to simulation. Hardware in the loop control outputs
function S = parse_HIL_CONTROLS_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

