//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: IMAGE_TRIGGERED(152)
--------------------------------------
--------------------------------------
*/
public class IMAGE_TRIGGERED_class //implements Loggable
{
	public static final int msgID = 152;
	public long	 timestamp;	 	// Timestamp
	public long	 seq;			 	// IMU seq
	public float	 roll;		 	// Roll angle in rad
	public float	 pitch;		 	// Pitch angle in rad
	public float	 yaw;			 	// Yaw angle in rad
	public float	 local_z;		 	// Local frame Z coordinate (height over ground)
	public float	 lat;			 	// GPS X coordinate
	public float	 lon;			 	// GPS Y coordinate
	public float	 alt;			 	// Global frame altitude
	public float	 ground_x;	 	// Ground truth X
	public float	 ground_y;	 	// Ground truth Y
	public float	 ground_z;	 	// Ground truth Z

	private packet rcvPacket;
	private packet sndPacket;

	public IMAGE_TRIGGERED_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public IMAGE_TRIGGERED_class(IMAGE_TRIGGERED_class o)
	{
		timestamp = o.timestamp;
		seq = o.seq;
		roll = o.roll;
		pitch = o.pitch;
		yaw = o.yaw;
		local_z = o.local_z;
		lat = o.lat;
		lon = o.lon;
		alt = o.alt;
		ground_x = o.ground_x;
		ground_y = o.ground_y;
		ground_z = o.ground_z;
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

			// int[] mavLen = {8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};

			timestamp	= rcvPacket.getLong();
			seq			= rcvPacket.getLongI();
			roll			= rcvPacket.getFloat();
			pitch		= rcvPacket.getFloat();
			yaw			= rcvPacket.getFloat();
			local_z		= rcvPacket.getFloat();
			lat			= rcvPacket.getFloat();
			lon			= rcvPacket.getFloat();
			alt			= rcvPacket.getFloat();
			ground_x		= rcvPacket.getFloat();
			ground_y		= rcvPacket.getFloat();
			ground_z		= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  timestamp
					 ,seq
					 ,roll
					 ,pitch
					 ,yaw
					 ,local_z
					 ,lat
					 ,lon
					 ,alt
					 ,ground_x
					 ,ground_y
					 ,ground_z
					 );
	}

	public byte[] encode(
						 long v_timestamp
						,long v_seq
						,float v_roll
						,float v_pitch
						,float v_yaw
						,float v_local_z
						,float v_lat
						,float v_lon
						,float v_alt
						,float v_ground_x
						,float v_ground_y
						,float v_ground_z
						)
	{
		// int[] mavLen = {8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_timestamp);	// Add "timestamp" parameter
		sndPacket.putIntL(v_seq);	// Add "seq" parameter
		sndPacket.putFloat(v_roll);	// Add "roll" parameter
		sndPacket.putFloat(v_pitch);	// Add "pitch" parameter
		sndPacket.putFloat(v_yaw);	// Add "yaw" parameter
		sndPacket.putFloat(v_local_z);	// Add "local_z" parameter
		sndPacket.putFloat(v_lat);	// Add "lat" parameter
		sndPacket.putFloat(v_lon);	// Add "lon" parameter
		sndPacket.putFloat(v_alt);	// Add "alt" parameter
		sndPacket.putFloat(v_ground_x);	// Add "ground_x" parameter
		sndPacket.putFloat(v_ground_y);	// Add "ground_y" parameter
		sndPacket.putFloat(v_ground_z);	// Add "ground_z" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", IMAGE_TRIGGERED_timestamp"
 				+ ", IMAGE_TRIGGERED_seq"
 				+ ", IMAGE_TRIGGERED_roll"
 				+ ", IMAGE_TRIGGERED_pitch"
 				+ ", IMAGE_TRIGGERED_yaw"
 				+ ", IMAGE_TRIGGERED_local_z"
 				+ ", IMAGE_TRIGGERED_lat"
 				+ ", IMAGE_TRIGGERED_lon"
 				+ ", IMAGE_TRIGGERED_alt"
 				+ ", IMAGE_TRIGGERED_ground_x"
 				+ ", IMAGE_TRIGGERED_ground_y"
 				+ ", IMAGE_TRIGGERED_ground_z"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + timestamp
 				+ ", " + seq
 				+ ", " + roll
 				+ ", " + pitch
 				+ ", " + yaw
 				+ ", " + local_z
 				+ ", " + lat
 				+ ", " + lon
 				+ ", " + alt
 				+ ", " + ground_x
 				+ ", " + ground_y
 				+ ", " + ground_z
				);
		return param;
	}
}
