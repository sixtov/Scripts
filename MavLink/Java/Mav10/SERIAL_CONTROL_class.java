//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SERIAL_CONTROL(126)
--------------------------------------
%%~ Control a serial port. This can be used for raw access to an onboard serial peripheral 
%%~ such as a GPS or telemetry radio. It is designed to make it possible to update 
%%~ the devices firmware via MAVLink messages or change the devices settings. 
%%~ A message with zero bytes can be used to change just the baudrate.
--------------------------------------
*/
public class SERIAL_CONTROL_class //implements Loggable
{
	public static final int msgID = 126;
	public short	 device;	 	// See SERIAL_CONTROL_DEV enum
	public short	 flags;	 	// See SERIAL_CONTROL_FLAG enum
	public int		 timeout;	 	// Timeout for reply data in milliseconds
	public long	 baudrate; 	// Baudrate of transfer. Zero means no change.
	public short	 count;	 	// how many bytes in this transfer
	public short[]	 data = new short[140];		// serial data

	private packet rcvPacket;
	private packet sndPacket;

	public SERIAL_CONTROL_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public SERIAL_CONTROL_class(SERIAL_CONTROL_class o)
	{
		device = o.device;
		flags = o.flags;
		timeout = o.timeout;
		baudrate = o.baudrate;
		count = o.count;
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

			// int[] mavLen = {1, 1, 2, 4, 1, 1};
			// int[] javLen = {2, 2, 4, 8, 2, 140};

			device	= rcvPacket.getShortB();
			flags	= rcvPacket.getShortB();
			timeout	= rcvPacket.getIntS();
			baudrate	= rcvPacket.getLongI();
			count	= rcvPacket.getShortB();
//	ERROR	Parsing 'data' array of 'short' from 'uint8_t[70]'
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  device
					 ,flags
					 ,timeout
					 ,baudrate
					 ,count
					 ,data
					 );
	}

	public byte[] encode(
						 short v_device
						,short v_flags
						,int v_timeout
						,long v_baudrate
						,short v_count
						,short[] v_data
						)
	{
		// int[] mavLen = {1, 1, 2, 4, 1, 1};
		// int[] javLen = {2, 2, 4, 8, 2, 140};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_device);	// Add "device" parameter
		sndPacket.putByteS(v_flags);	// Add "flags" parameter
		sndPacket.putShortI(v_timeout);	// Add "timeout" parameter
		sndPacket.putIntL(v_baudrate);	// Add "baudrate" parameter
		sndPacket.putByteS(v_count);	// Add "count" parameter
//	ERROR	Encoding 'data' array of 'short' from 'uint8_t[70]'
	// Add "data" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SERIAL_CONTROL_device"
 				+ ", SERIAL_CONTROL_flags"
 				+ ", SERIAL_CONTROL_timeout"
 				+ ", SERIAL_CONTROL_baudrate"
 				+ ", SERIAL_CONTROL_count"
 				+ ", SERIAL_CONTROL_data"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + device
 				+ ", " + flags
 				+ ", " + timeout
 				+ ", " + baudrate
 				+ ", " + count
 				+ ", " + data
				);
		return param;
	}
}
