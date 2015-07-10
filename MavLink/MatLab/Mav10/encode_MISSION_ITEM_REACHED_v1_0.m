%%  case: 46
%%~ A certain mission item has been reached. The system will either hold this position 
%%~ (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
%%~ to the next MISSION.
function p = encode_MISSION_ITEM_REACHED_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(2);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(46);
	name = [ ...
		{'seq'}	 ... %% Sequence
		];
	byte = [ 2 ];
	type = [ {'uint16'} ];

	p = [head len pnum sysid id messid];
	%% Encode seq data field
	val = typecast(S.seq,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
