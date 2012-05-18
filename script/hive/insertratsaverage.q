
		ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='r1');

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='r1')
		SELECT time, frequency, POW(convolution, 2)
		FROM rats
		WHERE rat='R192'
		AND dt='2009-11-19'
		AND channel='r1'
		;
	

		ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='r1r2');

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='r1r2')
		SELECT time, frequency, POW(convolution, 2)
		FROM rats
		WHERE rat='R192'
		AND dt='2009-11-19'
		AND channel='r1r2'
		;
	

		ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='r2');

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='r2')
		SELECT time, frequency, POW(convolution, 2)
		FROM rats
		WHERE rat='R192'
		AND dt='2009-11-19'
		AND channel='r2'
		;
	

		ALTER TABLE ratsaverage ADD PARTITION(rat='R192',dt='2009-11-19',channel='avg');

		INSERT OVERWRITE TABLE ratsaverage PARTITION (rat='R192',dt='2009-11-19',channel='avg')
		SELECT time, frequency, AVG(POW(convolution, 2))
		FROM rats
		WHERE rat='R192'
		AND dt='2009-11-19'
		AND NOT(channel LIKE '%r%')
		GROUP BY time, frequency
		;
	
