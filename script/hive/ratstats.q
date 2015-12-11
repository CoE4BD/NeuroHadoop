	DROP TABLE ratstats;
	CREATE TABLE ratstats(rat STRING, dt STRING, channel STRING, frequency INT, mean FLOAT, sd FLOAT)
	LOCATION '/neuro/output/ratstats'
	;

	INSERT OVERWRITE TABLE ratstats 
	SELECT rat, dt, channel, frequency, CAST (AVG(convolution) AS FLOAT) AS mean, CAST (STDDEV_POP(convolution) AS FLOAT) AS sd
	FROM ratsaverage
	GROUP BY rat, dt, channel, frequency
	;
