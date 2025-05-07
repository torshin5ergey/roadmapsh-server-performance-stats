#!/bin/bash
set -e


# OS version

echo "      Server OS: $(grep -o 'PRETTY_NAME=".*"' /etc/os-release | cut -d'"' -f2)"

# Uptime

uptime=$(cat /proc/uptime | awk '{ print int($1) }')
uptime_hours=$((uptime / 3600))
uptime_minutes=$(((uptime % 3600) / 60))
uptime_seconds=$((uptime % 60))
echo "         Uptime: ${uptime_hours}h ${uptime_minutes}m ${uptime_seconds}s"

# LA

echo "   Load average: $(cat /proc/loadavg | awk '{ printf "%.1f %.1f %.1f\n", $1, $2, $3 }')"

# Count logged in users

# CPU total usage

cat /proc/stat | grep cpu | head -1 | awk '{print ($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)}'| awk '{printf "CPU total usage: %.0f%%\n", 100-$1}'

# Mem

# Disk

# Top 5 CPU processes

# Top 5 Mem processes

# Count failed login attempts
