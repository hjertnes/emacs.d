# emacs.d

Personal Emacs configuration that manages editor settings, packages, and customizations through a literate Org document.

## Configuration Loading

- On startup, creates custom.el if it does not exist and loads it for Emacs custom variable storage
- Loads the main configuration from an Org-mode document (hjertnes.org) using org-babel, which tangles and evaluates embedded Emacs Lisp code blocks
- Loads a personal.el file for per-machine overrides, creating it if it does not exist

## Editor Behavior

- Sets the window title to a custom string
- Uses text-mode as the default major mode
- Uses spaces for indentation (no tabs), with two spaces per indent level
- Disables lock files, backup files, and auto-save
- Sets garbage collection threshold to 25% of total memory
- Sets default directory to the home directory

## Personal Information

- Stores user full name and email address for use by Emacs features (e.g., email, version control)

## Changelog

- 2026-04-18: Initial specification created from existing codebase
