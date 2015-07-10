//MavLink 0.9

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: GPS_LOCAL_ORIGIN_SET(49)
--------------------------------------
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
--------------------------------------
*/
public class GPS_LOCAL_ORIGIN_SET_class //implements Loggable
{
	public static final int msgID = 49;
	public int	 latitude;	 	// Latitude (WGS84), expressed as * 1E7
	public int	 longitude;	 	// Longitude (WGS84), expressed as * 1E7
	public int	 altitude;	 	// Altitude(WGS84), expressed as * 1000

	private packet rcvPacket;
	private packet sndPacket;

	public GPS_LOCAL_ORIGIN_SET_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public GPS_LOCAL_ORIGIN_SET_class(GPS_LOCAL_ORIGIN_SET_class o)
	{
		latitude = o.latitude;
		longitude = o.longitude;
		altitude = o.altitude;
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

			// int[] mavLen = {4, 4, 4};
			// int[] javLen = {4, 4, 4};

			latitude		= rcvPacket.getInt();
			longitude	= rcvPacket.getInt();
			altitude		= rcvPacket.getInt();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  latitude
					 ,longitude
					 ,altitude
					 );
	}

	public byte[] encode(
						 int v_latitude
						,int v_longitude
						,int v_altitude
						)
	{
		// int[] mavLen = {4, 4, 4};
		// int[] javLen = {4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putInt(v_latitude);	// Add "latitude" parameter
		sndPacket.putInt(v_longitude);	// Add "longitude" parameter
		sndPacket.putInt(v_altitude);	// Add "altitude" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", GPS_LOCAL_ORIGIN_SET_latitude"
 				+ ", GPS_LOCAL_ORIGIN_SET_longitude"
 				+ ", GPS_LOCAL_ORIGIN_SET_altitude"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + latitude
 				+ ", " + longitude
 				+ ", " + altitude
				);
		return param;
	}
}
