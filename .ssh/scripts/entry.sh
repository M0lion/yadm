# Increment counter
$HOME/.ssh/scripts/session_counter.sh +

# Get new count
COUNT=$(cat $HOME/.ssh/ssh_session_count)

# If first session
if [ $COUNT -eq 1 ]; then
	echo "$(date): First session, creating tmp config"
	# Copy to backup
	cp ~/.ssh/config ~/.ssh/config.backup 2>/dev/null
	# Change to remote config
	sed -i 's|IdentityAgent ~/.1password/agent.sock|IdentityAgent SSH_AUTH_SOCK|g' ~/.ssh/config
fi
