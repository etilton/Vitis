# Vitis

Overlay for playing Roblox on Gentoo.

## Contents

~ [grapejuice](https://gitlab.com/brinkervii/grapejuice): A Wine+Roblox management application

## Adding the overlay

First, install git if not already:
```
# emerge --ask --verbose dev-vcs/git
```
Then, create a file called Vitis.conf in /etc/portage/repos.conf/ as such:
```
[Vitis]
location = /var/db/repos/Vitis
sync-type = git
sync-uri = https://github.com/etilton/Vitis.git
clone-depth = 1
sync-depth = 1
auto-sync = yes
```
