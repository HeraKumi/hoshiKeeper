#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# reset terminal: \e[0m

__main () {
    __checkIfOnline
    __createTemp
    __menu
}


__menu () {
    SELECTION="> "
    DISTRO=""
    RESULT=""
    
    echo -e "Please choose:\n1) Distro\n2) Something\nPlease choose a option [1,2]"
    read -p "$SELECTION" selection
    case "$selection" in
        1)
            logThis -p ${FUNCNAME} "Starting distro chooser"
        ;;
        2)
            echo "some other option here"
        ;;
        3)
        ;;
        *)
            logThis -e ${FUNCNAME} "Invaild selection"
        ;;
    esac
    
    echo -e "Please choose from the list below which distro you would like to choose!\n1) Arch\n2) Deepin\n3) Quit\nPlease choose a option [1,2,3]"
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

__createTemp () { # This is incomplete!
    if [ -d "bin" ]; then
        logThis -p ${FUNCNAME} "cding into bin"
        cd bin
        elif [ ! -d "bin" ]; then
        logThis -e ${FUNCNAME} "Bin folder not found, creating bin folder"
        mkdir bin
        logThis -p ${FUNCNAME} "Bin folder created, cding into bin folder"
        cd bin
    fi
    
    if [ -f "data.json" ]; then
        logThis -p ${FUNCNAME} "found data.json, reading data..."
        
        # TODO: read values from data.json by creating a method of reading json files for bash
        
        # Here should go a if statment to read the json file line by line to check if values
        # are empty or not. then should set values
        
        # TODO: log values and create a if value is empty log that to output
        
        logThis -p ${FUNCNAME} "setting values from data.json"
        elif [ ! -f "data.json" ]; then
        logThis -e ${FUNCNAME} "data.json file doesn't exist, creating file"
        touch data.json
        logThis -p ${FUNCNAME} "data.json file created"
    fi
}

__main