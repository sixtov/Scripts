//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_GPS_GLOBAL_ORIGIN(48)
--------------------------------------
%%~ As local waypoints exist, the global MISSION reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should move 
%%~ from in- to outdoor.
--------------------------------------
*/
public class SET_GPS_GLOBAL_ORIGIN_class //implements Loggable
{
	public static final int msgID = 48;
	public short	 target_system;	 	// System ID
	public int		 latitude;		 	// Latitude (WGS84), in degrees * 1E7
	public int		 longitude;		 	// Longitude (WGS84, in degrees * 1E7
	public int		 altitude;		 	// Altitude (AMSL), in meters * 1000 (positive for up)

	private packet rcvPacket;
	private packet sndPacket;

	public SET_GPS_GLOBAL_ORIGIN_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
	}

	public SET_GPS_GLOBAL_ORIGIN_class(SET_GPS_GLOBAL_ORIGIN_class o)
	{
		target_system = o.target_system;
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

			// int[] mavLen = {1, 4, 4, 4};
			// int[] javLen = {2, 4, 4, 4};

			target_system	= rcvPacket.getShortB();
			latitude			= rcvPacket.getInt();
			longitude		= rcvPacket.getInt();
			altitude			= rcvPacket.getInt();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,latitude
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
		return encode(
					    (short)1
					 ,v_latitude
					 ,v_longitude
					 ,v_altitude
					 );
	}

	public byte[] encode(
						 short v_target_system
						,int v_latitude
						,int v_longitude
						,int v_altitude
						)
	{
		// int[] mavLen = {1, 4, 4, 4};
		// int[] javLen = {2, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
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
 				+ ", SET_GPS_GLOBAL_ORIGIN_target_system"
 				+ ", SET_GPS_GLOBAL_ORIGIN_latitude"
 				+ ", SET_GPS_GLOBAL_ORIGIN_longitude"
 				+ ", SET_GPS_GLOBAL_ORIGIN_altitude"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + latitude
 				+ ", " + longitude
 				+ ", " + altitude
				);
		return param;
	}
}
