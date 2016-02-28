/home/elastic/elasticsearch-2.1.1/bin/elasticsearch -d -p /home/elastic/pid --conf.path /home/elastic/elasticsearch-2.1.1/config
sudo /home/elastic/kibana-4.3.1-linux-x64/bin/kibana
kill -9 $(cat /home/elastic/pid)
