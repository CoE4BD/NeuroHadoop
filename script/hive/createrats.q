DROP TABLE rats;
DROP TABLE ratsaverage;

ADD JAR ${hiveconf:nhhome}/lib/NeuroHadoop.jar;

CREATE EXTERNAL TABLE rats(time INT, frequency SMALLINT, convolution FLOAT)
PARTITIONED BY(rat STRING, dt STRING, channel STRING)
ROW FORMAT SERDE 'neurohadoop.RatSerde'
STORED AS SEQUENCEFILE LOCATION '/neuro/output/rats';

CREATE TABLE ratsaverage(time INT, frequency SMALLINT, convolution FLOAT)
PARTITIONED BY(rat STRING, dt STRING, channel STRING)
LOCATION '/neuro/output/ratsaverage';