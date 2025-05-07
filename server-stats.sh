#!/bin/bash

set -e

# CPU total usage

# top -bn1 | awk "/Cpu/ { print $2 }"

# LA

# Uptime

uptime=$(cat /proc/uptime | awk '{ print int($1) }')
uptime_hours=$((uptime / 3600))
uptime_minutes=$(((uptime % 3600) / 60))
uptime_seconds=$((uptime % 60))
echo "Uptime: ${uptime_hours}h ${uptime_minutes}m ${uptime_seconds}s"
