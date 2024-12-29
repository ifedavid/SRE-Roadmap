#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}')

total_mem_usage=$(free -m | grep Mem | awk '{print $3/$2 * 100.0 "%"}')
total_mem_free=$(free -m | grep Mem | awk '{print $4/$2 * 100.0 "%"}')

disk_usage=$(df -m | awk '{total += $2} {used += $3} END {print "% disk used = " used/total * 100.0 "%, ", "% disk free = " (total - used)/total * 100.0 "%"}')

top_5_cpu_processes=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6)
top_5_mem_processes=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6)

echo "Current CPU Usage: $cpu_usage"

echo "Memoy usage is: $total_mem_usage, free memory is $total_mem_free"

echo "Disk usage: $disk_usage"

echo "Top 5 CPU consuming processes: $top_5_cpu_processes"
echo "Top 5 Memory consuming processes: $top_5_mem_processes"

The script above fetches the CPU usage, memory usage, disk usage and the top 5 CPU and memory consuming processes.
To run the script, save it in a file named server-performance-stats.sh and run the following command:
chmod +x server-performance-stats.sh
