//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: RALLY_FETCH_POINT(176)
--------------------------------------
%%~ Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
%%~ MAV should not respond if the request is invalid.
--------------------------------------
*/
public class RALLY_FETCH_POINT_class //implements Loggable
{
	public static final int msgID = 176;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public short	 idx;				 	// point index (first point is 0)

	private packet rcvPacket;
	private packet sndPacket;

	public RALLY_FETCH_POINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public RALLY_FETCH_POINT_class(RALLY_FETCH_POINT_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		idx = o.idx;
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

			// int[] mavLen = {1, 1, 1};
			// int[] javLen = {2, 2, 2};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			idx				= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,idx
					 );
	}

	public byte[] encode(
						 short v_idx
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_idx
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,short v_idx
						)
	{
		// int[] mavLen = {1, 1, 1};
		// int[] javLen = {2, 2, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putByteS(v_idx);	// Add "idx" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", RALLY_FETCH_POINT_target_system"
 				+ ", RALLY_FETCH_POINT_target_component"
 				+ ", RALLY_FETCH_POINT_idx"
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
				);
		return param;
	}
}
