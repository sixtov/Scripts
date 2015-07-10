%%%%  case: 113
%%~ Message from Conflict Detection and Resolution monitor to aircraft. This is a command 
%%~ to resolve conflicts and includes flags and values for heading,altitude,and 
%%~ speed changes as well as a max time duration
function p = encodeValues_CDNR_CONTROLLER_v0_9(h_flag,s_flag,a_flag,t_flag,new_heading,new_airspeed,new_altitude,max_time)
	S.h_flag = typecast(int8(h_flag),'int8');		% enables/disables new heading command
	S.s_flag = typecast(int8(s_flag),'int8');		% enables/disables new airspeed command
	S.a_flag = typecast(int8(a_flag),'int8');		% enables/disables new altitude command
	S.t_flag = typecast(int8(t_flag),'int8');		% enables/disables max time command
	S.new_heading = typecast(int16(new_heading),'int16');		% value for new heading
	S.new_airspeed = typecast(int16(new_airspeed),'int16');		% value for new airspeed
	S.new_altitude = typecast(int16(new_altitude),'int16');		% value for new altitude
	S.max_time = typecast(int16(max_time),'int16');		% maximum time to hold this command
	p = encode_CDNR_CONTROLLER_v0_9(S);
return
