#!/bin/bash
COUNT=6  # executions per minute
for ((i=0; i<$COUNT; i++))
do
	pwrstat -status | awk -f pwrstat-node.awk > pwrstat.prom
	if [ $i -lt $(( $COUNT - 1 )) ]; then
		sleep $((60/$COUNT))
	fi
done
