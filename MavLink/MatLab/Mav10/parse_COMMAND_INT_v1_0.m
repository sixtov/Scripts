%%  case: 75
%%~ Message encoding a command with parameters as scaled integers. Scaling depends on 
%%~ the actual command value.
function S = parse_COMMAND_INT_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'frame'}			 ... %% The coordinate system of the COMMAND. see MAV_FRAME in mavlink_types.h
		{'command'}			 ... %% The scheduled action for the mission item. see MAV_CMD in common.xml MAVLink specs
		{'current'}			 ... %% false:0, true:1
		{'autocontinue'}	 ... %% autocontinue to next wp
		{'param1'}			 ... %% PARAM1, see MAV_CMD enum
		{'param2'}			 ... %% PARAM2, see MAV_CMD enum
		{'param3'}			 ... %% PARAM3, see MAV_CMD enum
		{'param4'}			 ... %% PARAM4, see MAV_CMD enum
		{'x'}				 ... %% PARAM5 / local: x position in meters * 1e4, global: latitude in degrees * 10^7
		{'y'}				 ... %% PARAM6 / local: y position in meters * 1e4, global: longitude in degrees * 10^7
		{'z'}				 ... %% PARAM7 / z position: global: altitude in meters (relative or absolute, depending on frame.
		];
	byte = [ 1 1 1 2 1 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

