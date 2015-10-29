

rtrim() {
	local v="$1"
	while true; do
		case "$v" in
			*' ') v="${v% }" ;;
			*) printf %s "$v"; break

		esac
	done
}

./git-repo init
(
	IFS="| $(printf '\t')"; while read -r a b c d; do
		case "$a" in
			"") ;;
			"#"*) ;;
			*)
				b="$(rtrim "$b")"
				a="$(rtrim "$a")"
				./git-repo add "$b" "$a"
				#[ -z "$c" ] || echo ./git-repo upstream "$c" "$a"
				#[ -z "$d" ] || echo ./git-repo comment "$d" "$a"
				#echo ""
		esac
	done < ../.projects.gws
)


