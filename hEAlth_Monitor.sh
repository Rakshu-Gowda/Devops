#!/bin/bash

# === CONFIGURATION ===
WEBHOOK_URL="https://hooks.slack.com/services/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"  
THRESHOLD_CPU=80
THRESHOLD_MEM=80
THRESHOLD_DISK=80
HOST=$(hostname)

#  ALERT FUNCTION
   
 send_alert() {
  message=$1
  curl -X POST -H 'Content-type: application/json' --data "{
    \"text\": \"🚨 [$HOST] ALERT: $message\"
  }" $WEBHOOK_URL
}

#  CPU USAGE 
  
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)
CPU_INT=${CPU_USAGE%.*}
if [ "$CPU_INT" -gt "$THRESHOLD_CPU" ]; then
  send_alert  "High CPU Usage: $CPU_INT%"
fi

#  MEMORY USAGE 
  
MEM_TOTAL=$(free | grep Mem | awk '{print $2}')
MEM_USED=$(free | grep Mem | awk '{print $3}')
MEM_USAGE=$(echo "$MEM_USED * 100 / $MEM_TOTAL" | bc)
if [ "$MEM_USAGE" -gt "$THRESHOLD_MEM" ]; then
  send_alert "High Memory Usage: $MEM_USAGE%"
fi

#  DISK USAGE 
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
  send_alert "High Disk Usage: $DISK_USAGE%"
fi

