# Shinobi-Installer
Installer script for downloading and installing Shinobi CCTV on Linux or MacOS.

#### Installer Supports

- Ubuntu 17.04, 17.10
- CentOS 7
- MacOS 10.7(+)

#### Run Installer

1. Become `root` to use the installer and run Shinobi. Use one of the following to do so.

    - Ubuntu 17.04, 17.10
        - `sudo su`
    - CentOS 7
        - `su`
    - MacOS 10.7(+)
        - `su`
2. Download and run the installer.

```
curl -sL https://raw.githubusercontent.com/ShinobiCCTV/Shinobi-Installer/master/shinobi-install.sh | sudo -E bash -
```