//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: PARAM_MAP_RC(50)
--------------------------------------
%%~ Bind a RC channel to a parameter. The parameter should change accoding to the RC 
%%~ channel value.
--------------------------------------
*/
public class PARAM_MAP_RC_class //implements Loggable
{
	public static final int msgID = 50;
	public short	 target_system;				 	// System ID
	public short	 target_component;			 	// Component ID
	public byte[]	 param_id = new byte[16];						// Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
	public short	 param_index;					 	// Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored), send -2 to disable any existing map for this rc_channel_index.
	public short	 parameter_rc_channel_index;	 	// Index of parameter RC channel. Not equal to the RC channel id. Typically correpsonds to a potentiometer-knob on the RC.
	public float	 param_value0;				 	// Initial parameter value
	public float	 scale;						 	// Scale, maps the RC range [-1, 1] to a parameter value
	public float	 param_value_min;				 	// Minimum param value. The protocol does not define if this overwrites an onboard minimum value. (Depends on implementation)
	public float	 param_value_max;				 	// Maximum param value. The protocol does not define if this overwrites an onboard maximum value. (Depends on implementation)

	private packet rcvPacket;
	private packet sndPacket;

	public PARAM_MAP_RC_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public PARAM_MAP_RC_class(PARAM_MAP_RC_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		param_id = o.param_id;
		param_index = o.param_index;
		parameter_rc_channel_index = o.parameter_rc_channel_index;
		param_value0 = o.param_value0;
		scale = o.scale;
		param_value_min = o.param_value_min;
		param_value_max = o.param_value_max;
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

			// int[] mavLen = {1, 1, 1, 2, 1, 4, 4, 4, 4};
			// int[] javLen = {2, 2, 16, 2, 2, 4, 4, 4, 4};

			target_system				= rcvPacket.getShortB();
			target_component				= rcvPacket.getShortB();
			rcvPacket.getByte(param_id, 0, 16);
			param_index					= rcvPacket.getShort();
			parameter_rc_channel_index	= rcvPacket.getShortB();
			param_value0					= rcvPacket.getFloat();
			scale						= rcvPacket.getFloat();
			param_value_min				= rcvPacket.getFloat();
			param_value_max				= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,param_id
					 ,param_index
					 ,parameter_rc_channel_index
					 ,param_value0
					 ,scale
					 ,param_value_min
					 ,param_value_max
					 );
	}

	public byte[] encode(
						 byte[] v_param_id
						,short v_param_index
						,short v_parameter_rc_channel_index
						,float v_param_value0
						,float v_scale
						,float v_param_value_min
						,float v_param_value_max
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_param_id
					 ,v_param_index
					 ,v_parameter_rc_channel_index
					 ,v_param_value0
					 ,v_scale
					 ,v_param_value_min
					 ,v_param_value_max
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,byte[] v_param_id
						,short v_param_index
						,short v_parameter_rc_channel_index
						,float v_param_value0
						,float v_scale
						,float v_param_value_min
						,float v_param_value_max
						)
	{
		// int[] mavLen = {1, 1, 1, 2, 1, 4, 4, 4, 4};
		// int[] javLen = {2, 2, 16, 2, 2, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putByte(v_param_id,0,16);	// Add "param_id" parameter
		sndPacket.putShort(v_param_index);	// Add "param_index" parameter
		sndPacket.putByteS(v_parameter_rc_channel_index);	// Add "parameter_rc_channel_index" parameter
		sndPacket.putFloat(v_param_value0);	// Add "param_value0" parameter
		sndPacket.putFloat(v_scale);	// Add "scale" parameter
		sndPacket.putFloat(v_param_value_min);	// Add "param_value_min" parameter
		sndPacket.putFloat(v_param_value_max);	// Add "param_value_max" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", PARAM_MAP_RC_target_system"
 				+ ", PARAM_MAP_RC_target_component"
 				+ ", PARAM_MAP_RC_param_id"
 				+ ", PARAM_MAP_RC_param_index"
 				+ ", PARAM_MAP_RC_parameter_rc_channel_index"
 				+ ", PARAM_MAP_RC_param_value0"
 				+ ", PARAM_MAP_RC_scale"
 				+ ", PARAM_MAP_RC_param_value_min"
 				+ ", PARAM_MAP_RC_param_value_max"
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
 				+ ", " + param_index
 				+ ", " + parameter_rc_channel_index
 				+ ", " + param_value0
 				+ ", " + scale
 				+ ", " + param_value_min
 				+ ", " + param_value_max
				);
		return param;
	}
}
