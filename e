#!/bin/bash

case $EMACSCLIENT_INSTALLED in
    yes)
        if [[ -n $DISPLAY ]]; then
            emacsclient -a '' -n $@
        else
            emacsclient -a '' -nw $@
        fi
        ;;
    no)
        if [[ -n $DISPLAY ]]; then
            emacs -n $@
        else
            emacs -nw $@
        fi
        ;;
    *)
        if [[ -n $(which emacsclient) ]]; then
            export EMACSCLIENT_INSTALLED=yes
            e $@
        else
            export EMACSCLIENT_INSTALLED=no
            e $@
        fi
        ;;
esac
