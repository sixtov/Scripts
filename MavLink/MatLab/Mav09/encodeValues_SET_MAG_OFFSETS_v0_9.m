%%%%  case: 151
%%~ set the magnetometer offsets
function p = encodeValues_SET_MAG_OFFSETS_v0_9(target_system,target_component,mag_ofs_x,mag_ofs_y,mag_ofs_z)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.mag_ofs_x = typecast(int16(mag_ofs_x),'int16');		% magnetometer X offset
	S.mag_ofs_y = typecast(int16(mag_ofs_y),'int16');		% magnetometer Y offset
	S.mag_ofs_z = typecast(int16(mag_ofs_z),'int16');		% magnetometer Z offset
	p = encode_SET_MAG_OFFSETS_v0_9(S);
return
