# Shared config files

### bootstrap:

Add in `~/.bashrc`:

```bash
VIK_CONFIG="/c/Sync/config"

if [ -f "$VIK_CONFIG/.bash_bootstrap" ]; then
  . "$VIK_CONFIG/.bash_bootstrap"
fi
```

### `gitconfig_alias`:
Add in `~/.gitconfig`:
```
[include]
  path = PATH_TO_THIS_FILE/.gitconfig_alias
```
