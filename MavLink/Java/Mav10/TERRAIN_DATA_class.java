//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: TERRAIN_DATA(134)
--------------------------------------
%%~ Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon 
%%~ from a TERRAIN_REQUEST
--------------------------------------
*/
public class TERRAIN_DATA_class //implements Loggable
{
	public static final int msgID = 134;
	public int		 lat;			 	// Latitude of SW corner of first grid (degrees *10^7)
	public int		 lon;			 	// Longitude of SW corner of first grid (in degrees *10^7)
	public int		 grid_spacing; 	// Grid spacing in meters
	public short	 gridbit;		 	// bit within the terrain request mask
	public short[]	 data = new short[32];			// Terrain data in meters AMSL

	private packet rcvPacket;
	private packet sndPacket;

	public TERRAIN_DATA_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public TERRAIN_DATA_class(TERRAIN_DATA_class o)
	{
		lat = o.lat;
		lon = o.lon;
		grid_spacing = o.grid_spacing;
		gridbit = o.gridbit;
		data = o.data;
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

			// int[] mavLen = {4, 4, 2, 1, 2};
			// int[] javLen = {4, 4, 4, 2, 32};

			lat			= rcvPacket.getInt();
			lon			= rcvPacket.getInt();
			grid_spacing	= rcvPacket.getIntS();
			gridbit		= rcvPacket.getShortB();
			rcvPacket.getByte(data, 0, 32);
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  lat
					 ,lon
					 ,grid_spacing
					 ,gridbit
					 ,data
					 );
	}

	public byte[] encode(
						 int v_lat
						,int v_lon
						,int v_grid_spacing
						,short v_gridbit
						,short[] v_data
						)
	{
		// int[] mavLen = {4, 4, 2, 1, 2};
		// int[] javLen = {4, 4, 4, 2, 32};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putInt(v_lat);	// Add "lat" parameter
		sndPacket.putInt(v_lon);	// Add "lon" parameter
		sndPacket.putShortI(v_grid_spacing);	// Add "grid_spacing" parameter
		sndPacket.putByteS(v_gridbit);	// Add "gridbit" parameter
		sndPacket.putByte(v_data,0,32);	// Add "data" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", TERRAIN_DATA_lat"
 				+ ", TERRAIN_DATA_lon"
 				+ ", TERRAIN_DATA_grid_spacing"
 				+ ", TERRAIN_DATA_gridbit"
 				+ ", TERRAIN_DATA_data"
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
 				+ ", " + gridbit
 				+ ", " + data
				);
		return param;
	}
}
