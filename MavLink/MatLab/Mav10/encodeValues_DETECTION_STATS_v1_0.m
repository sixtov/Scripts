%%%%  case: 205
function p = encodeValues_DETECTION_STATS_v1_0(detections,cluster_iters,best_score,best_lat,best_lon,best_alt,best_detection_id,best_cluster_id,best_cluster_iter_id,images_done,images_todo,fps)
	S.detections = typecast(uint32(detections),'uint32');		% Number of detections
	S.cluster_iters = typecast(uint32(cluster_iters),'uint32');		% Number of cluster iterations
	S.best_score = typecast(single(best_score),'single');		% Best score
	S.best_lat = typecast(int32(best_lat),'int32');		% Latitude of the best detection * 1E7
	S.best_lon = typecast(int32(best_lon),'int32');		% Longitude of the best detection * 1E7
	S.best_alt = typecast(int32(best_alt),'int32');		% Altitude of the best detection * 1E3
	S.best_detection_id = typecast(uint32(best_detection_id),'uint32');		% Best detection ID
	S.best_cluster_id = typecast(uint32(best_cluster_id),'uint32');		% Best cluster ID
	S.best_cluster_iter_id = typecast(uint32(best_cluster_iter_id),'uint32');		% Best cluster ID
	S.images_done = typecast(uint32(images_done),'uint32');		% Number of images already processed
	S.images_todo = typecast(uint32(images_todo),'uint32');		% Number of images still to process
	S.fps = typecast(single(fps),'single');		% Average images per seconds processed
	p = encode_DETECTION_STATS_v1_0(S);
return
