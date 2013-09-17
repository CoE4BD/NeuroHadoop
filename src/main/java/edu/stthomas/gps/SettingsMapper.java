package edu.stthomas.gps;

import java.io.File;
import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.lib.input.FileSplit;

public class SettingsMapper extends
		Mapper<LongWritable, Text, NullWritable, Text> {

	static enum Parse_Counters {
		BAD_PARSE
	};

	private final Text out_value = new Text();

	private int n = 0;

	private String ratnumber;
	private String sessiondate;
	private String channelid;

	@Override
	public void setup(Context context) {

		try {
			getSessionSettings(context);
		} catch (IOException ioe) {
			System.err.println("IOException reading from distributed cache");
			System.err.println(ioe.toString());
		}
	}

	public void getSessionSettings(Context context) throws IOException {
		String fpath = ((FileSplit) context.getInputSplit()).getPath()
				.toString();
		String fname = new File(fpath).getName();

		int indexBegin = 0;
		int indexEnd = fname.indexOf('-');

		ratnumber = fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd + 1;
		indexEnd = fname.indexOf('-', indexBegin);
		sessiondate = fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd + 1;
		indexEnd = fname.indexOf('-', indexBegin);
		sessiondate = sessiondate + '-' + fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd + 1;
		indexEnd = fname.indexOf('-', indexBegin);
		sessiondate = sessiondate + '-' + fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd + 4;
		indexEnd = fname.indexOf('.', indexBegin);
		channelid = fname.substring(indexBegin, indexEnd);

	}

	@Override
	public void map(LongWritable inkey, Text value, Context context)
			throws IOException, InterruptedException {

		try {
			if (n == 0) {
				n = 1;
				out_value.set(ratnumber + "," + sessiondate + "," + channelid);
				context.write(NullWritable.get(), out_value);
			}

		} catch (IOException ioe) {
			System.err.println(ioe.getMessage());
			System.exit(0);
		}
	} // map

}
