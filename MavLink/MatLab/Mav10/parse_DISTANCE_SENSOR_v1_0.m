%%  case: 132
function S = parse_DISTANCE_SENSOR_v1_0(p)
	name = [ ...
		{'time_boot_ms'}	 ... %% Time since system boot
		{'min_distance'}	 ... %% Minimum distance the sensor can measure in centimeters
		{'max_distance'}	 ... %% Maximum distance the sensor can measure in centimeters
		{'current_distance'} ... %% Current distance reading
		{'type'}			 ... %% Type from MAV_DISTANCE_SENSOR enum.
		{'id'}				 ... %% Onboard ID of the sensor
		{'orientation'}		 ... %% Direction the sensor faces from FIXME enum.
		{'covariance'}		 ... %% Measurement covariance in centimeters, 0 for unknown / invalid readings
		];
	byte = [ 4 2 2 2 1 1 1 1 ];
	type = [ {'uint32'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

