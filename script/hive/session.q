DROP TABLE session;

CREATE EXTERNAL TABLE session(rat STRING, dt STRING, channel STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/neuro/hive/session/';

