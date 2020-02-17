# Shinobi-Installer
Ninja Way Installer for Shinobi CCTV

- Official Website : http://shinobi.video
- Documentation : http://shinobi.video/docs
- Getting Started : http://shinobi.video/docs/start
- Post-Install Tips : http://shinobi.video/docs/configure

#### How Ninja Way Works

> This script will clone a copy of Shinobi with `git`. Based on your selection of OS a script will be launched from within the `INSTALL` folder. Essentially quick-starting "The Easy Way".

- Shinobi Pro : https://gitlab.com/Shinobi-Systems/Shinobi
- Shinobi Pro (Development Branch) : https://gitlab.com/Shinobi-Systems/Shinobi/tree/dev

#### Installer Supports

- Ubuntu 18.04 or 19.10 (Recommended)
- CentOS 7
- MacOS 10.7(+)

#### Run Installer

1. Become `root` to use the installer and run Shinobi. Use one of the following to do so.

    - Ubuntu 17.10.1 and 18.04
        - `sudo su`
    - CentOS 7
        - `su`
    - MacOS 10.7(+)
        - `su`
2. Download and run the installer.

```
bash <(curl -s https://gitlab.com/Shinobi-Systems/Shinobi-Installer/raw/master/shinobi-install.sh)
```
