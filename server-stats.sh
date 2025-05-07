#!/bin/bash

set -e

# OS version

echo "Server OS: $(grep -o 'PRETTY_NAME=".*"' /etc/os-release | cut -d'"' -f2)"

# Uptime

uptime=$(cat /proc/uptime | awk '{ print int($1) }')
uptime_hours=$((uptime / 3600))
uptime_minutes=$(((uptime % 3600) / 60))
uptime_seconds=$((uptime % 60))
echo "   Uptime: ${uptime_hours}h ${uptime_minutes}m ${uptime_seconds}s"

# LA

# Count logged in users

# CPU total usage

# Mem

# Disk

# Top 5 CPU processes

# Top 5 Mem processes

# Count failed login attempts
