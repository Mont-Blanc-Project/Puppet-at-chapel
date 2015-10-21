#!/bin/bash

sudo service auto-serial-console stop
sudo su - slurm -c "cd /opt/slurm/14.11.3/etc/scripts && if ! ps -efa | grep MemoryReliability | grep -v grep; then rm -f /opt/slurm/14.11.3/etc/scripts/pid.txt; else /apps/memory_reli/MemoryReliability -c; fi"
sudo pkill -f MemoryReliabity

sudo cpufreq-set -f 200MHz
sudo cpufreq-set -f 1.7GHz

exit 0
