//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: GLOBAL_POSITION_INT_COV(63)
--------------------------------------
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It  is designed as scaled integer message since 
%%~ the resolution of float is not sufficient. NOTE: This message is intended for 
%%~ onboard networks / companion computers and higher-bandwidth links and optimized 
%%~ for accuracy and completeness. Please use the GLOBAL_POSITION_INT message for 
%%~ a minimal subset.
--------------------------------------
*/
public class GLOBAL_POSITION_INT_COV_class //implements Loggable
{
	public static final int msgID = 63;
	public long	 time_boot_ms;	 	// Timestamp (milliseconds since system boot)
	public long	 time_utc;		 	// Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
	public short	 estimator_type;	 	// Class id of the estimator this estimate originated from.
	public int		 lat;				 	// Latitude, expressed as degrees * 1E7
	public int		 lon;				 	// Longitude, expressed as degrees * 1E7
	public int		 alt;				 	// Altitude in meters, expressed as * 1000 (millimeters), above MSL
	public int		 relative_alt;	 	// Altitude above ground in meters, expressed as * 1000 (millimeters)
	public float	 vx;				 	// Ground X Speed (Latitude), expressed as m/s
	public float	 vy;				 	// Ground Y Speed (Longitude), expressed as m/s
	public float	 vz;				 	// Ground Z Speed (Altitude), expressed as m/s
	public float[]	 covariance = new float[144];			// Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)

	private packet rcvPacket;
	private packet sndPacket;

	public GLOBAL_POSITION_INT_COV_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public GLOBAL_POSITION_INT_COV_class(GLOBAL_POSITION_INT_COV_class o)
	{
		time_boot_ms = o.time_boot_ms;
		time_utc = o.time_utc;
		estimator_type = o.estimator_type;
		lat = o.lat;
		lon = o.lon;
		alt = o.alt;
		relative_alt = o.relative_alt;
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

			// int[] mavLen = {4, 8, 1, 4, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 8, 2, 4, 4, 4, 4, 4, 4, 4, 144};

			time_boot_ms		= rcvPacket.getLongI();
			time_utc			= rcvPacket.getLong();
			estimator_type	= rcvPacket.getShortB();
			lat				= rcvPacket.getInt();
			lon				= rcvPacket.getInt();
			alt				= rcvPacket.getInt();
			relative_alt		= rcvPacket.getInt();
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
					 ,lat
					 ,lon
					 ,alt
					 ,relative_alt
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
						,int v_lat
						,int v_lon
						,int v_alt
						,int v_relative_alt
						,float v_vx
						,float v_vy
						,float v_vz
						,float[] v_covariance
						)
	{
		// int[] mavLen = {4, 8, 1, 4, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 8, 2, 4, 4, 4, 4, 4, 4, 4, 144};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_time_boot_ms);	// Add "time_boot_ms" parameter
		sndPacket.putLong(v_time_utc);	// Add "time_utc" parameter
		sndPacket.putByteS(v_estimator_type);	// Add "estimator_type" parameter
		sndPacket.putInt(v_lat);	// Add "lat" parameter
		sndPacket.putInt(v_lon);	// Add "lon" parameter
		sndPacket.putInt(v_alt);	// Add "alt" parameter
		sndPacket.putInt(v_relative_alt);	// Add "relative_alt" parameter
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
 				+ ", GLOBAL_POSITION_INT_COV_time_boot_ms"
 				+ ", GLOBAL_POSITION_INT_COV_time_utc"
 				+ ", GLOBAL_POSITION_INT_COV_estimator_type"
 				+ ", GLOBAL_POSITION_INT_COV_lat"
 				+ ", GLOBAL_POSITION_INT_COV_lon"
 				+ ", GLOBAL_POSITION_INT_COV_alt"
 				+ ", GLOBAL_POSITION_INT_COV_relative_alt"
 				+ ", GLOBAL_POSITION_INT_COV_vx"
 				+ ", GLOBAL_POSITION_INT_COV_vy"
 				+ ", GLOBAL_POSITION_INT_COV_vz"
 				+ ", GLOBAL_POSITION_INT_COV_covariance"
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
 				+ ", " + lat
 				+ ", " + lon
 				+ ", " + alt
 				+ ", " + relative_alt
 				+ ", " + vx
 				+ ", " + vy
 				+ ", " + vz
 				+ ", " + covariance
				);
		return param;
	}
}
