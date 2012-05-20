package neurohadoop;

import java.io.DataOutput;
import java.io.DataInput;
import java.io.IOException;

import org.apache.hadoop.io.Writable;

public class RatWritable implements Writable {
  int timestamp;
  int frequency;
  float convolution;
  
  public void readFields(DataInput in) throws IOException {
	  timestamp = in.readInt();
	  frequency = in.readInt();
	  convolution = in.readFloat();
  }
  
  public void write(DataOutput out) throws IOException {
	  out.writeInt(timestamp);
	  out.writeInt(frequency);
	  out.writeFloat(convolution);
  }
}
