#!/usr/bin/env bash

# $1 - file name
main() {
	if [[ $# == 0 ]]; then
		echo "2.sh: pass file name as a command param."		
	else
		sed -e '1i\<html><body>' \
		    -e 's/&/\&amp/;s/"/\&quot/;s/'\''/\&apos/;s/</\&lt/;s/>/\&gt/' \
		    -e '/^Part/! s/$/<br>/' \
		    -e 's/\(^Part.*\)/<H2>\1<\/H2>/' \
		    -e '$a </body></html>' $1
	fi
}

main "$@"
