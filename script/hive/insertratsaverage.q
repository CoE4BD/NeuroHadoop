ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='avg');
INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='avg') SELECT time, CAST(frequency AS SMALLINT), CAST ((SUM(convolution)/COUNT(convolution)) AS FLOAT) FROM rats WHERE rat='R192' AND dt='2009-11-19'  AND NOT(channel LIKE '%r%') GROUP BY time, frequency;

