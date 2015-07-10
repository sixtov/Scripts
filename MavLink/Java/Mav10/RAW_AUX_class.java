//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: RAW_AUX(172)
--------------------------------------
--------------------------------------
*/
public class RAW_AUX_class //implements Loggable
{
	public static final int msgID = 172;
	public int		 adc1; 	// ADC1 (J405 ADC3, LPC2148 AD0.6)
	public int		 adc2; 	// ADC2 (J405 ADC5, LPC2148 AD0.2)
	public int		 adc3; 	// ADC3 (J405 ADC6, LPC2148 AD0.1)
	public int		 adc4; 	// ADC4 (J405 ADC7, LPC2148 AD1.3)
	public int		 vbat; 	// Battery voltage
	public short	 temp; 	// Temperature (degrees celcius)
	public int		 baro; 	// Barometric pressure (hecto Pascal)

	private packet rcvPacket;
	private packet sndPacket;

	public RAW_AUX_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public RAW_AUX_class(RAW_AUX_class o)
	{
		adc1 = o.adc1;
		adc2 = o.adc2;
		adc3 = o.adc3;
		adc4 = o.adc4;
		vbat = o.vbat;
		temp = o.temp;
		baro = o.baro;
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

			// int[] mavLen = {2, 2, 2, 2, 2, 2, 4};
			// int[] javLen = {4, 4, 4, 4, 4, 2, 4};

			adc1	= rcvPacket.getIntS();
			adc2	= rcvPacket.getIntS();
			adc3	= rcvPacket.getIntS();
			adc4	= rcvPacket.getIntS();
			vbat	= rcvPacket.getIntS();
			temp	= rcvPacket.getShort();
			baro	= rcvPacket.getInt();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  adc1
					 ,adc2
					 ,adc3
					 ,adc4
					 ,vbat
					 ,temp
					 ,baro
					 );
	}

	public byte[] encode(
						 int v_adc1
						,int v_adc2
						,int v_adc3
						,int v_adc4
						,int v_vbat
						,short v_temp
						,int v_baro
						)
	{
		// int[] mavLen = {2, 2, 2, 2, 2, 2, 4};
		// int[] javLen = {4, 4, 4, 4, 4, 2, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putShortI(v_adc1);	// Add "adc1" parameter
		sndPacket.putShortI(v_adc2);	// Add "adc2" parameter
		sndPacket.putShortI(v_adc3);	// Add "adc3" parameter
		sndPacket.putShortI(v_adc4);	// Add "adc4" parameter
		sndPacket.putShortI(v_vbat);	// Add "vbat" parameter
		sndPacket.putShort(v_temp);	// Add "temp" parameter
		sndPacket.putInt(v_baro);	// Add "baro" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", RAW_AUX_adc1"
 				+ ", RAW_AUX_adc2"
 				+ ", RAW_AUX_adc3"
 				+ ", RAW_AUX_adc4"
 				+ ", RAW_AUX_vbat"
 				+ ", RAW_AUX_temp"
 				+ ", RAW_AUX_baro"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + adc1
 				+ ", " + adc2
 				+ ", " + adc3
 				+ ", " + adc4
 				+ ", " + vbat
 				+ ", " + temp
 				+ ", " + baro
				);
		return param;
	}
}
