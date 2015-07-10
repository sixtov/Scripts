//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: LOCAL_POSITION_NED_COV(64)
--------------------------------------
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
%%~ convention)
--------------------------------------
*/
public class LOCAL_POSITION_NED_COV_class //implements Loggable
{
	public static final int msgID = 64;
	public long	 time_boot_ms;	 	// Timestamp (milliseconds since system boot)
	public long	 time_utc;		 	// Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
	public short	 estimator_type;	 	// Class id of the estimator this estimate originated from.
	public float	 x;				 	// X Position
	public float	 y;				 	// Y Position
	public float	 z;				 	// Z Position
	public float	 vx;				 	// X Speed
	public float	 vy;				 	// Y Speed
	public float	 vz;				 	// Z Speed
	public float[]	 covariance = new float[144];			// Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)

	private packet rcvPacket;
	private packet sndPacket;

	public LOCAL_POSITION_NED_COV_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public LOCAL_POSITION_NED_COV_class(LOCAL_POSITION_NED_COV_class o)
	{
		time_boot_ms = o.time_boot_ms;
		time_utc = o.time_utc;
		estimator_type = o.estimator_type;
		x = o.x;
		y = o.y;
		z = o.z;
		vx = o.vx;
		vy = o.vy;
		vz = o.vz;
		covariance = o.covariance;
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

			// int[] mavLen = {4, 8, 1, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 8, 2, 4, 4, 4, 4, 4, 4, 144};

			time_boot_ms		= rcvPacket.getLongI();
			time_utc			= rcvPacket.getLong();
			estimator_type	= rcvPacket.getShortB();
			x				= rcvPacket.getFloat();
			y				= rcvPacket.getFloat();
			z				= rcvPacket.getFloat();
			vx				= rcvPacket.getFloat();
			vy				= rcvPacket.getFloat();
			vz				= rcvPacket.getFloat();
			rcvPacket.getByte(covariance, 0, 144);
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_boot_ms
					 ,time_utc
					 ,estimator_type
					 ,x
					 ,y
					 ,z
					 ,vx
					 ,vy
					 ,vz
					 ,covariance
					 );
	}

	public byte[] encode(
						 long v_time_boot_ms
						,long v_time_utc
						,short v_estimator_type
						,float v_x
						,float v_y
						,float v_z
						,float v_vx
						,float v_vy
						,float v_vz
						,float[] v_covariance
						)
	{
		// int[] mavLen = {4, 8, 1, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 8, 2, 4, 4, 4, 4, 4, 4, 144};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_time_boot_ms);	// Add "time_boot_ms" parameter
		sndPacket.putLong(v_time_utc);	// Add "time_utc" parameter
		sndPacket.putByteS(v_estimator_type);	// Add "estimator_type" parameter
		sndPacket.putFloat(v_x);	// Add "x" parameter
		sndPacket.putFloat(v_y);	// Add "y" parameter
		sndPacket.putFloat(v_z);	// Add "z" parameter
		sndPacket.putFloat(v_vx);	// Add "vx" parameter
		sndPacket.putFloat(v_vy);	// Add "vy" parameter
		sndPacket.putFloat(v_vz);	// Add "vz" parameter
		sndPacket.putByte(v_covariance,0,144);	// Add "covariance" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", LOCAL_POSITION_NED_COV_time_boot_ms"
 				+ ", LOCAL_POSITION_NED_COV_time_utc"
 				+ ", LOCAL_POSITION_NED_COV_estimator_type"
 				+ ", LOCAL_POSITION_NED_COV_x"
 				+ ", LOCAL_POSITION_NED_COV_y"
 				+ ", LOCAL_POSITION_NED_COV_z"
 				+ ", LOCAL_POSITION_NED_COV_vx"
 				+ ", LOCAL_POSITION_NED_COV_vy"
 				+ ", LOCAL_POSITION_NED_COV_vz"
 				+ ", LOCAL_POSITION_NED_COV_covariance"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_boot_ms
 				+ ", " + time_utc
 				+ ", " + estimator_type
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
 				+ ", " + vx
 				+ ", " + vy
 				+ ", " + vz
 				+ ", " + covariance
				);
		return param;
	}
}
