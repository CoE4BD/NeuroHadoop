SET maxphase=3141593 + 1;
SET minphase=-3141593;

DROP TABLE phases;

CREATE EXTERNAL TABLE phases(time INT, phase STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/neuro/output/phase';

DROP TABLE phasebuckets;
CREATE TABLE phasebuckets
LOCATION '/neuro/output/phasebuckets' 
AS 
SELECT time, FLOOR(((CAST(TRIM(phase) AS INT)  - ${hiveconf:minphase}) / (${hiveconf:maxphase} - ${hiveconf:minphase})) * ${hiveconf:maxphaserange}) + 1 AS phaserange
FROM phases
;

