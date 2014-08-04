package edu.stthomas.gps;

import java.io.IOException;

import org.apache.avro.mapreduce.AvroJob;
import org.apache.avro.mapreduce.AvroKeyOutputFormat;
import org.apache.avro.mapreduce.AvroMultipleOutputs;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.filecache.DistributedCache;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.LazyOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

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

	void cacheKernel(Job job) throws IOException {
		Path hdfsPath = new Path(HDFS_KERNEL);
		DistributedCache.addCacheFile(hdfsPath.toUri(), job.getConfiguration());
	}

	@Override
	public int run(String[] args) throws Exception {
		
		Configuration conf = getConf();
		conf.setBoolean("mapreduce.map.output.compress", true);
		conf.set("mapreduce.output.fileoutputformat.compress.codec",
				 "org.apache.hadoop.io.compress.SnappyCodec");
		conf.set("mapred.output.compression.type", "BLOCK");
		Job job = Job.getInstance(conf);
		job.setJobName("ConvolutionJob");
		job.setJarByClass(ConvolutionJob.class);

		this.cacheKernel(job);
		job.setMapperClass(ConvolutionMapper.class);
		job.setNumReduceTasks(0);
		job.setInputFormatClass(NonSplittableTextInputFormat.class);

		LazyOutputFormat.setOutputFormatClass(job, TextOutputFormat.class);
		AvroJob.setOutputKeySchema(job, Rat.SCHEMA$);
		AvroMultipleOutputs.addNamedOutput(job, "AVRO", AvroKeyOutputFormat.class, Rat.SCHEMA$);
		AvroMultipleOutputs.setCountersEnabled(job, true);
		FileInputFormat.setInputPaths(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));

		return (job.waitForCompletion(true) ? 0 : 1);
	}

	public static void main(String[] args) throws Exception {
		int exitCode = ToolRunner.run(new ConvolutionJob(), args);
		System.exit(exitCode);
	}

}
