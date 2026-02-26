#!/bin/bash
set -e
read -p "New user name: " username
useradd -m "$username"
passwd "$username"
usermod -aG sudo "$username"
su - "$username" -c "whoami"
read -p "Add public SSH key (paste): " sshkey
SSH_DIR="/home/$username/.ssh"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
SSH_AUTH_KEYS="$SSH_DIR/authorized_keys"
if ! grep -Fxq "$sshkey" "$SSH_AUTH_KEYS" 2>/dev/null; then
	echo "$sshkey" >> "$SSH_AUTH_KEYS"
fi
chmod 600 "$SSH_AUTH_KEYS"
chown -R $username:$username $SSH_DIR
