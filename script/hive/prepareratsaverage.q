SELECT DISTINCT concat(
	"
		ALTER TABLE ratsaverage ADD PARTITION(rat='", TRIM(rat), "',dt='", TRIM(dt), "',channel='avg')\;

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='", TRIM(rat), "',dt='", TRIM(dt), "',channel='avg')
		SELECT time, CAST (frequency AS SMALLINT), CAST (AVG(convolution) AS FLOAT)
		FROM rats
		WHERE rat='", rat, "'
		AND dt='", dt, "'
		AND NOT(channel LIKE '%r%')
		GROUP BY time, frequency
		\;
	"
	)
FROM session
WHERE NOT(channel LIKE '%r%')
;