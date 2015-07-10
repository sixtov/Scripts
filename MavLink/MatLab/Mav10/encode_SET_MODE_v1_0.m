%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE. There is no target component id 
%%~ as the mode is by definition for the overall aircraft, not only for one component.
function p = encode_SET_MODE_v1_0(S)
	name = [ ...
		{'target_system'}	 ... %% The system setting the mode
		{'base_mode'}		 ... %% The new base mode
		{'custom_mode'}		 ... %% The new autopilot-specific mode. This field can be ignored by an autopilot.
		];
	byte = [ 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint32'} ];

	p = [];
	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode base_mode data field
	val = typecast(S.base_mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode custom_mode data field
	val = typecast(S.custom_mode,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
