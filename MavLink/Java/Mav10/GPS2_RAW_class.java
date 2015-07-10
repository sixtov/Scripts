//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: GPS2_RAW(124)
--------------------------------------
%%~ Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
--------------------------------------
*/
public class GPS2_RAW_class //implements Loggable
{
	public static final int msgID = 124;
	public long	 time_usec;			 	// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
	public short	 fix_type;			 	// 0-1: no fix, 2: 2D fix, 3: 3D fix, 4: DGPS fix, 5: RTK Fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
	public int		 lat;					 	// Latitude (WGS84), in degrees * 1E7
	public int		 lon;					 	// Longitude (WGS84), in degrees * 1E7
	public int		 alt;					 	// Altitude (AMSL, not WGS84), in meters * 1000 (positive for up)
	public int		 eph;					 	// GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
	public int		 epv;					 	// GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
	public int		 vel;					 	// GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX
	public int		 cog;					 	// Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
	public short	 satellites_visible;	 	// Number of satellites visible. If unknown, set to 255
	public short	 dgps_numch;			 	// Number of DGPS satellites
	public long	 dgps_age;			 	// Age of DGPS info

	private packet rcvPacket;
	private packet sndPacket;

	public GPS2_RAW_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public GPS2_RAW_class(GPS2_RAW_class o)
	{
		time_usec = o.time_usec;
		fix_type = o.fix_type;
		lat = o.lat;
		lon = o.lon;
		alt = o.alt;
		eph = o.eph;
		epv = o.epv;
		vel = o.vel;
		cog = o.cog;
		satellites_visible = o.satellites_visible;
		dgps_numch = o.dgps_numch;
		dgps_age = o.dgps_age;
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

			// int[] mavLen = {8, 1, 4, 4, 4, 2, 2, 2, 2, 1, 1, 4};
			// int[] javLen = {8, 2, 4, 4, 4, 4, 4, 4, 4, 2, 2, 8};

			time_usec			= rcvPacket.getLong();
			fix_type				= rcvPacket.getShortB();
			lat					= rcvPacket.getInt();
			lon					= rcvPacket.getInt();
			alt					= rcvPacket.getInt();
			eph					= rcvPacket.getIntS();
			epv					= rcvPacket.getIntS();
			vel					= rcvPacket.getIntS();
			cog					= rcvPacket.getIntS();
			satellites_visible	= rcvPacket.getShortB();
			dgps_numch			= rcvPacket.getShortB();
			dgps_age				= rcvPacket.getLongI();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_usec
					 ,fix_type
					 ,lat
					 ,lon
					 ,alt
					 ,eph
					 ,epv
					 ,vel
					 ,cog
					 ,satellites_visible
					 ,dgps_numch
					 ,dgps_age
					 );
	}

	public byte[] encode(
						 long v_time_usec
						,short v_fix_type
						,int v_lat
						,int v_lon
						,int v_alt
						,int v_eph
						,int v_epv
						,int v_vel
						,int v_cog
						,short v_satellites_visible
						,short v_dgps_numch
						,long v_dgps_age
						)
	{
		// int[] mavLen = {8, 1, 4, 4, 4, 2, 2, 2, 2, 1, 1, 4};
		// int[] javLen = {8, 2, 4, 4, 4, 4, 4, 4, 4, 2, 2, 8};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_time_usec);	// Add "time_usec" parameter
		sndPacket.putByteS(v_fix_type);	// Add "fix_type" parameter
		sndPacket.putInt(v_lat);	// Add "lat" parameter
		sndPacket.putInt(v_lon);	// Add "lon" parameter
		sndPacket.putInt(v_alt);	// Add "alt" parameter
		sndPacket.putShortI(v_eph);	// Add "eph" parameter
		sndPacket.putShortI(v_epv);	// Add "epv" parameter
		sndPacket.putShortI(v_vel);	// Add "vel" parameter
		sndPacket.putShortI(v_cog);	// Add "cog" parameter
		sndPacket.putByteS(v_satellites_visible);	// Add "satellites_visible" parameter
		sndPacket.putByteS(v_dgps_numch);	// Add "dgps_numch" parameter
		sndPacket.putIntL(v_dgps_age);	// Add "dgps_age" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", GPS2_RAW_time_usec"
 				+ ", GPS2_RAW_fix_type"
 				+ ", GPS2_RAW_lat"
 				+ ", GPS2_RAW_lon"
 				+ ", GPS2_RAW_alt"
 				+ ", GPS2_RAW_eph"
 				+ ", GPS2_RAW_epv"
 				+ ", GPS2_RAW_vel"
 				+ ", GPS2_RAW_cog"
 				+ ", GPS2_RAW_satellites_visible"
 				+ ", GPS2_RAW_dgps_numch"
 				+ ", GPS2_RAW_dgps_age"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_usec
 				+ ", " + fix_type
 				+ ", " + lat
 				+ ", " + lon
 				+ ", " + alt
 				+ ", " + eph
 				+ ", " + epv
 				+ ", " + vel
 				+ ", " + cog
 				+ ", " + satellites_visible
 				+ ", " + dgps_numch
 				+ ", " + dgps_age
				);
		return param;
	}
}
