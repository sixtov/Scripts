%%%%  case: 39
%%~ Message encoding a mission item. This message is emitted to announce            
%%~      the presence of a mission item and to set a mission item on the system. The 
%%~ mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
%%~ Local frame is Z-down, right handed (NED), global frame is Z-up, right 
%%~ handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
function p = encodeValues_MISSION_ITEM_v1_0(target_system,target_component,seq,frame,command,current,autocontinue,param1,param2,param3,param4,x,y,z)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.seq = typecast(uint16(seq),'uint16');		% Sequence
	S.frame = typecast(uint8(frame),'uint8');		% The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h
	S.command = typecast(uint16(command),'uint16');		% The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs
	S.current = typecast(uint8(current),'uint8');		% false:0, true:1
	S.autocontinue = typecast(uint8(autocontinue),'uint8');		% autocontinue to next wp
	S.param1 = typecast(single(param1),'single');		% PARAM1, see MAV_CMD enum
	S.param2 = typecast(single(param2),'single');		% PARAM2, see MAV_CMD enum
	S.param3 = typecast(single(param3),'single');		% PARAM3, see MAV_CMD enum
	S.param4 = typecast(single(param4),'single');		% PARAM4, see MAV_CMD enum
	S.x = typecast(single(x),'single');		% PARAM5 / local: x position, global: latitude
	S.y = typecast(single(y),'single');		% PARAM6 / y position: global: longitude
	S.z = typecast(single(z),'single');		% PARAM7 / z position: global: altitude (relative or absolute, depending on frame.
	p = encode_MISSION_ITEM_v1_0(S);
return
