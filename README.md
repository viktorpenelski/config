# Shared config files

### `bash_aliases`:
To include in `~/.bashrc`:
```
BASH_ALIASES_PATH="~/.bash_aliases"
if [ -f $BASH_ALIASES_PATH ]; then
  . $BASH_ALIASES_PATH
fi
```

### `gitconfig_alias`:
To include in `~/.gitconfig`:
```
[include]
  path = PATH_TO_THIS_FILE/.gitconfig_alias
```

