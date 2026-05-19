#!/usr/bin/env bash
# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-SCR-STO-001",
#   "title": "HDD Spinup Monitor",
#   "layer": 0,
#   "category": "core/storage",
#   "lastReviewed": "2026-05-19",
#   "status": "production",
#   "description": "Monitors HDD spinups by polling SMART attributes without waking the disks."
# }
# ---ENDNIXMETA

# HDD Spinup Monitor script
# This script polls SMART attributes of rotational disks.
# It uses 'smartctl -n standby' which does NOT wake up the disk if it is sleeping.

STATE_DIR="/run/hdd-spinup-monitor"
mkdir -p "$STATE_DIR"

# Find all rotational sd* devices (HDDs)
DISKS=$(lsblk -dn -o NAME,ROTA | awk '$2=="1" {print "/dev/"$1}')

if [ -z "$DISKS" ]; then
    # No HDDs found
    exit 0
fi

for DISK in $DISKS; do
    DISK_NAME=$(basename "$DISK")
    STATE_FILE="$STATE_DIR/$DISK_NAME.count"
    
    # smartctl -n standby returns 2 if disk is in standby
    # It returns 0 if disk is active/idle
    # We use -A to only show attributes (less I/O)
    OUTPUT=$(smartctl -A -n standby "$DISK" 2>/dev/null)
    EXIT_CODE=$?
    
    # Exit Code 0 = Active/Idle
    if [ $EXIT_CODE -eq 0 ]; then
        # Disk is awake. Extract Load_Cycle_Count (ID 193)
        # Format usually: 193 Load_Cycle_Count        0x0032   096   096   000   RAW_VALUE 4123
        CURRENT_COUNT=$(echo "$OUTPUT" | awk '/Load_Cycle_Count/ {print $10}')
        
        # Fallback to Power_Cycle_Count (ID 12) if Load_Cycle_Count is missing
        if [ -z "$CURRENT_COUNT" ]; then
            CURRENT_COUNT=$(echo "$OUTPUT" | awk '/Power_Cycle_Count/ {print $10}')
        fi
        
        if [ -n "$CURRENT_COUNT" ]; then
            if [ -f "$STATE_FILE" ]; then
                PREV_COUNT=$(cat "$STATE_FILE")
                if [ "$CURRENT_COUNT" -gt "$PREV_COUNT" ]; then
                    DIFF=$((CURRENT_COUNT - PREV_COUNT))
                    logger -t hdd-spinup-monitor "🚨 HDD $DISK ($DISK_NAME) aufgewacht. Zyklen-Zuwachs: $DIFF (Aktuell: $CURRENT_COUNT)"
                fi
            fi
            echo "$CURRENT_COUNT" > "$STATE_FILE"
        fi
    fi
done
