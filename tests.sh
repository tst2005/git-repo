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
./baseurl/key1.baseurl:http://aaaa/key1/
./origin/repo1.origin:key1/repo1.git
EOF


RESET
T ./git-repo add http://aaaa/key1/repo2.git dir2<<EOF
./baseurl/key1.baseurl:http://aaaa/key1/
./origin/dir2.origin:key1/repo2.git
EOF

RESET
./git-repo add http://aaaa/key1/repo3.git
T ./git-repo add key1/repo2.git repo2bis<<EOF
./baseurl/key1.baseurl:http://aaaa/key1/
./origin/repo2bis.origin:key1/repo2.git
./origin/repo3.origin:key1/repo3.git
EOF

RESET
./git-repo add http://aaaa/key1/repo3.git
T ./git-repo add key1/repo2.git<<EOF
./baseurl/key1.baseurl:http://aaaa/key1/
./origin/repo2.origin:key1/repo2.git
./origin/repo3.origin:key1/repo3.git
EOF

RESET
./git-repo add http://aaaa/key1/repo3.git
T ./git-repo upstream http://bbb/userB/repoB.git repo3 <<EOF
./baseurl/key1.baseurl:http://aaaa/key1/
./origin/repo3.origin:key1/repo3.git
./upstream/repo3.upstream:http://bbb/userB/repoB.git/
EOF

RESET
DEINIT
