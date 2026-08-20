# emacs.d

Personal GNU Emacs configuration written as a literate Org document.

## Build & Test

```bash
# No build step -- Emacs tangles and evaluates hjertnes.org at every startup.

# Smoke-test that the literate config tangles and loads (run from repo root;
# succeeds when the final line is "Loaded hjertnes.el"):
emacs --batch --eval "(require 'org)" --eval "(require 'ob-tangle)" \
      --eval '(org-babel-tangle-file "hjertnes.org" "hjertnes.el" "\\`\\(?:emacs-lisp\\|elisp\\)\\'")'

# Remove elpa/ and custom.el, then recreate empty custom.el / personal.el:
make clean

# Just recreate empty custom.el / personal.el:
make init
```

## Architecture

Emacs Lisp, literate via Org-babel. Load order: `early-init.el` -> `init.el`, which loads `custom.el`, then tangles `hjertnes.org` to `hjertnes.el` with `org-babel-tangle-file` and evaluates it **form by form** via `hjertnes/load-forms` (`init.el:68-83`) rather than calling `org-babel-load-file` -- so one bad block fails alone instead of aborting the rest of the config, and the count of failed forms is logged as a sentinel. That count also covers truncation: `read` signals `end-of-file` both when the file is spent and when a paren is unbalanced, so the loader checks whether anything but whitespace and comments is left over and reports a stray paren as a failure rather than a clean finish. Then loads `personal.el`.

| Path | Role |
| --- | --- |
| `early-init.el` | Pre-init: GC threshold to `most-positive-fixnum` (dropped to 16 MB on `emacs-startup-hook`), `package-enable-at-startup nil`, toolbar/scrollbars off before the first frame |
| `init.el` | Bootstrap: create+load `custom.el`, tangle+evaluate `hjertnes.org`, create+load `personal.el` |
| `hjertnes.org` | Source of truth -- all settings and `use-package` declarations |
| `hjertnes.el` | Tangled output of `hjertnes.org` (generated, gitignored) |
| `custom.el`, `personal.el` | Custom-var storage / per-machine overrides (auto-created empty, gitignored) |
| `snippets/` | yasnippet templates (`org-mode`, `rjsx-mode`, `sql-mode`) |
| `Makefile` | `clean` / `init` helpers |

Packages via `package.el` + `use-package` (`use-package-always-ensure t`); archives are GNU ELPA + MELPA over https. `use-package` is `require`d directly as an Emacs built-in -- only `smartparens` and `request` are installed imperatively before it. Completion is Ivy/Counsel/Swiper + ivy-rich (minibuffer) plus Corfu/Cape (in-buffer, `corfu-auto` with zero delay, one-char prefix; `cape-dabbrev` and `cape-file` added globally). Also Projectile (+counsel-projectile, search path `~/Code/`), Magit, undo-tree, yasnippet, avy, ace-window, which-key, multiple-cursors, crux, golden-ratio, aggressive-indent, deadgrep, restart-emacs, flycheck, rainbow-delimiters/identifiers, highlight-indent-guides, nyan-mode, emojify, and a Mastodon client (instance `https://dog.estate`). Theme: doom-themes with `doom-outrun-electric` active (solarized-theme installed but never loaded). Languages: C# via built-in `csharp-mode` + eglot, plus web/json/toml/svelte/yaml/caddyfile/taskpaper/markdown/elisp-format and org (org-journal, ox-hugo, htmlize, org-superstar).

## Key Details

- **Live checkout reached through a symlink chain.** `~/.emacs.d` -> `~/Code/emacs.d/`, and `~/Code` is itself a symlink to `~/Documents/Code`, so Emacs loads this very repo (`~/Documents/Code/emacs.d`). Edits here take effect on next launch.
- `init.el` and `hjertnes.org` hardcode absolute `~/.emacs.d/...` paths (`custom.el`, `personal.el`, `hjertnes.org`, `snippets/`, undo-tree history); they resolve through the symlink chain, not the relative directory.
- Requires Emacs 30.2; relies on built-ins assuming Emacs >= 29 (`use-package`, `eglot`, `csharp-mode`) and >= 27 (`early-init.el`, `tab-bar`, `pixel-scroll-precision-mode`).
- Expects the JetBrains Mono font (height 150 on macOS, 90 on Linux); if it is missing the face silently falls back.
- First launch downloads packages into `elpa/`; `package-check-signature` is `allow-unsigned`.
- `custom.el` and `personal.el` are auto-created empty if missing and gitignored -- the place for machine-local settings. `hjertnes.el` is regenerated on every startup and gitignored.
- Harmless in batch/non-GUI runs: repeated `highlight-indent-guides cannot auto set faces` errors and emojify image-download warnings.
- macOS: `exec-path-from-shell` imports `$PATH`; Command = `super`, right Option/Command disabled, native fullscreen, `ns-appearance` light. `server-mode` is enabled unconditionally (emacsclient).
- Lock files and classic `#auto-save#` files are disabled (`create-lockfiles nil`, `auto-save-default nil`), but **backups are on** (`hjertnes.org:60`): `make-backup-files t`, copied into `~/.emacs-backups/`, versioned, 6 new / 2 old kept.
- `auto-save-visited-mode` writes the visited file every 10s, but only where `hjertnes/auto-save-visited-safe-p` allows: remote (TRAMP/sudo) files and anything under `~/Documents` or `~/Library/Mobile Documents` are excluded, so iCloud-synced trees are never auto-saved into a sync conflict. `global-auto-revert-mode` reloads on external change.
- `electric-pair-mode` is explicitly disabled in favour of global smartparens.
- `markdown-mode` shells out to `multimarkdown` for preview/export -- an external binary this repo does not install.
- Custom keys all live in `hjertnes.org`: `M-p` projectile map, `M-o` ace-window, `<f5>` deadgrep, `C-:` avy, `M-s M-s` yasnippet, `C-c j j` org-journal (journal files under `~/txt/notes/journal/`).
- Only `init.el`, `early-init.el`, `hjertnes.org`, `Makefile`, `README.md`, `.gitignore`, and `snippets/` are tracked; the rest of the directory is Emacs runtime state (`elpa/`, `emojis/`, `transient/`, `eln-cache/`, `network-security.data`, `smex-items`). `eln-cache/` is untracked but absent from `.gitignore`, and a stale `racket-mode/Racket-REPL` is still committed even though racket-mode is not configured.
- `README.md` is a short historical intro and `Specification.md` a prose spec of loader/editor behavior; neither drives startup -- `hjertnes.org` remains the source of truth.
