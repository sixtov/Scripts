//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: RALLY_POINT(175)
--------------------------------------
%%~ A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
%%~ from MAV -> GCS
--------------------------------------
*/
public class RALLY_POINT_class //implements Loggable
{
	public static final int msgID = 175;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public short	 idx;				 	// point index (first point is 0)
	public short	 count;			 	// total number of points (for sanity checking)
	public int		 lat;				 	// Latitude of point in degrees * 1E7
	public int		 lng;				 	// Longitude of point in degrees * 1E7
	public short	 alt;				 	// Transit / loiter altitude in meters relative to home
	public short	 break_alt;		 	// Break altitude in meters relative to home
	public int		 land_dir;		 	// Heading to aim for when landing. In centi-degrees.
	public short	 flags;			 	// See RALLY_FLAGS enum for definition of the bitmask.

	private packet rcvPacket;
	private packet sndPacket;

	public RALLY_POINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public RALLY_POINT_class(RALLY_POINT_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		idx = o.idx;
		count = o.count;
		lat = o.lat;
		lng = o.lng;
		alt = o.alt;
		break_alt = o.break_alt;
		land_dir = o.land_dir;
		flags = o.flags;
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

			// int[] mavLen = {1, 1, 1, 1, 4, 4, 2, 2, 2, 1};
			// int[] javLen = {2, 2, 2, 2, 4, 4, 2, 2, 4, 2};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			idx				= rcvPacket.getShortB();
			count			= rcvPacket.getShortB();
			lat				= rcvPacket.getInt();
			lng				= rcvPacket.getInt();
			alt				= rcvPacket.getShort();
			break_alt		= rcvPacket.getShort();
			land_dir			= rcvPacket.getIntS();
			flags			= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,idx
					 ,count
					 ,lat
					 ,lng
					 ,alt
					 ,break_alt
					 ,land_dir
					 ,flags
					 );
	}

	public byte[] encode(
						 short v_idx
						,short v_count
						,int v_lat
						,int v_lng
						,short v_alt
						,short v_break_alt
						,int v_land_dir
						,short v_flags
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_idx
					 ,v_count
					 ,v_lat
					 ,v_lng
					 ,v_alt
					 ,v_break_alt
					 ,v_land_dir
					 ,v_flags
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,short v_idx
						,short v_count
						,int v_lat
						,int v_lng
						,short v_alt
						,short v_break_alt
						,int v_land_dir
						,short v_flags
						)
	{
		// int[] mavLen = {1, 1, 1, 1, 4, 4, 2, 2, 2, 1};
		// int[] javLen = {2, 2, 2, 2, 4, 4, 2, 2, 4, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putByteS(v_idx);	// Add "idx" parameter
		sndPacket.putByteS(v_count);	// Add "count" parameter
		sndPacket.putInt(v_lat);	// Add "lat" parameter
		sndPacket.putInt(v_lng);	// Add "lng" parameter
		sndPacket.putShort(v_alt);	// Add "alt" parameter
		sndPacket.putShort(v_break_alt);	// Add "break_alt" parameter
		sndPacket.putShortI(v_land_dir);	// Add "land_dir" parameter
		sndPacket.putByteS(v_flags);	// Add "flags" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", RALLY_POINT_target_system"
 				+ ", RALLY_POINT_target_component"
 				+ ", RALLY_POINT_idx"
 				+ ", RALLY_POINT_count"
 				+ ", RALLY_POINT_lat"
 				+ ", RALLY_POINT_lng"
 				+ ", RALLY_POINT_alt"
 				+ ", RALLY_POINT_break_alt"
 				+ ", RALLY_POINT_land_dir"
 				+ ", RALLY_POINT_flags"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + idx
 				+ ", " + count
 				+ ", " + lat
 				+ ", " + lng
 				+ ", " + alt
 				+ ", " + break_alt
 				+ ", " + land_dir
 				+ ", " + flags
				);
		return param;
	}
}
