if [[ $1 == "-" ]]; then
	echo $(($(cat ~/.ssh/ssh_session_count 2> /dev/null) - 1)) > ~/.ssh/ssh_session_count
	exit 0
fi
if [[ $1 == "+" ]]; then
	echo $(($(cat ~/.ssh/ssh_session_count 2> /dev/null) + 1)) > ~/.ssh/ssh_session_count
	exit 0
fi
if [[ $1 == "get" ]]; then
	cat ~/.ssh/ssh_session_count
	exit 0
fi

echo "Invalid operator"
exit 1
