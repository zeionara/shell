#!/bin/bash

alias lls='ls -alh'

lloc () {
    locate "$1" | grep "^$HOME/"
}
