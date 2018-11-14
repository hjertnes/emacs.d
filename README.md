# README

This is my Emacs config, I use it to write Clojure code at home, JavaScript, C# and Cucumber at work; and to blog using Hugo and Markdown. I also manage my life with Taskpaper. 

Look through the code for deatils, it is well commented. This is the basic structure of my config files:

- init.el: loads the package manager and the other files, plus GC settings for fast start and good performance in use
- pre.el sets variables and enables modes that come with emacs
- funcs.el my custom functions
- core.el loads most of my modules
- langs.el modules for languages
- csharp.el I use this one at work, it is a mess, but it works. This is why I keep in a seperate file. 

My general approach is to just add stuff that I use, and I think make the experience of using emacs better. But I only add stuff that exist as a package on a mirror. I don't add random files or anything like that. 

This configuration is a little bit more complex than I would like because it need to work on OS X, Linux and Windows.
