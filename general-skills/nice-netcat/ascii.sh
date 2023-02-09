chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%o' "$1")"
}

ascii-read() {
	local file="$1"
	local each_line
	while read each_line
	do
		chr "$each_line"
	done < "$file"
}
