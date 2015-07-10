//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: MISSION_SET_CURRENT(41)
--------------------------------------
%%~ Set the mission item with sequence number seq as current item. This means that the 
%%~ MAV will continue to this mission item on the shortest path (not following the 
%%~ mission items in-between).
--------------------------------------
*/
public class MISSION_SET_CURRENT_class //implements Loggable
{
	public static final int msgID = 41;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public int		 seq;				 	// Sequence

	private packet rcvPacket;
	private packet sndPacket;

	public MISSION_SET_CURRENT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public MISSION_SET_CURRENT_class(MISSION_SET_CURRENT_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		seq = o.seq;
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

			// int[] mavLen = {1, 1, 2};
			// int[] javLen = {2, 2, 4};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			seq				= rcvPacket.getIntS();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,seq
					 );
	}

	public byte[] encode(
						 int v_seq
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_seq
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,int v_seq
						)
	{
		// int[] mavLen = {1, 1, 2};
		// int[] javLen = {2, 2, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putShortI(v_seq);	// Add "seq" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", MISSION_SET_CURRENT_target_system"
 				+ ", MISSION_SET_CURRENT_target_component"
 				+ ", MISSION_SET_CURRENT_seq"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + seq
				);
		return param;
	}
}
