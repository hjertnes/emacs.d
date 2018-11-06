# emacs.d

This is the public version of my Emacs Configuration. I try to update it at least montly, it is the same as the one I use, except that sensitive information are gone. 

I only use packages that are available through a package source like elpa or melpa, because I don't want to deal with files I found on a webpage once. 

A short explaination of how my config works. Everything, with two exceptions (use-package and smartparens) are installed through use-package, and everything except use-package are loaded through use-package. This have the advantage for de-coupling everything, and dealing with dependencies in a much better way than having to "load this and then load that after that" chains.

The files, in load order
- init.el - this just sets up the package manager, installs some packages and loads use-package, and then loads the following files. 
- pre.el - this file sets configuration and enables modes that is not tied to a package that have to be installed.
- core.el - this file loads packages that are hard to define, but it is stuff like helm and and projectile. They are core to the experience of using emacs, but not really an app or a language or user interface. 
- ui.el - user interface stuff, like themes, my status line and various other stuff that is just about how stuff looks. 
- apps.el - this is stuff like deft or neotree, you know apps in emacs. 
- langs.el - programming and markup languages. 
- personal.el - use this if you want a per machine override of a setting. I ignore it in my git; typically to override fonts etc
