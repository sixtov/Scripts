//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_POSITION_CONTROL_OFFSET(160)
--------------------------------------
%%~ Message sent to the MAV to set a new offset from the currently controlled position
--------------------------------------
*/
public class SET_POSITION_CONTROL_OFFSET_class //implements Loggable
{
	public static final int msgID = 160;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public float	 x;				 	// x position offset
	public float	 y;				 	// y position offset
	public float	 z;				 	// z position offset
	public float	 yaw;				 	// yaw orientation offset in radians, 0 = NORTH

	private packet rcvPacket;
	private packet sndPacket;

	public SET_POSITION_CONTROL_OFFSET_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public SET_POSITION_CONTROL_OFFSET_class(SET_POSITION_CONTROL_OFFSET_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
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

			// int[] mavLen = {1, 1, 4, 4, 4, 4};
			// int[] javLen = {2, 2, 4, 4, 4, 4};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
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
					  (short)1
					 ,(short)1
					 ,x
					 ,y
					 ,z
					 ,yaw
					 );
	}

	public byte[] encode(
						 float v_x
						,float v_y
						,float v_z
						,float v_yaw
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_x
					 ,v_y
					 ,v_z
					 ,v_yaw
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,float v_x
						,float v_y
						,float v_z
						,float v_yaw
						)
	{
		// int[] mavLen = {1, 1, 4, 4, 4, 4};
		// int[] javLen = {2, 2, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
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
 				+ ", SET_POSITION_CONTROL_OFFSET_target_system"
 				+ ", SET_POSITION_CONTROL_OFFSET_target_component"
 				+ ", SET_POSITION_CONTROL_OFFSET_x"
 				+ ", SET_POSITION_CONTROL_OFFSET_y"
 				+ ", SET_POSITION_CONTROL_OFFSET_z"
 				+ ", SET_POSITION_CONTROL_OFFSET_yaw"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + yaw
				);
		return param;
	}
}
