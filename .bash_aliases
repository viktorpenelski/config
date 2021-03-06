alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias ll='ls -lF --color=auto'
alias la='ls -alF --color=auto'
alias ls='ls -F'

blog() {
	code "$VIK_CONFIG/../notes-md/Ideas/Blog/"
}

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

HUGO_VERSION='0.74.3'
alias hugo="docker run --rm -it \
  -v $(pwd):/src \
  -w /src/ \
  --user $(id -u):$(id -g) \
  klakegg/hugo:$HUGO_VERSION"

alias hugo-server="docker run --rm -it \
  -v $(pwd):/src \
  -w /src/ \
  -p 1313:1313 \
  --user $(id -u):$(id -g) \
  klakegg/hugo:$HUGO_VERSION \
  server"

alias hugo-shell="docker run --rm -it \
  -v $(pwd):/src \
  -w /src/ \
  klakegg/hugo:$HUGO_VERSION-alpine \
  shell"