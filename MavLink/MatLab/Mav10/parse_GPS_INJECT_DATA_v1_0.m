%%  case: 123
%%~ data for injecting into the onboard GPS (used for DGPS)
function S = parse_GPS_INJECT_DATA_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'len'}				 ... %% data length
		{'data'}			 ... %% raw data (110 is enough for 12 satellites of RTCMv2)
		];
	byte = [ 1 1 1 110 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

