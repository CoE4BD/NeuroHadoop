hive -f test.q > temp
echo "Difference:"
diff result temp
rm temp
