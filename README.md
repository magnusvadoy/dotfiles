# Dotfiles

This is a repository to host my Mac OSX and Arch Linux dotfiles for backup purpose. 
 
To synchronize the vim plugins, cd into the directory off the git repo:

	git submodule init
	git submodue update

When you want to update all the plugins later:

	git submodule foreach git pull origin master
