//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: MARKER(171)
--------------------------------------
--------------------------------------
*/
public class MARKER_class //implements Loggable
{
	public static final int msgID = 171;
	public int		 id;		 	// ID
	public float	 x;		 	// x position
	public float	 y;		 	// y position
	public float	 z;		 	// z position
	public float	 roll;	 	// roll orientation
	public float	 pitch;	 	// pitch orientation
	public float	 yaw;		 	// yaw orientation

	private packet rcvPacket;
	private packet sndPacket;

	public MARKER_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public MARKER_class(MARKER_class o)
	{
		id = o.id;
		x = o.x;
		y = o.y;
		z = o.z;
		roll = o.roll;
		pitch = o.pitch;
		yaw = o.yaw;
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

			// int[] mavLen = {2, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {4, 4, 4, 4, 4, 4, 4};

			id		= rcvPacket.getIntS();
			x		= rcvPacket.getFloat();
			y		= rcvPacket.getFloat();
			z		= rcvPacket.getFloat();
			roll		= rcvPacket.getFloat();
			pitch	= rcvPacket.getFloat();
			yaw		= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  id
					 ,x
					 ,y
					 ,z
					 ,roll
					 ,pitch
					 ,yaw
					 );
	}

	public byte[] encode(
						 int v_id
						,float v_x
						,float v_y
						,float v_z
						,float v_roll
						,float v_pitch
						,float v_yaw
						)
	{
		// int[] mavLen = {2, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {4, 4, 4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_id);	// Add "id" parameter
		sndPacket.putFloat(v_x);	// Add "x" parameter
		sndPacket.putFloat(v_y);	// Add "y" parameter
		sndPacket.putFloat(v_z);	// Add "z" parameter
		sndPacket.putFloat(v_roll);	// Add "roll" parameter
		sndPacket.putFloat(v_pitch);	// Add "pitch" parameter
		sndPacket.putFloat(v_yaw);	// Add "yaw" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", MARKER_id"
 				+ ", MARKER_x"
 				+ ", MARKER_y"
 				+ ", MARKER_z"
 				+ ", MARKER_roll"
 				+ ", MARKER_pitch"
 				+ ", MARKER_yaw"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + id
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + roll
 				+ ", " + pitch
 				+ ", " + yaw
				);
		return param;
	}
}
