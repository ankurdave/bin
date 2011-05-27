#!/bin/bash

EMACSCLIENT_ARGS=-n
if [[ $1 == "--wait" ]]; then
    EMACSCLIENT_ARGS=''
    shift
fi

# Determine whether to use emacsclient or emacs
if [[ -z $USE_EMACSCLIENT && -n $(which emacsclient) ]]; then
    EMACSCLIENT_VERSION=$(emacsclient --version 2>&1 | head -n 1 | perl -pe 's/^emacsclient (\d+).*$/$1/')
    EMACS_VERSION=$(emacs --version | head -n 1 | perl -pe 's/^GNU Emacs (\d+).*$/$1/')
    if (( $EMACSCLIENT_VERSION >= $EMACS_VERSION )); then
        USE_EMACSCLIENT=yes
    fi
fi

case $USE_EMACSCLIENT in
    yes)
        if [[ -n $DISPLAY ]]; then
            emacsclient -a '' -c $EMACSCLIENT_ARGS $@
        else
            emacsclient -a '' -c -nw $@
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
