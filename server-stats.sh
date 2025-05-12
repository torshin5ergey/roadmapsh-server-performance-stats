#!/bin/bash
set -e


# OS version
# /etc/os-release
echo "      Server OS: $(grep -o 'PRETTY_NAME=".*"' /etc/os-release | cut -d'"' -f2)"

# Uptime
# /proc/uptime, uptime
uptime=$(cat /proc/uptime | awk '{ print int($1) }')
uptime_hours=$((uptime / 3600))
uptime_minutes=$(((uptime % 3600) / 60))
uptime_seconds=$((uptime % 60))
echo "         Uptime: ${uptime_hours}h ${uptime_minutes}m ${uptime_seconds}s"

# LA
# /proc/loadavg
echo "   Load average: $(cat /proc/loadavg | awk '{ printf "%.1f %.1f %.1f\n", $1, $2, $3 }')"

# Count logged in users
# /var/run/utmp
echo "Logged in users: $(who | wc -l)"

# CPU total usage
cat /proc/stat | grep cpu | head -1 | awk '{print ($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)}'| awk '{printf "CPU total usage: %.0f%%\n", 100-$1}'

# Mem
# /proc/meminfo, free
# Total memory usage (Free vs Used including percentage)
mem_total=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
mem_free=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')
mem_free_percentage=$((mem_free * 100 / mem_total))
mem_used=$(free | awk '/Mem/ {print $3}')
mem_used_percentage=$((mem_used * 100 / mem_total))

echo "   Memory usage:"
echo "      Total: $((mem_total/1024)) MB"
echo "       Free: $((mem_free/1024)) MB (${mem_free_percentage}%)"
echo "       Used: $((mem_used/1024)) MB (${mem_used_percentage}%)"

# Disk
# Total disk usage (Free vs Used including percentage)
# df
disk_total=$(df -B1 --output=size / | awk 'NR==2 {print $1}')
disk_free=$(df -B1 --output=avail / | awk 'NR==2 {print $1}')
disk_free_percentage=$((disk_free * 100 / disk_total))
disk_used=$(df -B1 --output=used / | awk 'NR==2 {print $1}')
disk_used_percentage=$((disk_used * 100 / disk_total))
echo "     Disk usage:"
echo "      Total: $((disk_total/1073741824)) GB"
echo "       Free: $((disk_free/1073741824)) GB (${disk_free_percentage}%)"
echo "       Used: $((disk_used/1073741824)) GB (${disk_used_percentage}%)"

# Top 5 CPU processes

# Top 5 Mem processes

# Count failed login attempts
