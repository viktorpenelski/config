# Shared config files

### bootstrap:

Add in `~/.bashrc`:

```
VIK_CONFIG="/c/Sync/config"

if [ -f "$VIK_CONFIG/.bash_variables" ]; then
  . "$VIK_CONFIG/.bash_variables"
fi
```

### `gitconfig_alias`:
Add in `~/.gitconfig`:
```
[include]
  path = PATH_TO_THIS_FILE/.gitconfig_alias
```
