#!/bin/bash

EMACSCLIENT_ARGS=-n
if [[ $1 == "--wait" ]]; then
    EMACSCLIENT_ARGS=''
    shift
fi

if [[ -z $EMACSCLIENT_INSTALLED && -n $(which emacsclient) ]]; then
    EMACSCLIENT_INSTALLED=yes
fi

case $EMACSCLIENT_INSTALLED in
    yes)
        if [[ -n $DISPLAY ]]; then
            emacsclient -a '' -c $EMACSCLIENT_ARGS $@
        else
            emacsclient -a '' -c -nw $EMACSCLIENT_ARGS $@
        fi
        ;;
    *)
        if [[ -n $DISPLAY ]]; then
            emacs -n $@
        else
            emacs -nw $@
        fi
        ;;
esac
