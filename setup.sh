#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# reset terminal: \e[0m

__main () {
    __checkIfOnline
    __menu
}

__menu () {
    
    SELECTION="> "
    DISTRO=""
    RESULT=""
    
    echo -e "Please choose from the list below which distro you would like to choose!"
    echo -e "1) Arch\n2) Deepin\n3) Quit\n"
    echo -e "Please choose a option [1,2,3]"
    
    read -p "$SELECTION" distro
    case "$distro" in
        1)
            RESULT="Arch"
        ;;
        2)
            RESULT="Deepin"
        ;;
        3)
            exit 1
        ;;
        *)
            logThis -e ${FUNCNAME} "Please choose again!"
            __main
        ;;
    esac
    
    DISTRO=$RESULT
    DISTRO_CHOOSEN="set '$DISTRO' as main distro"
    
    logThis -p ${FUNCNAME} "$DISTRO_CHOOSEN"
}

__checkIfOnline () {
    _ONLINE=0
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        _ONLINE=1
    else
        _ONLINE=0
    fi
    
    if [ $_ONLINE == 1 ]; then
        logThis -p ${FUNCNAME} "connected to the internet"
        
        elif [ $_ONLINE == 0 ]; then
        logThis -e ${FUNCNAME} "Please make a connection to the internet"
        exit 1
    fi
    
}

# VARI__="\e[0m"  Reset all
logThis (){
    
    VARI__=""
    
    case "$1" in
        "-p")
            VARI__="\e[92mGOOD\e[0m"
        ;;
        "-e")
            VARI__="\e[91mFAIL\e[0m"
        ;;
        *)
            echo "Please choose a option"
        ;;
    esac
    
    echo -e "[$VARI__] [$2]: $3"
}

__main