//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_LOCAL_POSITION_SETPOINT(50)
--------------------------------------
%%~ Set the setpoint for a local position controller. This is the position in local 
%%~ coordinates the MAV should fly to. This message is sent by the path/MISSION planner 
%%~ to the onboard position controller. As some MAVs have a degree of freedom in 
%%~ yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
--------------------------------------
*/
public class SET_LOCAL_POSITION_SETPOINT_class //implements Loggable
{
	public static final int msgID = 50;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public short	 coordinate_frame; 	// Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
	public float	 x;				 	// x position
	public float	 y;				 	// y position
	public float	 z;				 	// z position
	public float	 yaw;				 	// Desired yaw angle

	private packet rcvPacket;
	private packet sndPacket;

	public SET_LOCAL_POSITION_SETPOINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public SET_LOCAL_POSITION_SETPOINT_class(SET_LOCAL_POSITION_SETPOINT_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
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

			// int[] mavLen = {1, 1, 1, 4, 4, 4, 4};
			// int[] javLen = {2, 2, 2, 4, 4, 4, 4};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
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
					  (short)1
					 ,(short)1
					 ,coordinate_frame
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
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_coordinate_frame
					 ,v_x
					 ,v_y
					 ,v_z
					 ,v_yaw
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,short v_coordinate_frame
						,float v_x
						,float v_y
						,float v_z
						,float v_yaw
						)
	{
		// int[] mavLen = {1, 1, 1, 4, 4, 4, 4};
		// int[] javLen = {2, 2, 2, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
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
 				+ ", SET_LOCAL_POSITION_SETPOINT_target_system"
 				+ ", SET_LOCAL_POSITION_SETPOINT_target_component"
 				+ ", SET_LOCAL_POSITION_SETPOINT_coordinate_frame"
 				+ ", SET_LOCAL_POSITION_SETPOINT_x"
 				+ ", SET_LOCAL_POSITION_SETPOINT_y"
 				+ ", SET_LOCAL_POSITION_SETPOINT_z"
 				+ ", SET_LOCAL_POSITION_SETPOINT_yaw"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + coordinate_frame
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + yaw
				);
		return param;
	}
}
