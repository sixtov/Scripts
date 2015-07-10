%%  case: 20
%%~ Request to read the onboard parameter with the param_id string id. Onboard parameters 
%%~ are stored as key[const char*] -> value[float]. This allows to send a parameter 
%%~ to any other component (such as the GCS) without the need of previous knowledge 
%%~ of possible parameter names. Thus the same GCS can store different parameters 
%%~ for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
%%~ for a full documentation of QGroundControl and IMU code.
function S = parse_PARAM_REQUEST_READ_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'param_id'}		 ... %% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		{'param_index'}		 ... %% Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored)
		];
	byte = [ 1 1 16 2 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'int16'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

