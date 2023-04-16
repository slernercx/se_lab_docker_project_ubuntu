#!/bin/bash

echo 'Generating fake ELB logs...'
cd /Fake-ELB-Log-Generator
python3 /Fake-ELB-Log-Generator/elb-fake-log-gen.py -n 500 -o LOG 

rm -f /var/log/td-agent/elb.log
rm -f /data/logs/td-agent/elb.log
cp /Fake-ELB-Log-Generator/elasticloadbalancing_log_*.log /var/log/td-agent/elb.log
cp /Fake-ELB-Log-Generator/elasticloadbalancing_log_*.log /data/logs/elb.log

echo 'Generating fake Apache logs...'
cd /Fake-Apache-Log-Generator
python3 /Fake-Apache-Log-Generator/apache-fake-log-gen.py -n 500 -o LOG 

rm -f /var/log/td-agent/apache.log
rm -f /data/logs/td-agent/apache.log
cp /Fake-Apache-Log-Generator/http-*.log /var/log/td-agent/apache.log
cp /Fake-Apache-Log-Generator/http-*.log /data/logs/apache.log

rm -f /data/logs/td-agent/w3wp.log
rm -f /var/log/td-agent/w3wp.log
echo 'Moving w3wp log file...'
cp /data/logs/w3wp.log /var/log/td-agent/w3wp.log

rm -f /var/log/td-agent/security.cef
echo 'Moving Windows security log file...'
cp /data/logs/*.cef /var/log/td-agent/security.cef