# 📊 Server Performance Stats Project for [roadmap.sh](https://roadmap.sh/)

This is my solution to the [Server Performance Stats project](https://roadmap.sh/projects/server-stats) in the [DevOps roadmap](https://roadmap.sh/devops) from [roadmap.sh](https://roadmap.sh/)

**Table of Contents**
- [Project Requirements](#project-requirements)
- [Prerequisites](#prerequisites)
- [How To Use](#how-to-use)
- [Script Description](#script-description)
  - [OS Version](#os-version)
  - [Uptime](#uptime)
  - [Load Average (LA)](#load-average-la)
  - [Logged users](#logged-users)
  - [Failed Login Attempts](#failed-login-attempts)
  - [CPU Usage](#cpu-usage)
  - [Memory Usage](#memory-usage)
  - [Disk Usage](#disk-usage)
  - [Top Processes](#top-processes)
- [Author](#author)

## Project Requirements

- [x] Write a script `server-stats.sh` that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:
- [x] Total CPU usage
- [x] Total memory usage (Free vs Used including percentage)
- [x] Total disk usage (Free vs Used including percentage)
- [x] Top 5 processes by CPU usage
- [x] Top 5 processes by memory usage
- [x] **Advanced**. Add more stats such as os version, uptime, load average, logged in users, failed login attempts etc

## Prerequisites

- Linux OS (Ubuntu Server 22.04)

## How To Use

0. Clone the repository
```bash
git clone https://github.com/torshin5ergey/roadmapsh-server-performance-stats
cd roadmapsh-server-performance-stats
```
1. Ensure the `server-stats.sh` script is executable
```bash
chmod +x server-stats.sh
```
2. Run the script
```bash
./server-stats.sh
```
- Output Example
```
      Server OS: Ubuntu 22.04.5 LTS
         Uptime: 5h 52m 12s
   Load average: 3,0 2,0 2,0
Logged in users: 2
  Failed logins: 1
CPU total usage: 9%
=== Memory usage ===
  Total: 15662 MB
   Free: 4231 MB (27%)
   Used: 11431 MB (73%)
=== Disk usage ===
  Total: 98 GB
   Free: 74 GB (75%)
   Used: 24 GB (25%)
=== Top 5 CPU processes ===
    PID USER     %CPU %MEM COMMAND
   6159 user     29.1  5.1 firefox-bin
 191054 user     11.7  1.7 Isolated Web Co
  40322 user      9.1  3.1 code
   2867 mysql     8.8  0.1 mysqld
   3164 redis     7.4  1.9 redis-server
=== Top 5 Memory processes ===
    PID USER     %MEM %CPU COMMAND
   6159 user      5.1 29.1 firefox-bin
  12182 user      3.7  1.0 telegram-deskto
   2867 mysql     8.8  0.1 mysqld
   3164 redis     7.4  1.9 redis-server
   6402 user      3.2  0.3 Isolated Web Co
```

## Script Description

### OS Version

Parse `/etc/os-release` to identify the Linux distribution
```bash
grep -o 'PRETTY_NAME=".*"' /etc/os-release | cut -d'"' -f2
```

### Uptime

Read `/proc/uptime` and convert seconds to human-readable format
```bash
uptime=$(cat /proc/uptime | awk '{ print int($1) }')
```

### Load Average (LA)
Parse `/proc/loadavg` and extract 1/5/15 LA
```bash
cat /proc/loadavg | awk '{ printf "%.1f %.1f %.1f\n", $1, $2, $3 }'
```

### Logged users

Count active sessions with `who`
```bash
who | wc -l
```

### Failed Login Attempts

Parse `/var/log/auth.log` for SSH failures
```bash
grep "Failed password" /var/log/auth.log | wc -l
```

### CPU Usage

Calculate CPU total usage from `/proc/stat`
```bash
cat /proc/stat | grep cpu | head -1 | awk '{print ($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)}'
```

### Memory Usage

Parse `/proc/meminfo` for memory tracking
```bash
mem_total=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
mem_free=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')
```

### Disk Usage

Use `df` to get `/` patition usage
```bash
df -B1 --output=size / | awk 'NR==2 {print $1}'
```

### Top Processes

Use `ps` with `--sort` to get top processes by resource
```bash
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6
```

## Author

Sergey Torshin [@torshin5ergey](https://github.com/torshin5ergey)
