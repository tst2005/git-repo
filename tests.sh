export GITALL_DIRNAME=.git_repo_tests

RESET() { rm -rf -- "$GITALL_DIRNAME"; mkdir -- "$GITALL_DIRNAME"; }
INIT() { TMP1="$(mktemp)"; TMP2="$(mktemp)"; trap "rm -f -- '$TMP1' '$TMP2'" EXIT; }
DEINIT() { rmdir -- "$GITALL_DIRNAME"; }
DUMP() { ( cd -- "$GITALL_DIRNAME" && grep -rH '' .) | sort; }
T() {
	i=$(( ${i:-0} +1))
	eval "$@"
	DUMP > "$TMP1"
	{
	cat -
	} > "$TMP2"
	if diff -q -- "$TMP1" "$TMP2" |grep -q ''; then
		diff -u -- "$TMP1" "$TMP2" | tail -n +3 | grep '^[+-]\+' | tr ' '  _
		echo "-------- dump ---"
		DUMP
		echo "-----------------"
		echo >&2 "[KO] Test [$i]: $*"
	else
		echo >&2 "[OK] Test [$i]."
	fi
}

INIT

RESET
T ./git-repo add http://aaaa/key1/repo1.git <<EOF
./key1.baseurl:http://aaaa/key1/
./repo1.origin:key1/repo1.git
EOF


RESET
T ./git-repo add http://aaaa/key1/repo2.git dir2<<EOF
./dir2.origin:key1/repo2.git
./key1.baseurl:http://aaaa/key1/
EOF

RESET
./git-repo add http://aaaa/key1/repo3.git
T ./git-repo add key1/repo2.git repo2bis<<EOF
./key1.baseurl:http://aaaa/key1/
./repo2bis.origin:key1/repo2.git
./repo3.origin:key1/repo3.git
EOF

RESET
./git-repo add http://aaaa/key1/repo3.git
T ./git-repo add key1/repo2.git<<EOF
./key1.baseurl:http://aaaa/key1/
./repo2.origin:key1/repo2.git
./repo3.origin:key1/repo3.git
EOF

RESET
DEINIT
