#!/bin/bash

# Set the threshold for disk usage (in percentage)
threshold=90
# Get the disk usage percentage
disk_usage=$(df -h / | tail -n 1 | awk '{print $5}' | sed 's/%//')
if [ "$disk_usage" -ge "$threshold" ]; then
    echo "Disk space is running low! Disk Usage: $disk_usage%"
else
    echo "Disk space is within acceptable limits. Disk Usage: $disk_usage%"
fi