alias ega='sudo emerge --ask'

alias egd='sudo emerge --depclean'

ege () {
	sudo tail -f /var/log/emerge.log | awk -F ':  ' '{ printf "%s:  %s\n", strftime("%d-%m-%Y %H:%M:%S", $1), $2 }'
}

alias egl='qlist -IRv'
alias egs='sudo emerge --sync'
alias egw='sudo emerge -av @world'

alias uga='sudo emerge --unmerge --ask'
