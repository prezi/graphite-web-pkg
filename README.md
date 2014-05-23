graphite-web-pkg
================

Debian package built from graphite-web Git repo with virtualenv included

Also my graphite-web fork contains proxy support for the frontend (to use backends via HTTPS) and Godauth cookie generation

### Usage:

```bash
git clone http://github.com/micmac/graphite-web-pkg
cd graphite-web-pkg
scripts/graphitepkg.sh
```

You can check what's in the package using `dpkg -c`.

### Missing:

- init script / upstart / systemd / supervisor / whatever config
- proper default settings to put data/log/config directories to some sane place
