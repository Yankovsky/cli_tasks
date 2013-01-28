#!/usr/bin/env bash

# $1 - possible -h, --help option 
main() {
	if [[ $# == 0 ]]; then
		do_work
	elif [[ $1 == -h || $1 == --help ]]; then
		show_help
	else
		invalid_usage $1
	fi
}

do_work() {
	local -a txt_files_in_current_dir=(*.txt)
	local -i files_count=${#txt_files_in_current_dir[*]}
	for i in ${!txt_files_in_current_dir[*]}
	do
		printf "%d: %s\n" $(($i+1)) ${txt_files_in_current_dir[$i]}
	done

	local file_number
	read file_number
	while [[ $file_number != q ]]; do
		if [[ $file_number =~ ^[0-9]+$ ]]; then
			if [[ $file_number < 1 || $file_number > $files_count ]]; then
				file_number_is_out_of_range $file_number
			else
				head ${txt_files_in_current_dir[file_number - 1]}
			fi
		else
			not_a_number $file_number
		fi
		read file_number
	done
	bye
}

show_help() {
	echo "Enumerates all txt files in current folder."
	echo "User then can select any file by index and view first 10 lines of it."
	echo "Available options: -h, --help		show this help"	
}

# $1 - invalid option
invalid_usage() {
	printf "1.sh: invalid option -- '%s'\n" $1
}

# $1 - requested file number
file_number_is_out_of_range() {
	printf "1.sh:  requested file number %s doesn't correspond to any file.\n" $1
	enter_valid_number
}

# $1 - requested file number
not_a_number() {
	printf "1.sh: %s is not a number\n" $1
	enter_valid_number
}

enter_valid_number() {
	echo "Please enter number of one of the files listed above."
}

bye() {
	echo bye
}

main "$@"
