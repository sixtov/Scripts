//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_GLOBAL_POSITION_SETPOINT_INT(53)
--------------------------------------
%%~ Set the current global position setpoint.
--------------------------------------
*/
public class SET_GLOBAL_POSITION_SETPOINT_INT_class //implements Loggable
{
	public static final int msgID = 53;
	public short	 coordinate_frame; 	// Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
	public int		 latitude;		 	// Latitude (WGS84), in degrees * 1E7
	public int		 longitude;		 	// Longitude (WGS84), in degrees * 1E7
	public int		 altitude;		 	// Altitude (WGS84), in meters * 1000 (positive for up)
	public short	 yaw;				 	// Desired yaw angle in degrees * 100

	private packet rcvPacket;
	private packet sndPacket;

	public SET_GLOBAL_POSITION_SETPOINT_INT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public SET_GLOBAL_POSITION_SETPOINT_INT_class(SET_GLOBAL_POSITION_SETPOINT_INT_class o)
	{
		coordinate_frame = o.coordinate_frame;
		latitude = o.latitude;
		longitude = o.longitude;
		altitude = o.altitude;
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

			// int[] mavLen = {1, 4, 4, 4, 2};
			// int[] javLen = {2, 4, 4, 4, 2};

			coordinate_frame	= rcvPacket.getShortB();
			latitude			= rcvPacket.getInt();
			longitude		= rcvPacket.getInt();
			altitude			= rcvPacket.getInt();
			yaw				= rcvPacket.getShort();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  coordinate_frame
					 ,latitude
					 ,longitude
					 ,altitude
					 ,yaw
					 );
	}

	public byte[] encode(
						 short v_coordinate_frame
						,int v_latitude
						,int v_longitude
						,int v_altitude
						,short v_yaw
						)
	{
		// int[] mavLen = {1, 4, 4, 4, 2};
		// int[] javLen = {2, 4, 4, 4, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_coordinate_frame);	// Add "coordinate_frame" parameter
		sndPacket.putInt(v_latitude);	// Add "latitude" parameter
		sndPacket.putInt(v_longitude);	// Add "longitude" parameter
		sndPacket.putInt(v_altitude);	// Add "altitude" parameter
		sndPacket.putShort(v_yaw);	// Add "yaw" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SET_GLOBAL_POSITION_SETPOINT_INT_coordinate_frame"
 				+ ", SET_GLOBAL_POSITION_SETPOINT_INT_latitude"
 				+ ", SET_GLOBAL_POSITION_SETPOINT_INT_longitude"
 				+ ", SET_GLOBAL_POSITION_SETPOINT_INT_altitude"
 				+ ", SET_GLOBAL_POSITION_SETPOINT_INT_yaw"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + coordinate_frame
 				+ ", " + latitude
 				+ ", " + longitude
 				+ ", " + altitude
 				+ ", " + yaw
				);
		return param;
	}
}
