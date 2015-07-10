%%  case: 155
%%~ Control on-board Camera Control System to take shots.
function S = parse_DIGICAM_CONTROL_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'session'}			 ... %% 0: stop, 1: start or keep it up //Session control e.g. show/hide lens
		{'zoom_pos'}		 ... %% 1 to N //Zoom's absolute position (0 means ignore)
		{'zoom_step'}		 ... %% -100 to 100 //Zooming step value to offset zoom from the current position
		{'focus_lock'}		 ... %% 0: unlock focus or keep unlocked, 1: lock focus or keep locked, 3: re-lock focus
		{'shot'}			 ... %% 0: ignore, 1: shot or start filming
		{'command_id'}		 ... %% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		{'extra_param'}		 ... %% Extra parameters enumeration (0 means ignore)
		{'extra_value'}		 ... %% Correspondent value to given extra_param
		];
	byte = [ 1 1 1 1 1 1 1 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

