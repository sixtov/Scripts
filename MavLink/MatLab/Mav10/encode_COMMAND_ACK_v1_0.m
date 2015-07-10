%%  case: 77
%%~ Report status of a command. Includes feedback wether the command was executed.
function p = encode_COMMAND_ACK_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(3);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(77);
	name = [ ...
		{'command'}	 ... %% Command ID, as defined by MAV_CMD enum.
		{'result'}	 ... %% See MAV_RESULT enum
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode command data field
	val = typecast(S.command,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode result data field
	val = typecast(S.result,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
