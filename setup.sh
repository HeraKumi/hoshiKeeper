#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# reset terminal: \e[0m

__main () {
    __checkIfOnline
    
    case "$item" in
        "arch")
            logThis -p ${FUNCNAME} "Arch found"
            __archLinux
        ;;
        
        "deepin")
            logThis -p ${FUNCNAME} "Deepin found"
            __deepinLinux
        ;;
        *)
            logThis -e ${FUNCNAME} "OS cannot be found."
            exit 1
        ;;
    esac
    
    
}

__archLinux () {
    logThis -p ${FUNCNAME} "Setting mirrorlist"
    sudo reflector --verbose --country 'united states' -l 5 --sort rate --save /etc/pacman.d/mirrorlist
    
    logThis -p ${FUNCNAME} "Updating system"
    sudo pacman -Syuu
    
    logThis -p ${FUNCNAME} "Installing [git, curl, wget]"
    sudo pacman -S git curl wget
    
}

__deepinLinux () {
    
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

logThis () {
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