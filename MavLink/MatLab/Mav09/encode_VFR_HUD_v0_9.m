%%  case: 74
%%~ Metrics typically displayed on a HUD for fixed wing aircraft
function p = encode_VFR_HUD_v0_9(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(85);
	len = uint8(20);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(74);
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

	p = [head len pnum sysid id messid];
	%% Encode airspeed data field
	val = typecast(S.airspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode groundspeed data field
	val = typecast(S.groundspeed,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode heading data field
	val = typecast(S.heading,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode throttle data field
	val = typecast(S.throttle,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode climb data field
	val = typecast(S.climb,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v0_9(p(2:end)'),'uint8')];
return
