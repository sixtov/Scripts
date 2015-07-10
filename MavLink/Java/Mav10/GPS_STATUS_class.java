//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: GPS_STATUS(25)
--------------------------------------
%%~ The positioning status, as reported by GPS. This message is intended to display 
%%~ status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
%%~ for the global position estimate. This message can contain information 
%%~ for up to 20 satellites.
--------------------------------------
*/
public class GPS_STATUS_class //implements Loggable
{
	public static final int msgID = 25;
	public short	 satellites_visible;	 	// Number of satellites visible
	public short[]	 satellite_prn = new short[40];			// Global satellite ID
	public short[]	 satellite_used = new short[40];			// 0: Satellite not used, 1: used for localization
	public short[]	 satellite_elevation = new short[40];		// Elevation (0: right on top of receiver, 90: on the horizon) of satellite
	public short[]	 satellite_azimuth = new short[40];		// Direction of satellite, 0: 0 deg, 255: 360 deg.
	public short[]	 satellite_snr = new short[40];			// Signal to noise ratio of satellite

	private packet rcvPacket;
	private packet sndPacket;

	public GPS_STATUS_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public GPS_STATUS_class(GPS_STATUS_class o)
	{
		satellites_visible = o.satellites_visible;
		satellite_prn = o.satellite_prn;
		satellite_used = o.satellite_used;
		satellite_elevation = o.satellite_elevation;
		satellite_azimuth = o.satellite_azimuth;
		satellite_snr = o.satellite_snr;
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

			// int[] mavLen = {1, 1, 1, 1, 1, 1};
			// int[] javLen = {2, 40, 40, 40, 40, 40};

			satellites_visible	= rcvPacket.getShortB();
//	ERROR	Parsing 'satellite_prn' array of 'short' from 'uint8_t[20]'
//	ERROR	Parsing 'satellite_used' array of 'short' from 'uint8_t[20]'
//	ERROR	Parsing 'satellite_elevation' array of 'short' from 'uint8_t[20]'
//	ERROR	Parsing 'satellite_azimuth' array of 'short' from 'uint8_t[20]'
//	ERROR	Parsing 'satellite_snr' array of 'short' from 'uint8_t[20]'
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  satellites_visible
					 ,satellite_prn
					 ,satellite_used
					 ,satellite_elevation
					 ,satellite_azimuth
					 ,satellite_snr
					 );
	}

	public byte[] encode(
						 short v_satellites_visible
						,short[] v_satellite_prn
						,short[] v_satellite_used
						,short[] v_satellite_elevation
						,short[] v_satellite_azimuth
						,short[] v_satellite_snr
						)
	{
		// int[] mavLen = {1, 1, 1, 1, 1, 1};
		// int[] javLen = {2, 40, 40, 40, 40, 40};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_satellites_visible);	// Add "satellites_visible" parameter
//	ERROR	Encoding 'satellite_prn' array of 'short' from 'uint8_t[20]'
	// Add "satellite_prn" parameter
//	ERROR	Encoding 'satellite_used' array of 'short' from 'uint8_t[20]'
	// Add "satellite_used" parameter
//	ERROR	Encoding 'satellite_elevation' array of 'short' from 'uint8_t[20]'
	// Add "satellite_elevation" parameter
//	ERROR	Encoding 'satellite_azimuth' array of 'short' from 'uint8_t[20]'
	// Add "satellite_azimuth" parameter
//	ERROR	Encoding 'satellite_snr' array of 'short' from 'uint8_t[20]'
	// Add "satellite_snr" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", GPS_STATUS_satellites_visible"
 				+ ", GPS_STATUS_satellite_prn"
 				+ ", GPS_STATUS_satellite_used"
 				+ ", GPS_STATUS_satellite_elevation"
 				+ ", GPS_STATUS_satellite_azimuth"
 				+ ", GPS_STATUS_satellite_snr"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + satellites_visible
 				+ ", " + satellite_prn
 				+ ", " + satellite_used
 				+ ", " + satellite_elevation
 				+ ", " + satellite_azimuth
 				+ ", " + satellite_snr
				);
		return param;
	}
}
