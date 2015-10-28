
For now it only support to add and list

```
$ ./git-repo add https://github.com/tst2005/git-repo
$ ./git-repo list git-repo
git-repo/            https://github.com/tst2005/git-repo
```

It automatically split the URL in 2 parts : `scheme://hostname.tld/key/the/suffix/...`
 * `scheme://hostname.tld/key/`
 * `key/the/suffix/...`


It will be possible to register the baseurl (`scheme://hostname.tld/key/`) as a special keyword (by default it will be `key`.

advanced use:
```
$ ./git-repo baseurl ssh://git@github.com/tst2005 @me
$ ./git-repo add @me/git-repo git-repo-over-ssh
$ ./git-repo list git-repo-over-ssh
git-repo-over-ssh/   ssh://git@github.com/tst2005/git-repo
```



Similar project
===============

* [gws](https://github.com/StreakyCobra/gws)
* [mgit](https://github.com/capr/multigit)


