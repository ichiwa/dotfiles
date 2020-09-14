# dotfiles

```shell
$ git clone git@github.com:ichiwa/dotfiles.git
$ make install
$ make setup-fish-shell
```

```shell
$ make update-fish-shell
```

Install node version and my commitizen.

```shell
$ nodenv install 12.18.3
$ nodenv rehash
$ npm install -g commitizen cz-conventional-changelog-ichiwa
$ echo '{ "path": "cz-conventional-changelog-ichiwa" }' > ~/.czrc
```
