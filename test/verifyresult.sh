hive -f test.q > temp
diff result temp
rm temp
