%%  case: 107
%%~ The IMU readings in SI units in NED body frame
function S = parse_HIL_SENSOR(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'xacc'}			 ... %% X acceleration (m/s^2)
		{'yacc'}			 ... %% Y acceleration (m/s^2)
		{'zacc'}			 ... %% Z acceleration (m/s^2)
		{'xgyro'}			 ... %% Angular speed around X axis in body frame (rad / sec)
		{'ygyro'}			 ... %% Angular speed around Y axis in body frame (rad / sec)
		{'zgyro'}			 ... %% Angular speed around Z axis in body frame (rad / sec)
		{'xmag'}			 ... %% X Magnetic field (Gauss)
		{'ymag'}			 ... %% Y Magnetic field (Gauss)
		{'zmag'}			 ... %% Z Magnetic field (Gauss)
		{'abs_pressure'}	 ... %% Absolute pressure in millibar
		{'diff_pressure'}	 ... %% Differential pressure (airspeed) in millibar
		{'pressure_alt'}	 ... %% Altitude calculated from pressure
		{'temperature'}		 ... %% Temperature in degrees celsius
		{'fields_updated'}	 ... %% Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
		];
	byte = [ 8 4 4 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

