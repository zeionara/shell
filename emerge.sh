eeg () {
	sudo tail -f /var/log/emerge.log | awk -F ':  ' '{ printf "%s:  %s\n", strftime("%d-%m-%Y %H:%M:%S", $1), $2 }'
}

alias ega='sudo emerge --ask'
alias egl='qlist -IRv'
