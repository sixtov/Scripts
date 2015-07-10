%%%%  case: 155
%%~ Control on-board Camera Control System to take shots.
function p = encodeValues_DIGICAM_CONTROL_v0_9(target_system,target_component,session,zoom_pos,zoom_step,focus_lock,shot,command_id,extra_param,extra_value)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.session = typecast(uint8(session),'uint8');		% 0: stop, 1: start or keep it up //Session control e.g. show/hide lens
	S.zoom_pos = typecast(uint8(zoom_pos),'uint8');		% 1 to N //Zoom's absolute position (0 means ignore)
	S.zoom_step = typecast(int8(zoom_step),'int8');		% -100 to 100 //Zooming step value to offset zoom from the current position
	S.focus_lock = typecast(uint8(focus_lock),'uint8');		% 0: unlock focus or keep unlocked, 1: lock focus or keep locked, 3: re-lock focus
	S.shot = typecast(uint8(shot),'uint8');		% 0: ignore, 1: shot or start filming
	S.command_id = typecast(uint8(command_id),'uint8');		% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
	S.extra_param = typecast(uint8(extra_param),'uint8');		% Extra parameters enumeration (0 means ignore)
	S.extra_value = typecast(single(extra_value),'single');		% Correspondent value to given extra_param
	p = encode_DIGICAM_CONTROL_v0_9(S);
return
