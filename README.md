# Dotfiles

Dotfiles for Neovim, Fish, Alacritty and other CLI tools I use.

![Screenshot](screenshot.png)

Here's a quick set of commands you can run to get it ready on a fresh machine.

```
mkdir ~/bin
curl -fLo ~/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
chmod a+x ~/bin/yadm
~/bin/yadm clone --bootstrap https://github.com/magnusvadoy/dotfiles.git
rm -rf ~/bin/yadm
```
