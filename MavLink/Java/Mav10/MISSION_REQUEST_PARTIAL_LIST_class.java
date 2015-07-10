//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: MISSION_REQUEST_PARTIAL_LIST(37)
--------------------------------------
%%~ Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
%%~ If start and end index are the same, just 
%%~ send one waypoint.
--------------------------------------
*/
public class MISSION_REQUEST_PARTIAL_LIST_class //implements Loggable
{
	public static final int msgID = 37;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public short	 start_index;		 	// Start index, 0 by default
	public short	 end_index;		 	// End index, -1 by default (-1: send list to end). Else a valid index of the list

	private packet rcvPacket;
	private packet sndPacket;

	public MISSION_REQUEST_PARTIAL_LIST_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public MISSION_REQUEST_PARTIAL_LIST_class(MISSION_REQUEST_PARTIAL_LIST_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		start_index = o.start_index;
		end_index = o.end_index;
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

			// int[] mavLen = {1, 1, 2, 2};
			// int[] javLen = {2, 2, 2, 2};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			start_index		= rcvPacket.getShort();
			end_index		= rcvPacket.getShort();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,start_index
					 ,end_index
					 );
	}

	public byte[] encode(
						 short v_start_index
						,short v_end_index
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_start_index
					 ,v_end_index
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,short v_start_index
						,short v_end_index
						)
	{
		// int[] mavLen = {1, 1, 2, 2};
		// int[] javLen = {2, 2, 2, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putShort(v_start_index);	// Add "start_index" parameter
		sndPacket.putShort(v_end_index);	// Add "end_index" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", MISSION_REQUEST_PARTIAL_LIST_target_system"
 				+ ", MISSION_REQUEST_PARTIAL_LIST_target_component"
 				+ ", MISSION_REQUEST_PARTIAL_LIST_start_index"
 				+ ", MISSION_REQUEST_PARTIAL_LIST_end_index"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + start_index
 				+ ", " + end_index
				);
		return param;
	}
}
