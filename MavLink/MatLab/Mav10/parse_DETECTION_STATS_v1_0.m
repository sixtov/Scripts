%%  case: 205
function S = parse_DETECTION_STATS_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

