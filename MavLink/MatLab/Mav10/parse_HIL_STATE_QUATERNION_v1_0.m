%%  case: 115
%%~ Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. 
%%~ This packet is useful for high throughput applications such as hardware in the 
%%~ loop simulations.
function S = parse_HIL_STATE_QUATERNION_v1_0(p)
	name = [ ...
		{'time_usec'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'attitude_quaternion'}	 ... %% Vehicle attitude expressed as normalized quaternion in w, x, y, z order (with 1 0 0 0 being the null-rotation)
		{'rollspeed'}			 ... %% Body frame roll / phi angular speed (rad/s)
		{'pitchspeed'}			 ... %% Body frame pitch / theta angular speed (rad/s)
		{'yawspeed'}			 ... %% Body frame yaw / psi angular speed (rad/s)
		{'lat'}					 ... %% Latitude, expressed as * 1E7
		{'lon'}					 ... %% Longitude, expressed as * 1E7
		{'alt'}					 ... %% Altitude in meters, expressed as * 1000 (millimeters)
		{'vx'}					 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}					 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}					 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		{'ind_airspeed'}		 ... %% Indicated airspeed, expressed as m/s * 100
		{'true_airspeed'}		 ... %% True airspeed, expressed as m/s * 100
		{'xacc'}				 ... %% X acceleration (mg)
		{'yacc'}				 ... %% Y acceleration (mg)
		{'zacc'}				 ... %% Z acceleration (mg)
		];
	byte = [ 8 16 4 4 4 4 4 4 2 2 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} {'uint16'} {'uint16'} {'int16'} {'int16'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

