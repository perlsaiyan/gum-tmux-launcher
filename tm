#!/bin/bash

if ! command -v tmux &> /dev/null
then
        echo "Could not find tmux.  Please install."
        exit 1
fi

if [[ ! -z "${TMUX}" ]];
then
        echo "Don't run this from inside a tmux session."
        exit 1
fi


if [ $# == 0 ]; then
    # no arguments, let's build a list
    SESSES=$(tmux ls | wc -l)
    if [ ${SESSES} -eq 0 ]; then
        tmux
    else
            LAUNCH=$((echo "new session:" && tmux ls) | cut -d: -f1 | gum choose)
        if [ $? -ne 0 ]; then
                exit
        elif [ "${LAUNCH}" == "new session" ]; then
            tmux
        else
            tmux attach -t "${LAUNCH}"
        fi
    fi
else
        tmux $@
fi


