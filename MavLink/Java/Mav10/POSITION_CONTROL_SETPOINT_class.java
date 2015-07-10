//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: POSITION_CONTROL_SETPOINT(170)
--------------------------------------
--------------------------------------
*/
public class POSITION_CONTROL_SETPOINT_class //implements Loggable
{
	public static final int msgID = 170;
	public int		 id;	 	// ID of waypoint, 0 for plain position
	public float	 x;	 	// x position
	public float	 y;	 	// y position
	public float	 z;	 	// z position
	public float	 yaw;	 	// yaw orientation in radians, 0 = NORTH

	private packet rcvPacket;
	private packet sndPacket;

	public POSITION_CONTROL_SETPOINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public POSITION_CONTROL_SETPOINT_class(POSITION_CONTROL_SETPOINT_class o)
	{
		id = o.id;
		x = o.x;
		y = o.y;
		z = o.z;
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

			// int[] mavLen = {2, 4, 4, 4, 4};
			// int[] javLen = {4, 4, 4, 4, 4};

			id	= rcvPacket.getIntS();
			x	= rcvPacket.getFloat();
			y	= rcvPacket.getFloat();
			z	= rcvPacket.getFloat();
			yaw	= rcvPacket.getFloat();
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
					 ,yaw
					 );
	}

	public byte[] encode(
						 int v_id
						,float v_x
						,float v_y
						,float v_z
						,float v_yaw
						)
	{
		// int[] mavLen = {2, 4, 4, 4, 4};
		// int[] javLen = {4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_id);	// Add "id" parameter
		sndPacket.putFloat(v_x);	// Add "x" parameter
		sndPacket.putFloat(v_y);	// Add "y" parameter
		sndPacket.putFloat(v_z);	// Add "z" parameter
		sndPacket.putFloat(v_yaw);	// Add "yaw" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", POSITION_CONTROL_SETPOINT_id"
 				+ ", POSITION_CONTROL_SETPOINT_x"
 				+ ", POSITION_CONTROL_SETPOINT_y"
 				+ ", POSITION_CONTROL_SETPOINT_z"
 				+ ", POSITION_CONTROL_SETPOINT_yaw"
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
 				+ ", " + yaw
				);
		return param;
	}
}
