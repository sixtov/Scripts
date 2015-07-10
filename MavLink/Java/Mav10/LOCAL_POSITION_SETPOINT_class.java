//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: LOCAL_POSITION_SETPOINT(51)
--------------------------------------
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
--------------------------------------
*/
public class LOCAL_POSITION_SETPOINT_class //implements Loggable
{
	public static final int msgID = 51;
	public short	 coordinate_frame; 	// Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
	public float	 x;				 	// x position
	public float	 y;				 	// y position
	public float	 z;				 	// z position
	public float	 yaw;				 	// Desired yaw angle

	private packet rcvPacket;
	private packet sndPacket;

	public LOCAL_POSITION_SETPOINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public LOCAL_POSITION_SETPOINT_class(LOCAL_POSITION_SETPOINT_class o)
	{
		coordinate_frame = o.coordinate_frame;
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

			// int[] mavLen = {1, 4, 4, 4, 4};
			// int[] javLen = {2, 4, 4, 4, 4};

			coordinate_frame	= rcvPacket.getShortB();
			x				= rcvPacket.getFloat();
			y				= rcvPacket.getFloat();
			z				= rcvPacket.getFloat();
			yaw				= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  coordinate_frame
					 ,x
					 ,y
					 ,z
					 ,yaw
					 );
	}

	public byte[] encode(
						 short v_coordinate_frame
						,float v_x
						,float v_y
						,float v_z
						,float v_yaw
						)
	{
		// int[] mavLen = {1, 4, 4, 4, 4};
		// int[] javLen = {2, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_coordinate_frame);	// Add "coordinate_frame" parameter
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
 				+ ", LOCAL_POSITION_SETPOINT_coordinate_frame"
 				+ ", LOCAL_POSITION_SETPOINT_x"
 				+ ", LOCAL_POSITION_SETPOINT_y"
 				+ ", LOCAL_POSITION_SETPOINT_z"
 				+ ", LOCAL_POSITION_SETPOINT_yaw"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + coordinate_frame
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + yaw
				);
		return param;
	}
}
