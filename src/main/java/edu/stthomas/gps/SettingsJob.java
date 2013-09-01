package edu.stthomas.gps;

import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class SettingsJob extends Configured implements Tool {

	@Override
	public int run(String[] args) throws Exception {

		System.out.println("\n\nSettingsJob\n");
		Configuration conf = new Configuration();
		conf.setBoolean("mapred.compress.map.output", true);
		conf.set("mapred.output.compression.codec",
				"org.apache.hadoop.io.compress.SnappyCodec");
		conf.set("mapred.output.compression.type", "BLOCK");
		Job job = new Job(conf);
		job.setJobName("SettingsJob");

		job.setMapperClass(SettingsMapper.class);
		List<String> other_args = new ArrayList<String>();

		job.setNumReduceTasks(0);
		// conf.setInputFormat(NonSplittableTextInputFormat.class);
		// conf.setOutputFormat(MultiFileOutput.class);
		job.setOutputKeyClass(NullWritable.class);
		job.setOutputValueClass(Text.class);

		FileInputFormat.setInputPaths(job, other_args.get(0));
		FileOutputFormat.setOutputPath(job, new Path(other_args.get(1)));

		return (job.waitForCompletion(true) ? 0 : 1);
	}

	static int printUsage() {
		System.out
				.println("SettingsJob [-m <maps>] [-r <reduces>] <input> <output>");
		ToolRunner.printGenericCommandUsage(System.out);
		return -1;
	}

	public static void main(String[] args) throws Exception {
		int exitCode = ToolRunner.run(new SettingsJob(), args);
		System.exit(exitCode);
	}

}
