#!/bin/bash

# Basic Linux Server Monitoring Script
# Author: Manoj
# Date: $(date +%Y-%m-%d)

# Output log file
LOG_FILE="/var/log/server_monitor.log"

# Ensure log file exists
touch "$LOG_FILE"

# Function to print a section header
log_section() {
    echo -e "\n=== $1 ===" | tee -a "$LOG_FILE"
}

# Function to log current date and time
log_time() {
    echo -e "\n--- $(date '+%Y-%m-%d %H:%M:%S') ---" | tee -a "$LOG_FILE"
}

# Begin monitoring
log_time

# CPU Usage
log_section "CPU USAGE"
top -b -n1 | grep "Cpu(s)" | tee -a "$LOG_FILE"

# Memory Usage
log_section "MEMORY USAGE"
free -h | tee -a "$LOG_FILE"

# Disk Usage
log_section "DISK USAGE"
df -h | tee -a "$LOG_FILE"

# Network Usage
log_section "NETWORK USAGE"
ip -brief addr | tee -a "$LOG_FILE"
ss -tuln | tee -a "$LOG_FILE"

# Uptime
log_section "UPTIME"
uptime | tee -a "$LOG_FILE"

# Optional: Check running processes
log_section "TOP 5 MEMORY-CONSUMING PROCESSES"
ps aux --sort=-%mem | head -n 6 | tee -a "$LOG_FILE"

echo "Monitoring data logged to $LOG_FILE"
