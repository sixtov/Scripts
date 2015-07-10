%%%%  case: 154
%%~ Configure on-board Camera Control System.
function p = encodeValues_DIGICAM_CONFIGURE_v1_0(target_system,target_component,mode,shutter_speed,aperture,iso,exposure_type,command_id,engine_cut_off,extra_param,extra_value)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.mode = typecast(uint8(mode),'uint8');		% Mode enumeration from 1 to N //P, TV, AV, M, Etc (0 means ignore)
	S.shutter_speed = typecast(uint16(shutter_speed),'uint16');		% Divisor number //e.g. 1000 means 1/1000 (0 means ignore)
	S.aperture = typecast(uint8(aperture),'uint8');		% F stop number x 10 //e.g. 28 means 2.8 (0 means ignore)
	S.iso = typecast(uint8(iso),'uint8');		% ISO enumeration from 1 to N //e.g. 80, 100, 200, Etc (0 means ignore)
	S.exposure_type = typecast(uint8(exposure_type),'uint8');		% Exposure type enumeration from 1 to N (0 means ignore)
	S.command_id = typecast(uint8(command_id),'uint8');		% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
	S.engine_cut_off = typecast(uint8(engine_cut_off),'uint8');		% Main engine cut-off time before camera trigger in seconds/10 (0 means no cut-off)
	S.extra_param = typecast(uint8(extra_param),'uint8');		% Extra parameters enumeration (0 means ignore)
	S.extra_value = typecast(single(extra_value),'single');		% Correspondent value to given extra_param
	p = encode_DIGICAM_CONFIGURE_v1_0(S);
return
