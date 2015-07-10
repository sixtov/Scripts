//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: BATTERY_STATUS(147)
--------------------------------------
%%~ Transmitte battery informations for a accu pack.
--------------------------------------
*/
public class BATTERY_STATUS_class //implements Loggable
{
	public static final int msgID = 147;
	public short	 accu_id;				 	// Accupack ID
	public int		 voltage_cell_1;		 	// Battery voltage of cell 1, in millivolts (1 = 1 millivolt)
	public int		 voltage_cell_2;		 	// Battery voltage of cell 2, in millivolts (1 = 1 millivolt), -1: no cell
	public int		 voltage_cell_3;		 	// Battery voltage of cell 3, in millivolts (1 = 1 millivolt), -1: no cell
	public int		 voltage_cell_4;		 	// Battery voltage of cell 4, in millivolts (1 = 1 millivolt), -1: no cell
	public int		 voltage_cell_5;		 	// Battery voltage of cell 5, in millivolts (1 = 1 millivolt), -1: no cell
	public int		 voltage_cell_6;		 	// Battery voltage of cell 6, in millivolts (1 = 1 millivolt), -1: no cell
	public short	 current_battery;		 	// Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
	public int		 current_consumed;	 	// Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
	public int		 energy_consumed;		 	// Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
	public byte	 battery_remaining;	 	// Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery

	private packet rcvPacket;
	private packet sndPacket;

	public BATTERY_STATUS_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public BATTERY_STATUS_class(BATTERY_STATUS_class o)
	{
		accu_id = o.accu_id;
		voltage_cell_1 = o.voltage_cell_1;
		voltage_cell_2 = o.voltage_cell_2;
		voltage_cell_3 = o.voltage_cell_3;
		voltage_cell_4 = o.voltage_cell_4;
		voltage_cell_5 = o.voltage_cell_5;
		voltage_cell_6 = o.voltage_cell_6;
		current_battery = o.current_battery;
		current_consumed = o.current_consumed;
		energy_consumed = o.energy_consumed;
		battery_remaining = o.battery_remaining;
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

			// int[] mavLen = {1, 2, 2, 2, 2, 2, 2, 2, 4, 4, 1};
			// int[] javLen = {2, 4, 4, 4, 4, 4, 4, 2, 4, 4, 1};

			accu_id				= rcvPacket.getShortB();
			voltage_cell_1		= rcvPacket.getIntS();
			voltage_cell_2		= rcvPacket.getIntS();
			voltage_cell_3		= rcvPacket.getIntS();
			voltage_cell_4		= rcvPacket.getIntS();
			voltage_cell_5		= rcvPacket.getIntS();
			voltage_cell_6		= rcvPacket.getIntS();
			current_battery		= rcvPacket.getShort();
			current_consumed		= rcvPacket.getInt();
			energy_consumed		= rcvPacket.getInt();
			battery_remaining	= rcvPacket.getByte();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  accu_id
					 ,voltage_cell_1
					 ,voltage_cell_2
					 ,voltage_cell_3
					 ,voltage_cell_4
					 ,voltage_cell_5
					 ,voltage_cell_6
					 ,current_battery
					 ,current_consumed
					 ,energy_consumed
					 ,battery_remaining
					 );
	}

	public byte[] encode(
						 short v_accu_id
						,int v_voltage_cell_1
						,int v_voltage_cell_2
						,int v_voltage_cell_3
						,int v_voltage_cell_4
						,int v_voltage_cell_5
						,int v_voltage_cell_6
						,short v_current_battery
						,int v_current_consumed
						,int v_energy_consumed
						,byte v_battery_remaining
						)
	{
		// int[] mavLen = {1, 2, 2, 2, 2, 2, 2, 2, 4, 4, 1};
		// int[] javLen = {2, 4, 4, 4, 4, 4, 4, 2, 4, 4, 1};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_accu_id);	// Add "accu_id" parameter
		sndPacket.putShortI(v_voltage_cell_1);	// Add "voltage_cell_1" parameter
		sndPacket.putShortI(v_voltage_cell_2);	// Add "voltage_cell_2" parameter
		sndPacket.putShortI(v_voltage_cell_3);	// Add "voltage_cell_3" parameter
		sndPacket.putShortI(v_voltage_cell_4);	// Add "voltage_cell_4" parameter
		sndPacket.putShortI(v_voltage_cell_5);	// Add "voltage_cell_5" parameter
		sndPacket.putShortI(v_voltage_cell_6);	// Add "voltage_cell_6" parameter
		sndPacket.putShort(v_current_battery);	// Add "current_battery" parameter
		sndPacket.putInt(v_current_consumed);	// Add "current_consumed" parameter
		sndPacket.putInt(v_energy_consumed);	// Add "energy_consumed" parameter
		sndPacket.putByte(v_battery_remaining);	// Add "battery_remaining" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", BATTERY_STATUS_accu_id"
 				+ ", BATTERY_STATUS_voltage_cell_1"
 				+ ", BATTERY_STATUS_voltage_cell_2"
 				+ ", BATTERY_STATUS_voltage_cell_3"
 				+ ", BATTERY_STATUS_voltage_cell_4"
 				+ ", BATTERY_STATUS_voltage_cell_5"
 				+ ", BATTERY_STATUS_voltage_cell_6"
 				+ ", BATTERY_STATUS_current_battery"
 				+ ", BATTERY_STATUS_current_consumed"
 				+ ", BATTERY_STATUS_energy_consumed"
 				+ ", BATTERY_STATUS_battery_remaining"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + accu_id
 				+ ", " + voltage_cell_1
 				+ ", " + voltage_cell_2
 				+ ", " + voltage_cell_3
 				+ ", " + voltage_cell_4
 				+ ", " + voltage_cell_5
 				+ ", " + voltage_cell_6
 				+ ", " + current_battery
 				+ ", " + current_consumed
 				+ ", " + energy_consumed
 				+ ", " + battery_remaining
				);
		return param;
	}
}
