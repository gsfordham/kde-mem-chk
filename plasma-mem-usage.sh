#! /bin/bash

while [ true ]; do
	clear
	is_running=`ps cax|grep plasmashell`
	if [ -z "$is_running" ]; then
		printf "Not yet restarted. Waiting...\n"
		sleep 2
		continue
	fi
	
	printf "\033[1;35m❄️❄️❄️Plasma Shell❄️❄️❄️\n"
	proc=`ps -C plasmashell -O rss`
	echo "$proc"|gawk '{ count ++; sum += $2 }; END { count --; print "\033[1;37mNumber of processes: ", count; print "\033[1;37mMemory usage per process:\n ", sum/1024/count, "MB"; print "\033[1;37mTotal memory usage:\n ", sum/1024, "MB"}'
	mem_usage=`echo "$proc"|gawk '{ sum += $2}; END { print sum/1024 }'`
	
	if [ `echo "$mem_usage < 300.0"|bc` -eq 1 ]; then
		printf "\033[1;32mMemory usage ok\n (%.3fMB)\n" $mem_usage
	elif [ `echo "$mem_usage < 650.0"|bc` -eq 1 ]; then
		printf "\033[1;33mMemory usage growing\n (%.3fMB)\n" $mem_usage
	elif [ `echo "$mem_usage < 1000.0"|bc` -eq 1 ]; then
		printf "\033[1;31mClose to exceeding threshold\n (%.3fMB)\n" $mem_usage
	else
		printf "\033[1;31m!!Plasma exceeded threshold!!\n (%.3fMB)\n Resetting Plasma!\n Please wait...\n" $mem_usage
		printf "\033[0m"
		bash restart-plasma.sh &
		echo $!
		printf "\n\033[1;35m|-----------------|\n\033[1;37m"
		for i in {1..10}; do
			printf "❄️ "
			sleep 1
		done;
		printf "\033[0m"
		printf "\n DONE\n"
	fi
	count=$((count+1))
	printf "\033[0m"
	sleep 1
done;
