%%%%  case: 38
%%~ This message is sent to the MAV to write a partial list. If start index == end index, 
%%~ only one item will be transmitted / updated. If the start index is NOT 0 and 
%%~ above the current list size, this request should be REJECTED!
function p = encodeValues_MISSION_WRITE_PARTIAL_LIST_v1_0(target_system,target_component,start_index,end_index)
	S.target_system = typecast(uint8(target_system),'uint8');		% System ID
	S.target_component = typecast(uint8(target_component),'uint8');		% Component ID
	S.start_index = typecast(int16(start_index),'int16');		% Start index, 0 by default and smaller / equal to the largest index of the current onboard list.
	S.end_index = typecast(int16(end_index),'int16');		% End index, equal or greater than start index.
	p = encode_MISSION_WRITE_PARTIAL_LIST_v1_0(S);
return
