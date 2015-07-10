//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: OMNIDIRECTIONAL_FLOW(106)
--------------------------------------
%%~ Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
--------------------------------------
*/
public class OMNIDIRECTIONAL_FLOW_class //implements Loggable
{
	public static final int msgID = 106;
	public long	 time_usec;		 	// Timestamp (microseconds, synced to UNIX time or since system boot)
	public short	 sensor_id;		 	// Sensor ID
	public short[]	 left = new short[20];				// Flow in deci pixels (1 = 0.1 pixel) on left hemisphere
	public short[]	 right = new short[20];				// Flow in deci pixels (1 = 0.1 pixel) on right hemisphere
	public short	 quality;			 	// Optical flow quality / confidence. 0: bad, 255: maximum quality
	public float	 front_distance_m; 	// Front distance in meters. Positive value (including zero): distance known. Negative value: Unknown distance

	private packet rcvPacket;
	private packet sndPacket;

	public OMNIDIRECTIONAL_FLOW_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public OMNIDIRECTIONAL_FLOW_class(OMNIDIRECTIONAL_FLOW_class o)
	{
		time_usec = o.time_usec;
		sensor_id = o.sensor_id;
		left = o.left;
		right = o.right;
		quality = o.quality;
		front_distance_m = o.front_distance_m;
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

			// int[] mavLen = {8, 1, 2, 2, 1, 4};
			// int[] javLen = {8, 2, 20, 20, 2, 4};

			time_usec		= rcvPacket.getLong();
			sensor_id		= rcvPacket.getShortB();
			rcvPacket.getByte(left, 0, 20);
			rcvPacket.getByte(right, 0, 20);
			quality			= rcvPacket.getShortB();
			front_distance_m	= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_usec
					 ,sensor_id
					 ,left
					 ,right
					 ,quality
					 ,front_distance_m
					 );
	}

	public byte[] encode(
						 long v_time_usec
						,short v_sensor_id
						,short[] v_left
						,short[] v_right
						,short v_quality
						,float v_front_distance_m
						)
	{
		// int[] mavLen = {8, 1, 2, 2, 1, 4};
		// int[] javLen = {8, 2, 20, 20, 2, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_time_usec);	// Add "time_usec" parameter
		sndPacket.putByteS(v_sensor_id);	// Add "sensor_id" parameter
		sndPacket.putByte(v_left,0,20);	// Add "left" parameter
		sndPacket.putByte(v_right,0,20);	// Add "right" parameter
		sndPacket.putByteS(v_quality);	// Add "quality" parameter
		sndPacket.putFloat(v_front_distance_m);	// Add "front_distance_m" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", OMNIDIRECTIONAL_FLOW_time_usec"
 				+ ", OMNIDIRECTIONAL_FLOW_sensor_id"
 				+ ", OMNIDIRECTIONAL_FLOW_left"
 				+ ", OMNIDIRECTIONAL_FLOW_right"
 				+ ", OMNIDIRECTIONAL_FLOW_quality"
 				+ ", OMNIDIRECTIONAL_FLOW_front_distance_m"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_usec
 				+ ", " + sensor_id
 				+ ", " + left
 				+ ", " + right
 				+ ", " + quality
 				+ ", " + front_distance_m
				);
		return param;
	}
}
