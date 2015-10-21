#!/bin/bash

SLURM_BIN=/opt/slurm/14.11.3/bin/

EXIT=0
if [ x$SLURM_UID = "x" -a $EXIT -eq 0 ] ; then 
	EXIT=1
fi
if [ x$SLURM_JOB_ID = "x" -a $EXIT -eq 0 ] ; then 
    EXIT=1
fi

#
# Don't try to kill user root or system daemon jobs
#
if [ $SLURM_UID -lt 100 -a $EXIT -eq 0 ] ; then
	EXIT=1
fi

job_list=`${SLURM_BIN}squeue --noheader --format=%A --user=$SLURM_UID --node=localhost`
for job_id in $job_list
do
	if [ $job_id -ne $SLURM_JOB_ID -a $EXIT -eq 0 ] ; then
		EXIT=1
	fi
done

#
# No other SLURM jobs, purge all remaining processes of this user
#
if [ $EXIT -eq 0 ]
then
	pkill -KILL -U $SLURM_UID
fi

# Memory Reliability daemon
cd /opt/slurm/14.11.3/etc/scripts
sudo su - slurm -c "cd /opt/slurm/14.11.3/etc/scripts && /apps/memory_reli/MemoryReliability -d -m 3000 -s 0 -o /apps/memory_reli/logs/$(hostname).log -wn 20 -wf /apps/memory_reli/warnings/$(hostname).warn"
sudo chown slurm.slurm /opt/slurm/14.11.3/etc/scripts/pid.txt
sudo renice -n 19 -p $(cat /opt/slurm/14.11.3/etc/scripts/pid.txt)

sudo cpufreq-set -g userspace
sudo cpufreq-set -f 200MHz

sudo service auto-serial-console start

sudo /usr/bin/pkill -KILL lttng

# Apply puppet if needed
if [ -f /tmp/puppet-apply ] && [ -x /usr/local/bin/ninjaPuppet ]; then
	/usr/local/bin/ninjaPuppet epilog &
	disown
fi

exit 0
