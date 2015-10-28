

(
	IFS="| "; while read -r a b c d; do
		case "$a" in
			"") ;;
			"#"*) ;;
			*)
				echo ./git-repo add "$b" "$a"
				[ -z "$c" ] || echo ./git-repo upstream "$c" "$a"
				[ -z "$d" ] || echo ./git-repo comment "$d" "$a"
				echo ""
		esac
	done < ../.projects.gws
)


