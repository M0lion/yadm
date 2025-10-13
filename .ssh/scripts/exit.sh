# Decrement counter
$HOME/.ssh/scripts/session_counter.sh -

# Get new count
COUNT=$(cat $HOME/.ssh/ssh_session_count)

# If last session
if [ $COUNT -eq 0 ]; then
	echo "$(date) Last session, restoring config"
	# Restore old config
	mv ~/.ssh/config.backup ~/.ssh/config 2>/dev/null
	# Cleanup counter
	rm -f $COUNTER
fi
