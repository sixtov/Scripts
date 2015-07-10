%%  case: 39
%%~ Message encoding a mission item. This message is emitted to announce            
%%~      the presence of a mission item and to set a mission item on the system. The 
%%~ mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
%%~ Local frame is Z-down, right handed (NED), global frame is Z-up, right 
%%~ handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
function S = parse_MISSION_ITEM_v1_0(p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		{'frame'}			 ... %% The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h
		{'command'}			 ... %% The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs
		{'current'}			 ... %% false:0, true:1
		{'autocontinue'}	 ... %% autocontinue to next wp
		{'param1'}			 ... %% PARAM1, see MAV_CMD enum
		{'param2'}			 ... %% PARAM2, see MAV_CMD enum
		{'param3'}			 ... %% PARAM3, see MAV_CMD enum
		{'param4'}			 ... %% PARAM4, see MAV_CMD enum
		{'x'}				 ... %% PARAM5 / local: x position, global: latitude
		{'y'}				 ... %% PARAM6 / y position: global: longitude
		{'z'}				 ... %% PARAM7 / z position: global: altitude (relative or absolute, depending on frame.
		];
	byte = [ 1 1 2 1 2 1 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

