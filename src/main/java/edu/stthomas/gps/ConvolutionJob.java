package edu.stthomas.gps;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.filecache.DistributedCache;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.SequenceFileOutputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.output.MultipleOutputs;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

import edu.stthomas.gps.ConvolutionMapper;
import edu.stthomas.gps.NonSplittableTextInputFormat;

/**
 * 
 * ConvolutionJob
 * 
 * This is the main job class of the Map Reduce job.
 * 
 * From here we wire together the Map, Reduce, Partition, and Writable classes.
 * 
 */

public class ConvolutionJob extends Configured implements Tool {
	static final String HDFS_KERNEL = "/neuro/lookup/morlet-2000.dat";

	void cacheKernel(Configuration conf) throws IOException {
		Path hdfsPath = new Path(HDFS_KERNEL);
		DistributedCache.addCacheFile(hdfsPath.toUri(), conf);
	}

	@Override
	public int run(String[] args) throws Exception {

		System.out.println("\n\nConvolutionJob\n");
		Configuration conf = new Configuration();
		conf.setBoolean("mapred.compress.map.output", true);
		conf.set("mapred.output.compression.codec",
				"org.apache.hadoop.io.compress.SnappyCodec");
		conf.set("mapred.output.compression.type", "BLOCK");
		Job job = new Job(conf);
		job.setJobName("ConvolutionJob");

		this.cacheKernel(conf);
		job.setMapperClass(ConvolutionMapper.class);
		List<String> other_args = new ArrayList<String>();

		job.setNumReduceTasks(0);
		job.setInputFormatClass(NonSplittableTextInputFormat.class);

		FileInputFormat.setInputPaths(job, other_args.get(0));
		FileOutputFormat.setOutputPath(job, new Path(other_args.get(1)));

		MultipleOutputs.addNamedOutput(job, "seq",
				SequenceFileOutputFormat.class, NullWritable.class,
				RatWritable.class);

		return (job.waitForCompletion(true) ? 0 : 1);

	}

	static int printUsage() {
		System.out
				.println("ConvolutionJob [-m <maps>] [-r <reduces>] <input> <output>");
		ToolRunner.printGenericCommandUsage(System.out);
		return -1;
	}

	public static void main(String[] args) throws Exception {
		int exitCode = ToolRunner.run(new ConvolutionJob(), args);
		System.exit(exitCode);
	}

}
