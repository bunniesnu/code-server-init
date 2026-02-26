#!/bin/bash
set -e
read -p "New user name: " username
read -s -p "New user password: " password
echo
read -s -p "New user password (again): " password2
echo
if [ "$password" != "$password2" ]; then
	echo "Different..."
	exit 1
fi
useradd -m -p "$password" "$username"
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
