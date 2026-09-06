#!/bin/bash

# Clear the terminal screen before starting
clear

# Run watch to refresh the metrics every 1 second
watch -n 1 '
	# Extracts the idle CPU percentage from top and subtracts it from 100
	top -bn1 | grep "Cpu(s)" | awk '\''{print "CPU Usage: " 100-$8 "%"}'\''
	echo ""
	echo "MEMORY"
	free -h
'
