#!/bin/bash
FILE="$HOME/.config/i3/current_layout"
FIRST_LAYOUT="us"
SECOND_LAYOUT="de"
function switch_layout() {
    if [[ "$1" != "" ]]
    then
        setxkbmap "$1"
        echo "$1" > "$FILE"
    # no argument is passed, read from $FILE or use $FIRST_LAYOUT and create $FILE
    elif [ -f $FILE ]
    then
        case `cat "$FILE"` in
            "$FIRST_LAYOUT" )
                layout="$SECOND_LAYOUT"
            ;;
            "$SECOND_LAYOUT" )
                layout="$FIRST_LAYOUT"
            ;;
        esac
        setxkbmap "$layout"
        echo "$layout" > $FILE
    else
        setxkbmap "$FIRST_LAYOUT"
        echo "$FIRST_LAYOUT" > $FILE
    fi
}

case $1 in
    "signal" )
        switch_layout "$2"
        pkill -RTMIN+1 i3blocks
    ;;
    "echo" )
        switch_layout "$2"
        cat $FILE
    ;;
esac
