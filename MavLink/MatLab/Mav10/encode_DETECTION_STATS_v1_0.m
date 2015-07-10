%%  case: 205
function p = encode_DETECTION_STATS_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(48);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(205);
	name = [ ...
		{'detections'}			 ... %% Number of detections
		{'cluster_iters'}		 ... %% Number of cluster iterations
		{'best_score'}			 ... %% Best score
		{'best_lat'}			 ... %% Latitude of the best detection * 1E7
		{'best_lon'}			 ... %% Longitude of the best detection * 1E7
		{'best_alt'}			 ... %% Altitude of the best detection * 1E3
		{'best_detection_id'}	 ... %% Best detection ID
		{'best_cluster_id'}		 ... %% Best cluster ID
		{'best_cluster_iter_id'} ... %% Best cluster ID
		{'images_done'}			 ... %% Number of images already processed
		{'images_todo'}			 ... %% Number of images still to process
		{'fps'}					 ... %% Average images per seconds processed
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'uint32'} {'single'} {'int32'} {'int32'} {'int32'} {'uint32'} {'uint32'} {'uint32'} {'uint32'} {'uint32'} {'single'} ];

	p = [head len pnum sysid id messid];
	%% Encode detections data field
	val = typecast(S.detections,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode cluster_iters data field
	val = typecast(S.cluster_iters,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode best_score data field
	val = typecast(S.best_score,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode best_lat data field
	val = typecast(S.best_lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode best_lon data field
	val = typecast(S.best_lon,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode best_alt data field
	val = typecast(S.best_alt,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode best_detection_id data field
	val = typecast(S.best_detection_id,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode best_cluster_id data field
	val = typecast(S.best_cluster_id,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode best_cluster_iter_id data field
	val = typecast(S.best_cluster_iter_id,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode images_done data field
	val = typecast(S.images_done,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode images_todo data field
	val = typecast(S.images_todo,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode fps data field
	val = typecast(S.fps,'single');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
