%%  case: 20
%%~ Request to read the onboard parameter with the param_id string id. Onboard parameters 
%%~ are stored as key[const char*] -> value[float]. This allows to send a parameter 
%%~ to any other component (such as the GCS) without the need of previous knowledge 
%%~ of possible parameter names. Thus the same GCS can store different parameters 
%%~ for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
%%~ for a full documentation of QGroundControl and IMU code.
function S = parse_PARAM_REQUEST_READ(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'param_id'}		 ... %% Onboard parameter id
		{'param_index'}		 ... %% Parameter index. Send -1 to use the param ID field as identifier
		];
	byte = [ 1 1 15 2 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

