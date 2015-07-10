//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: TERRAIN_REQUEST(133)
--------------------------------------
%%~ Request for terrain data and terrain status
--------------------------------------
*/
public class TERRAIN_REQUEST_class //implements Loggable
{
	public static final int msgID = 133;
	public int	 lat;			 	// Latitude of SW corner of first grid (degrees *10^7)
	public int	 lon;			 	// Longitude of SW corner of first grid (in degrees *10^7)
	public int	 grid_spacing; 	// Grid spacing in meters
	public long mask;		 	// Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits)

	private packet rcvPacket;
	private packet sndPacket;

	public TERRAIN_REQUEST_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public TERRAIN_REQUEST_class(TERRAIN_REQUEST_class o)
	{
		lat = o.lat;
		lon = o.lon;
		grid_spacing = o.grid_spacing;
		mask = o.mask;
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

			// int[] mavLen = {4, 4, 2, 8};
			// int[] javLen = {4, 4, 4, 8};

			lat			= rcvPacket.getInt();
			lon			= rcvPacket.getInt();
			grid_spacing	= rcvPacket.getIntS();
			mask			= rcvPacket.getLong();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  lat
					 ,lon
					 ,grid_spacing
					 ,mask
					 );
	}

	public byte[] encode(
						 int v_lat
						,int v_lon
						,int v_grid_spacing
						,long v_mask
						)
	{
		// int[] mavLen = {4, 4, 2, 8};
		// int[] javLen = {4, 4, 4, 8};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putInt(v_lat);	// Add "lat" parameter
		sndPacket.putInt(v_lon);	// Add "lon" parameter
		sndPacket.putShortI(v_grid_spacing);	// Add "grid_spacing" parameter
		sndPacket.putLong(v_mask);	// Add "mask" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", TERRAIN_REQUEST_lat"
 				+ ", TERRAIN_REQUEST_lon"
 				+ ", TERRAIN_REQUEST_grid_spacing"
 				+ ", TERRAIN_REQUEST_mask"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + lat
 				+ ", " + lon
 				+ ", " + grid_spacing
 				+ ", " + mask
				);
		return param;
	}
}
