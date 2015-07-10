//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: DETECTION_STATS(205)
--------------------------------------
--------------------------------------
*/
public class DETECTION_STATS_class //implements Loggable
{
	public static final int msgID = 205;
	public long	 detections;			 	// Number of detections
	public long	 cluster_iters;		 	// Number of cluster iterations
	public float	 best_score;			 	// Best score
	public int		 best_lat;			 	// Latitude of the best detection * 1E7
	public int		 best_lon;			 	// Longitude of the best detection * 1E7
	public int		 best_alt;			 	// Altitude of the best detection * 1E3
	public long	 best_detection_id;	 	// Best detection ID
	public long	 best_cluster_id;		 	// Best cluster ID
	public long	 best_cluster_iter_id; 	// Best cluster ID
	public long	 images_done;			 	// Number of images already processed
	public long	 images_todo;			 	// Number of images still to process
	public float	 fps;					 	// Average images per seconds processed

	private packet rcvPacket;
	private packet sndPacket;

	public DETECTION_STATS_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public DETECTION_STATS_class(DETECTION_STATS_class o)
	{
		detections = o.detections;
		cluster_iters = o.cluster_iters;
		best_score = o.best_score;
		best_lat = o.best_lat;
		best_lon = o.best_lon;
		best_alt = o.best_alt;
		best_detection_id = o.best_detection_id;
		best_cluster_id = o.best_cluster_id;
		best_cluster_iter_id = o.best_cluster_iter_id;
		images_done = o.images_done;
		images_todo = o.images_todo;
		fps = o.fps;
	}

	public boolean parse(byte[] b)
	{
		return parse(b, false);
	}

	public boolean parse(byte[] b, boolean valid)
	{
		rcvPacket.load(b);

		boolean pstatus = valid || rcvPacket.isPacket();
		if (pstatus)
		{
			rcvPacket.updateSeqNum();

			// int[] mavLen = {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 8, 4, 4, 4, 4, 8, 8, 8, 8, 8, 4};

			detections			= rcvPacket.getLongI();
			cluster_iters		= rcvPacket.getLongI();
			best_score			= rcvPacket.getFloat();
			best_lat				= rcvPacket.getInt();
			best_lon				= rcvPacket.getInt();
			best_alt				= rcvPacket.getInt();
			best_detection_id	= rcvPacket.getLongI();
			best_cluster_id		= rcvPacket.getLongI();
			best_cluster_iter_id	= rcvPacket.getLongI();
			images_done			= rcvPacket.getLongI();
			images_todo			= rcvPacket.getLongI();
			fps					= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  detections
					 ,cluster_iters
					 ,best_score
					 ,best_lat
					 ,best_lon
					 ,best_alt
					 ,best_detection_id
					 ,best_cluster_id
					 ,best_cluster_iter_id
					 ,images_done
					 ,images_todo
					 ,fps
					 );
	}

	public byte[] encode(
						 long v_detections
						,long v_cluster_iters
						,float v_best_score
						,int v_best_lat
						,int v_best_lon
						,int v_best_alt
						,long v_best_detection_id
						,long v_best_cluster_id
						,long v_best_cluster_iter_id
						,long v_images_done
						,long v_images_todo
						,float v_fps
						)
	{
		// int[] mavLen = {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 8, 4, 4, 4, 4, 8, 8, 8, 8, 8, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_detections);	// Add "detections" parameter
		sndPacket.putIntL(v_cluster_iters);	// Add "cluster_iters" parameter
		sndPacket.putFloat(v_best_score);	// Add "best_score" parameter
		sndPacket.putInt(v_best_lat);	// Add "best_lat" parameter
		sndPacket.putInt(v_best_lon);	// Add "best_lon" parameter
		sndPacket.putInt(v_best_alt);	// Add "best_alt" parameter
		sndPacket.putIntL(v_best_detection_id);	// Add "best_detection_id" parameter
		sndPacket.putIntL(v_best_cluster_id);	// Add "best_cluster_id" parameter
		sndPacket.putIntL(v_best_cluster_iter_id);	// Add "best_cluster_iter_id" parameter
		sndPacket.putIntL(v_images_done);	// Add "images_done" parameter
		sndPacket.putIntL(v_images_todo);	// Add "images_todo" parameter
		sndPacket.putFloat(v_fps);	// Add "fps" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", DETECTION_STATS_detections"
 				+ ", DETECTION_STATS_cluster_iters"
 				+ ", DETECTION_STATS_best_score"
 				+ ", DETECTION_STATS_best_lat"
 				+ ", DETECTION_STATS_best_lon"
 				+ ", DETECTION_STATS_best_alt"
 				+ ", DETECTION_STATS_best_detection_id"
 				+ ", DETECTION_STATS_best_cluster_id"
 				+ ", DETECTION_STATS_best_cluster_iter_id"
 				+ ", DETECTION_STATS_images_done"
 				+ ", DETECTION_STATS_images_todo"
 				+ ", DETECTION_STATS_fps"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + detections
 				+ ", " + cluster_iters
 				+ ", " + best_score
 				+ ", " + best_lat
 				+ ", " + best_lon
 				+ ", " + best_alt
 				+ ", " + best_detection_id
 				+ ", " + best_cluster_id
 				+ ", " + best_cluster_iter_id
 				+ ", " + images_done
 				+ ", " + images_todo
 				+ ", " + fps
				);
		return param;
	}
}
