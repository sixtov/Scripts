%%%%  case: 20
%%~ Request to read the onboard parameter with the param_id string id. Onboard parameters 
%%~ are stored as key[const char*] -> value[float]. This allows to send a parameter 
%%~ to any other component (such as the GCS) without the need of previous knowledge 
%%~ of possible parameter names. Thus the same GCS can store different parameters 
%%~ for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
%%~ for a full documentation of QGroundControl and IMU code.
function p = encodeValues_PARAM_REQUEST_READ_v1_0(target_system,target_component,param_id,param_index)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.param_id = typecast(uint8(param_id),'uint8');		% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
	S.param_index = typecast(int16(param_index),'int16');		% Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored)
	p = encode_PARAM_REQUEST_READ_v1_0(S);
return
