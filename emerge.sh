alias ega='sudo emerge --ask'

alias egd='sudo emerge --depclean'

ege () {
	sudo tail -f /var/log/emerge.log | awk -F ':  ' '{ printf "%s:  %s\n", strftime("%d-%m-%Y %H:%M:%S", $1), $2 }'
}

alias egl='qlist -IRv'

alias ego="sudo emerge --oneshot"
alias egop="sudo emerge --oneshot portage"

alias egs='sudo emerge --sync'
alias egu='sudo emerge --ask --verbose --update --deep --newuse @world'
alias egw='sudo emerge -av @world'

alias uga='sudo emerge --unmerge --ask'
