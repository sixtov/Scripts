//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: HIL_OPTICAL_FLOW(114)
--------------------------------------
%%~ Simulated optical flow from a flow sensor (e.g. optical mouse sensor)
--------------------------------------
*/
public class HIL_OPTICAL_FLOW_class //implements Loggable
{
	public static final int msgID = 114;
	public long	 time_usec;		 	// Timestamp (UNIX)
	public short	 sensor_id;		 	// Sensor ID
	public short	 flow_x;			 	// Flow in pixels in x-sensor direction
	public short	 flow_y;			 	// Flow in pixels in y-sensor direction
	public float	 flow_comp_m_x;	 	// Flow in meters in x-sensor direction, angular-speed compensated
	public float	 flow_comp_m_y;	 	// Flow in meters in y-sensor direction, angular-speed compensated
	public short	 quality;			 	// Optical flow quality / confidence. 0: bad, 255: maximum quality
	public float	 ground_distance;	 	// Ground distance in meters. Positive value: distance known. Negative value: Unknown distance

	private packet rcvPacket;
	private packet sndPacket;

	public HIL_OPTICAL_FLOW_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public HIL_OPTICAL_FLOW_class(HIL_OPTICAL_FLOW_class o)
	{
		time_usec = o.time_usec;
		sensor_id = o.sensor_id;
		flow_x = o.flow_x;
		flow_y = o.flow_y;
		flow_comp_m_x = o.flow_comp_m_x;
		flow_comp_m_y = o.flow_comp_m_y;
		quality = o.quality;
		ground_distance = o.ground_distance;
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

			// int[] mavLen = {8, 1, 2, 2, 4, 4, 1, 4};
			// int[] javLen = {8, 2, 2, 2, 4, 4, 2, 4};

			time_usec		= rcvPacket.getLong();
			sensor_id		= rcvPacket.getShortB();
			flow_x			= rcvPacket.getShort();
			flow_y			= rcvPacket.getShort();
			flow_comp_m_x	= rcvPacket.getFloat();
			flow_comp_m_y	= rcvPacket.getFloat();
			quality			= rcvPacket.getShortB();
			ground_distance	= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_usec
					 ,sensor_id
					 ,flow_x
					 ,flow_y
					 ,flow_comp_m_x
					 ,flow_comp_m_y
					 ,quality
					 ,ground_distance
					 );
	}

	public byte[] encode(
						 long v_time_usec
						,short v_sensor_id
						,short v_flow_x
						,short v_flow_y
						,float v_flow_comp_m_x
						,float v_flow_comp_m_y
						,short v_quality
						,float v_ground_distance
						)
	{
		// int[] mavLen = {8, 1, 2, 2, 4, 4, 1, 4};
		// int[] javLen = {8, 2, 2, 2, 4, 4, 2, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_time_usec);	// Add "time_usec" parameter
		sndPacket.putByteS(v_sensor_id);	// Add "sensor_id" parameter
		sndPacket.putShort(v_flow_x);	// Add "flow_x" parameter
		sndPacket.putShort(v_flow_y);	// Add "flow_y" parameter
		sndPacket.putFloat(v_flow_comp_m_x);	// Add "flow_comp_m_x" parameter
		sndPacket.putFloat(v_flow_comp_m_y);	// Add "flow_comp_m_y" parameter
		sndPacket.putByteS(v_quality);	// Add "quality" parameter
		sndPacket.putFloat(v_ground_distance);	// Add "ground_distance" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", HIL_OPTICAL_FLOW_time_usec"
 				+ ", HIL_OPTICAL_FLOW_sensor_id"
 				+ ", HIL_OPTICAL_FLOW_flow_x"
 				+ ", HIL_OPTICAL_FLOW_flow_y"
 				+ ", HIL_OPTICAL_FLOW_flow_comp_m_x"
 				+ ", HIL_OPTICAL_FLOW_flow_comp_m_y"
 				+ ", HIL_OPTICAL_FLOW_quality"
 				+ ", HIL_OPTICAL_FLOW_ground_distance"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_usec
 				+ ", " + sensor_id
 				+ ", " + flow_x
 				+ ", " + flow_y
 				+ ", " + flow_comp_m_x
 				+ ", " + flow_comp_m_y
 				+ ", " + quality
 				+ ", " + ground_distance
				);
		return param;
	}
}
