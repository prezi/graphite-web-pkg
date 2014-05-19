graphite-web-pkg
================

Debian package built from graphite-web Git repo with virtualenv included

### Usage:

```bash
git clone http://github.com/micmac/graphite-web-pkg
cd graphite-web-pkg
scripts/graphitepkg.sh
```

You can check what's in the package using `dpkg -c`.

### Missing:

- init script / upstart / systemd / supervisor / whatever config
- wsgi.py for the included gunicorn
- proper default settings to put data/log directories to some sane place
