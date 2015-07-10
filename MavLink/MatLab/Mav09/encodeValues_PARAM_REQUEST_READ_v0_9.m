%%%%  case: 20
%%~ Request to read the onboard parameter with the param_id string id. Onboard parameters 
%%~ are stored as key[const char*] -> value[float]. This allows to send a parameter 
%%~ to any other component (such as the GCS) without the need of previous knowledge 
%%~ of possible parameter names. Thus the same GCS can store different parameters 
%%~ for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
%%~ for a full documentation of QGroundControl and IMU code.
function p = encodeValues_PARAM_REQUEST_READ_v0_9(target_system,target_component,param_id,param_index)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.param_id = typecast(uint8(param_id),'uint8');		% Onboard parameter id
	S.param_index = typecast(int16(param_index),'int16');		% Parameter index. Send -1 to use the param ID field as identifier
	p = encode_PARAM_REQUEST_READ_v0_9(S);
return
