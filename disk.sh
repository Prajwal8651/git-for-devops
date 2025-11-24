#!/bin/bash

echo "====== CPU HEALTH CHECK ======"

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU_USAGE %"

# Load Average
LOAD_AVG=$(uptime | awk -F'load average:' '{ print $2 }')
echo "Load Average (1m, 5m, 15m): $LOAD_AVG"

# CPU Temperature (Linux systems with sensors installed)
if command -v sensors &> /dev/null
then
    echo "CPU Temperature:"
    sensors | grep -i 'temp'
else
    echo "Temperature check: 'sensors' command not found. Install with: sudo apt install lm-sensors"
fi

echo "=============================="

