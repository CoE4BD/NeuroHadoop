DROP TABLE IF EXISTS phases;

CREATE EXTERNAL TABLE phases(time INT, phase STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/neuro/output/phase';

DROP TABLE IF EXISTS phasebuckets;
CREATE TABLE phasebuckets(time INT, phaserange INT)
LOCATION '/neuro/output/phasebuckets' 
;
INSERT OVERWRITE TABLE phasebuckets
SELECT time, CAST (FLOOR(((CAST(TRIM(phase) AS INT)  - -3141593) / (3141594 - -3141593)) * 75) + 1 AS INT) AS phaserange
FROM phases
;
