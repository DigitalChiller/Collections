#!/bin/bash
## LICENSE
#    This file is part of Collections.
#
#    Collections is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Collections is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Collections.  If not, see <http://www.gnu.org/licenses/>.
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
