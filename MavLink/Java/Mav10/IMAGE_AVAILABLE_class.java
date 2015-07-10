//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: IMAGE_AVAILABLE(154)
--------------------------------------
--------------------------------------
*/
public class IMAGE_AVAILABLE_class //implements Loggable
{
	public static final int msgID = 154;
	public long	 cam_id;			 	// Camera id
	public short	 cam_no;			 	// Camera # (starts with 0)
	public long	 timestamp;		 	// Timestamp
	public long	 valid_until;		 	// Until which timestamp this buffer will stay valid
	public long	 img_seq;			 	// The image sequence number
	public long	 img_buf_index;	 	// Position of the image in the buffer, starts with 0
	public int		 width;			 	// Image width
	public int		 height;			 	// Image height
	public int		 depth;			 	// Image depth
	public short	 channels;		 	// Image channels
	public long	 key;				 	// Shared memory area key
	public long	 exposure;		 	// Exposure time, in microseconds
	public float	 gain;			 	// Camera gain
	public float	 roll;			 	// Roll angle in rad
	public float	 pitch;			 	// Pitch angle in rad
	public float	 yaw;				 	// Yaw angle in rad
	public float	 local_z;			 	// Local frame Z coordinate (height over ground)
	public float	 lat;				 	// GPS X coordinate
	public float	 lon;				 	// GPS Y coordinate
	public float	 alt;				 	// Global frame altitude
	public float	 ground_x;		 	// Ground truth X
	public float	 ground_y;		 	// Ground truth Y
	public float	 ground_z;		 	// Ground truth Z

	private packet rcvPacket;
	private packet sndPacket;

	public IMAGE_AVAILABLE_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public IMAGE_AVAILABLE_class(IMAGE_AVAILABLE_class o)
	{
		cam_id = o.cam_id;
		cam_no = o.cam_no;
		timestamp = o.timestamp;
		valid_until = o.valid_until;
		img_seq = o.img_seq;
		img_buf_index = o.img_buf_index;
		width = o.width;
		height = o.height;
		depth = o.depth;
		channels = o.channels;
		key = o.key;
		exposure = o.exposure;
		gain = o.gain;
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

			// int[] mavLen = {8, 1, 8, 8, 4, 4, 2, 2, 2, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 2, 8, 8, 8, 8, 4, 4, 4, 2, 8, 8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};

			cam_id			= rcvPacket.getLong();
			cam_no			= rcvPacket.getShortB();
			timestamp		= rcvPacket.getLong();
			valid_until		= rcvPacket.getLong();
			img_seq			= rcvPacket.getLongI();
			img_buf_index	= rcvPacket.getLongI();
			width			= rcvPacket.getIntS();
			height			= rcvPacket.getIntS();
			depth			= rcvPacket.getIntS();
			channels			= rcvPacket.getShortB();
			key				= rcvPacket.getLongI();
			exposure			= rcvPacket.getLongI();
			gain				= rcvPacket.getFloat();
			roll				= rcvPacket.getFloat();
			pitch			= rcvPacket.getFloat();
			yaw				= rcvPacket.getFloat();
			local_z			= rcvPacket.getFloat();
			lat				= rcvPacket.getFloat();
			lon				= rcvPacket.getFloat();
			alt				= rcvPacket.getFloat();
			ground_x			= rcvPacket.getFloat();
			ground_y			= rcvPacket.getFloat();
			ground_z			= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  cam_id
					 ,cam_no
					 ,timestamp
					 ,valid_until
					 ,img_seq
					 ,img_buf_index
					 ,width
					 ,height
					 ,depth
					 ,channels
					 ,key
					 ,exposure
					 ,gain
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
						 long v_cam_id
						,short v_cam_no
						,long v_timestamp
						,long v_valid_until
						,long v_img_seq
						,long v_img_buf_index
						,int v_width
						,int v_height
						,int v_depth
						,short v_channels
						,long v_key
						,long v_exposure
						,float v_gain
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
		// int[] mavLen = {8, 1, 8, 8, 4, 4, 2, 2, 2, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 2, 8, 8, 8, 8, 4, 4, 4, 2, 8, 8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_cam_id);	// Add "cam_id" parameter
		sndPacket.putByteS(v_cam_no);	// Add "cam_no" parameter
		sndPacket.putLong(v_timestamp);	// Add "timestamp" parameter
		sndPacket.putLong(v_valid_until);	// Add "valid_until" parameter
		sndPacket.putIntL(v_img_seq);	// Add "img_seq" parameter
		sndPacket.putIntL(v_img_buf_index);	// Add "img_buf_index" parameter
		sndPacket.putShortI(v_width);	// Add "width" parameter
		sndPacket.putShortI(v_height);	// Add "height" parameter
		sndPacket.putShortI(v_depth);	// Add "depth" parameter
		sndPacket.putByteS(v_channels);	// Add "channels" parameter
		sndPacket.putIntL(v_key);	// Add "key" parameter
		sndPacket.putIntL(v_exposure);	// Add "exposure" parameter
		sndPacket.putFloat(v_gain);	// Add "gain" parameter
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
 				+ ", IMAGE_AVAILABLE_cam_id"
 				+ ", IMAGE_AVAILABLE_cam_no"
 				+ ", IMAGE_AVAILABLE_timestamp"
 				+ ", IMAGE_AVAILABLE_valid_until"
 				+ ", IMAGE_AVAILABLE_img_seq"
 				+ ", IMAGE_AVAILABLE_img_buf_index"
 				+ ", IMAGE_AVAILABLE_width"
 				+ ", IMAGE_AVAILABLE_height"
 				+ ", IMAGE_AVAILABLE_depth"
 				+ ", IMAGE_AVAILABLE_channels"
 				+ ", IMAGE_AVAILABLE_key"
 				+ ", IMAGE_AVAILABLE_exposure"
 				+ ", IMAGE_AVAILABLE_gain"
 				+ ", IMAGE_AVAILABLE_roll"
 				+ ", IMAGE_AVAILABLE_pitch"
 				+ ", IMAGE_AVAILABLE_yaw"
 				+ ", IMAGE_AVAILABLE_local_z"
 				+ ", IMAGE_AVAILABLE_lat"
 				+ ", IMAGE_AVAILABLE_lon"
 				+ ", IMAGE_AVAILABLE_alt"
 				+ ", IMAGE_AVAILABLE_ground_x"
 				+ ", IMAGE_AVAILABLE_ground_y"
 				+ ", IMAGE_AVAILABLE_ground_z"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + cam_id
 				+ ", " + cam_no
 				+ ", " + timestamp
 				+ ", " + valid_until
 				+ ", " + img_seq
 				+ ", " + img_buf_index
 				+ ", " + width
 				+ ", " + height
 				+ ", " + depth
 				+ ", " + channels
 				+ ", " + key
 				+ ", " + exposure
 				+ ", " + gain
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
