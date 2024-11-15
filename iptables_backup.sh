#!/bin/bash

# Paths to the configuration files
IPTABLES_CONFIG="/etc/iptables/rules.v4"
IPTABLES_BACKUP_DIR="/etc/iptables/backups"
CURRENT_HASH_FILE="/etc/iptables/current_md5.hash"
BACKUP_HASH_FILE="$IPTABLES_BACKUP_DIR/backup_md5.hash"

# Ensure backup directory exists
mkdir -p "$IPTABLES_BACKUP_DIR"

# Save the current iptables configuration
sudo iptables-save > "$IPTABLES_CONFIG"

# Calculate the current MD5 hash of the iptables configuration
current_hash=$(md5sum "$IPTABLES_CONFIG" | awk '{print $1}')
echo "$current_hash" > "$CURRENT_HASH_FILE"

# Check if the backup MD5 hash file exists
if [ ! -f "$BACKUP_HASH_FILE" ]; then
    # If the backup hash file doesn't exist, create it and make an initial backup
    echo "$current_hash" > "$BACKUP_HASH_FILE"
    cp "$IPTABLES_CONFIG" "$IPTABLES_BACKUP_DIR/iptables_backup_$(date +%F_%T).v4"
    echo "Initial backup created."
else
    # Read the backup MD5 hash
    backup_hash=$(cat "$BACKUP_HASH_FILE")

    # Compare the current hash with the backup hash
    if [ "$current_hash" != "$backup_hash" ]; then
        # If the hashes are different, update the backup hash and create a new backup file
        echo "$current_hash" > "$BACKUP_HASH_FILE"
        cp "$IPTABLES_CONFIG" "$IPTABLES_BACKUP_DIR/iptables_backup_$(date +%F_%T).v4"
        echo "New backup created due to change in iptables configuration."
    else
        echo "No changes detected in iptables configuration. No new backup needed."
    fi
fi
