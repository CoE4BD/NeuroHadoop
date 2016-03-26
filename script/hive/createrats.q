DROP TABLE IF EXISTS rats;
DROP TABLE IF EXISTS ratsaverage;
DROP TABLE IF EXISTS tempratsaverage;

CREATE EXTERNAL TABLE rats(time INT, frequency INT, convolution FLOAT)
PARTITIONED BY (rat STRING, dt STRING, channel STRING)
STORED AS AVRO
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

CREATE TABLE tempratsaverage(time INT, frequency SMALLINT, convolution FLOAT)
PARTITIONED BY(rat STRING, dt STRING, channel STRING)
LOCATION '/neuro/output/tempratsaverage';