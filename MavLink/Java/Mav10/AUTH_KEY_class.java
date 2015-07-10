//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: AUTH_KEY(7)
--------------------------------------
%%~ Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
%%~ has been kept simple, so transmitting the key requires an encrypted channel 
%%~ for true safety.
--------------------------------------
*/
public class AUTH_KEY_class //implements Loggable
{
	public static final int msgID = 7;
	public byte[] key = new byte[32];		// key

	private packet rcvPacket;
	private packet sndPacket;

	public AUTH_KEY_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public AUTH_KEY_class(AUTH_KEY_class o)
	{
		key = o.key;
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

			// int[] mavLen = {1};
			// int[] javLen = {32};

			rcvPacket.getByte(key, 0, 32);
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  key
					 );
	}

	public byte[] encode(
						 byte[] v_key
						)
	{
		// int[] mavLen = {1};
		// int[] javLen = {32};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByte(v_key,0,32);	// Add "key" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", AUTH_KEY_key"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + key
				);
		return param;
	}
}
