SSHD_PID=$1
LOCKFILE=$2

echo "$(date): Background monitor started for SSHD $SSHD_PID, PID: $$"

# Wait for ssh to exit
while kill -0 $SSHD_PID 2>/dev/null; do 
    sleep 1
done

echo "$(date) SSHD $SSHD_PID exited, running exit.sh"

# Perform exit with lock
flock $LOCKFILE $HOME/.ssh/scripts/exit.sh
