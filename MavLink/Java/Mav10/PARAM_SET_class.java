//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: PARAM_SET(23)
--------------------------------------
%%~ Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
%%~ reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
%%~ to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
%%~ parameter value by sending a param_value message to all communication partners. 
%%~ This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
%%~ If the sending GCS did not receive a PARAM_VALUE message within its timeout 
%%~ time, it should re-send the PARAM_SET message.
--------------------------------------
*/
public class PARAM_SET_class //implements Loggable
{
	public static final int msgID = 23;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public byte[]	 param_id = new byte[16];			// Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
	public float	 param_value;		 	// Onboard parameter value
	public short	 param_type;		 	// Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.

	private packet rcvPacket;
	private packet sndPacket;

	public PARAM_SET_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public PARAM_SET_class(PARAM_SET_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		param_id = o.param_id;
		param_value = o.param_value;
		param_type = o.param_type;
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

			// int[] mavLen = {1, 1, 1, 4, 1};
			// int[] javLen = {2, 2, 16, 4, 2};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			rcvPacket.getByte(param_id, 0, 16);
			param_value		= rcvPacket.getFloat();
			param_type		= rcvPacket.getShortB();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,param_id
					 ,param_value
					 ,param_type
					 );
	}

	public byte[] encode(
						 byte[] v_param_id
						,float v_param_value
						,short v_param_type
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_param_id
					 ,v_param_value
					 ,v_param_type
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,byte[] v_param_id
						,float v_param_value
						,short v_param_type
						)
	{
		// int[] mavLen = {1, 1, 1, 4, 1};
		// int[] javLen = {2, 2, 16, 4, 2};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putByte(v_param_id,0,16);	// Add "param_id" parameter
		sndPacket.putFloat(v_param_value);	// Add "param_value" parameter
		sndPacket.putByteS(v_param_type);	// Add "param_type" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", PARAM_SET_target_system"
 				+ ", PARAM_SET_target_component"
 				+ ", PARAM_SET_param_id"
 				+ ", PARAM_SET_param_value"
 				+ ", PARAM_SET_param_type"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + param_id
 				+ ", " + param_value
 				+ ", " + param_type
				);
		return param;
	}
}
