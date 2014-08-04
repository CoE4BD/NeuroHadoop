DROP TABLE rats;
DROP TABLE ratsaverage;

CREATE EXTERNAL TABLE rats(time INT, frequency INT, convolution FLOAT)
PARTITIONED BY (rat STRING, dt STRING, channel STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe' 
STORED AS
INPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
LOCATION '/neuro/output/rats'
TBLPROPERTIES (
        'avro.schema.literal'='{
	"namespace": "edu.stthomas.gps",
 	"type": "record",
 	"name": "Rat",
 	"fields": [
     	{"name": "time", "type": "int"},
     	{"name": "frequency",  "type": "int"},
     	{"name": "convolution", "type": "float"}
 	]
	}'
);

CREATE TABLE ratsaverage(time INT, frequency SMALLINT, convolution FLOAT)
PARTITIONED BY(rat STRING, dt STRING, channel STRING)
LOCATION '/neuro/output/ratsaverage';

