package neurohadoop;

import java.util.Properties;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hive.serde2.SerDe;
import org.apache.hadoop.hive.serde.Constants;
import org.apache.hadoop.hive.serde2.SerDeException;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.StructObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.hive.serde2.io.ShortWritable;

import org.apache.hadoop.io.Writable;

public class RatSerde implements SerDe {

	//private static final Log LOG = LogFactory.getLog(RatSerde.class.getName());
	StructObjectInspector rowOI;
	ArrayList<Object> row;

	List<String> columnNames;
	List<ObjectInspector> columnOIs;

	@Override
	public void initialize(Configuration conf, Properties props)
			throws SerDeException {
		//LOG.debug("Initializing RatSerde");
		columnOIs = new ArrayList<ObjectInspector>(3);
		row = new ArrayList<Object>(3);
		row.add(null);
		row.add(null);
		row.add(null);
		columnOIs
				.add(PrimitiveObjectInspectorFactory.writableIntObjectInspector);
		columnOIs
				.add(PrimitiveObjectInspectorFactory.writableShortObjectInspector);
		columnOIs
				.add(PrimitiveObjectInspectorFactory.writableFloatObjectInspector);
		String columnNameProperty = props.getProperty(Constants.LIST_COLUMNS);
		columnNames = Arrays.asList(columnNameProperty.split(","));
		rowOI = ObjectInspectorFactory.getStandardStructObjectInspector(
				columnNames, columnOIs);
	}

	@Override
	public ObjectInspector getObjectInspector() throws SerDeException {
		return rowOI;
	}

	@Override
	public Object deserialize(Writable blob) throws SerDeException {

		RatWritable rw = (RatWritable) blob;
		//LOG.debug("Deserialize row: " + rw.toString());

		row.set(0, new IntWritable(rw.time));
		row.set(1, new ShortWritable(rw.frequency));
		row.set(2, new FloatWritable(rw.convolution));

		return row;
	}

	@Override
	public Class<? extends Writable> getSerializedClass() {
		return null;
		// serialization not supported
	}

	@Override
	public Writable serialize(Object arg0, ObjectInspector arg1)
			throws SerDeException {
		return null;
		// serialization not supported
	}

}