package edu.stthomas.gps;

/**
 * RChannel DataPoint
 * 
 * Primary function is to parse and hold the data from a line of RChannel CSV
 * data.
 * 
 * It is the main "glue code" one would need to provide to make their timeseries
 * data source work with this example.
 * 
 */
public class RatInputFormat {

	public String timestamp;
	public String voltage = String.valueOf(0);

	public short getVoltage() {
		return Short.parseShort(this.voltage);

	}

	public long getTimestamp() {
		return Long.parseLong(this.timestamp);

	}

	public static RatInputFormat parse(String csvRow) {

		RatInputFormat rec = new RatInputFormat();

		String[] values = csvRow.split(",");

		if (values.length != 2) {
			return null;
		}

		rec.timestamp = values[0].trim();
		rec.voltage = values[1].trim();

		return rec;

	}

}
