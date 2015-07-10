%%  case: 74
%%~ Metrics typically displayed on a HUD for fixed wing aircraft
function S = parse_VFR_HUD(S,p)
	name = [ ...
		{'airspeed'}	 ... %% Current airspeed in m/s
		{'groundspeed'}	 ... %% Current ground speed in m/s
		{'heading'}		 ... %% Current heading in degrees, in compass units (0..360, 0=north)
		{'throttle'}	 ... %% Current throttle setting in integer percent, 0 to 100
		{'alt'}			 ... %% Current altitude (MSL), in meters
		{'climb'}		 ... %% Current climb rate in meters/second
		];
	byte = [ 4 4 2 2 4 4 ];
	type = [ {'single'} {'single'} {'int16'} {'uint16'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

