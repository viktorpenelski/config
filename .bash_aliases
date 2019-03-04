alias ll="ls -alF"
alias ls='ls --color=auto'

port-pid() {
	port=$1

	if [ "$port" == "" ]; then
		echo "Please specify port!"
		return
	fi

	lookFor=":$port "

	pid=$(netstat -ano | grep $lookFor | awk '{print $5}' | head -1)


	if [ "$pid" == "" ]; then
		echo "No process found for port: $port!"
		return
	fi

	echo "$pid" > /dev/clipboard
	echo "processID for port $port: $pid"
	echo "pid copied to clipboard!"
}

mcb() {
	mvn clean install
}
 
alias gcb="./gradlew clean build"

lsrec() {
	cmd="find . -type f -exec ls -lt {} +"

	default=20
	help="Finds all files recursively in nested directories and lists the first ${default} ordered by last modified.
	Use -all to show ALL files, or x to show the last x files
	for example: lsrec 3 will show the three most recently modified files."

	#TODO(vic) test if it is more convinient to keep $default or to show -all by default
	if [ "$1" == "" ]; then
		cmd+=" | head -n ${default}"
	elif [ "$1" == "-all" ]; then
		cmd+=""
	elif [ "$1" -eq "$1" ]; then
		cmd+=" | head -n ${1}"
	else
		echo $help;
		return;
	fi

	eval "$cmd"
}

# WINDOWS SPECIFIC
# TODO(vic) consider moving to another file.

open() {
	explorer.exe .
}

