package edu.stthomas.gps;

import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;

import org.apache.hadoop.io.Writable;

public class RatWritable implements Writable {
	int time;
	short frequency;
	float convolution;

	public void readFields(DataInput in) throws IOException {
		time = in.readInt();
		frequency = in.readShort();
		convolution = in.readFloat();
	}

	public void write(DataOutput out) throws IOException {
		out.writeInt(time);
		out.writeShort(frequency);
		out.writeFloat(convolution);
	}

	@Override
	public String toString() {
		return time + "\t" + frequency + "\t" + convolution;
	}
}
