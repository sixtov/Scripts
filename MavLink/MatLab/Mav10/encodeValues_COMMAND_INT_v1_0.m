%%%%  case: 75
%%~ Message encoding a command with parameters as scaled integers. Scaling depends on 
%%~ the actual command value.
function p = encodeValues_COMMAND_INT_v1_0(target_system,target_component,frame,command,current,autocontinue,param1,param2,param3,param4,x,y,z)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.frame = typecast(uint8(frame),'uint8');		% The coordinate system of the COMMAND. see MAV_FRAME in mavlink_types.h
	S.command = typecast(uint16(command),'uint16');		% The scheduled action for the mission item. see MAV_CMD in common.xml MAVLink specs
	S.current = typecast(uint8(current),'uint8');		% false:0, true:1
	S.autocontinue = typecast(uint8(autocontinue),'uint8');		% autocontinue to next wp
	S.param1 = typecast(single(param1),'single');		% PARAM1, see MAV_CMD enum
	S.param2 = typecast(single(param2),'single');		% PARAM2, see MAV_CMD enum
	S.param3 = typecast(single(param3),'single');		% PARAM3, see MAV_CMD enum
	S.param4 = typecast(single(param4),'single');		% PARAM4, see MAV_CMD enum
	S.x = typecast(int32(x),'int32');		% PARAM5 / local: x position in meters * 1e4, global: latitude in degrees * 10^7
	S.y = typecast(int32(y),'int32');		% PARAM6 / local: y position in meters * 1e4, global: longitude in degrees * 10^7
	S.z = typecast(single(z),'single');		% PARAM7 / z position: global: altitude in meters (relative or absolute, depending on frame.
	p = encode_COMMAND_INT_v1_0(S);
return
