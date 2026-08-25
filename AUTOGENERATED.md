# emacs.d

Personal GNU Emacs configuration written as a literate Org document.

## Build & Test

```bash
# No build step -- Emacs re-tangles and evaluates hjertnes.org at every startup.

make test    # fast hermetic check: evaluates only hjertnes/load-forms from init.el
             # and exercises its read-error isolation against temp files
make smoke   # full-startup smoke test (tangle + form-by-form eval); passes when
             # the output contains "hjertnes.org loaded: 0 forms failed".
             # Needs elpa/ present -- a fresh machine hits the network first.

make clean   # rm -rf elpa/, rm custom.el, then recreate empty custom.el + personal.el
make init    # just recreate empty custom.el + personal.el
```

## Architecture

Emacs Lisp, literate via Org-babel. Load order: `early-init.el` -> `init.el`, which loads `custom.el`, then tangles `hjertnes.org` to `hjertnes.el` and evaluates it **form by form** via `hjertnes/load-forms` (`init.el:28`) rather than via `org-babel-load-file` -- one bad block fails alone instead of aborting the ~60 blocks after it, and the failure count is logged as a startup sentinel. That count also covers truncation: `read` signals `end-of-file` both when the file is spent and when a paren is unbalanced, so the loader checks whether anything but whitespace and comments is left over and reports a stray paren as a failure rather than a clean finish. Each stage is additionally wrapped in `hjertnes/with-error-guard`. Finally `personal.el` is loaded.

| Path | Role |
| --- | --- |
| `early-init.el` | Pre-init: GC threshold to `most-positive-fixnum` (dropped to 16 MB on `emacs-startup-hook`), `package-enable-at-startup nil`, eln-cache redirected to `~/.emacs-eln-cache/`, toolbar/scrollbars off before the first frame |
| `init.el` | Bootstrap: create+load `custom.el`, tangle+evaluate `hjertnes.org`, create+load `personal.el` |
| `hjertnes.org` | Source of truth -- all settings and `use-package` declarations |
| `hjertnes.el` | Tangled output of `hjertnes.org` (regenerated every startup, gitignored) |
| `custom.el`, `personal.el` | Custom-var storage / per-machine overrides (auto-created empty, gitignored) |
| `snippets/` | yasnippet templates (`org-mode`, `rjsx-mode`, `sql-mode`) |
| `Makefile` | `test` (hermetic loader check) / `smoke` (full-startup sentinel grep) / `clean` / `init` |
| `tests/load-forms-test.el` | Batch test for `hjertnes/load-forms`: stray `)`, bad `#` token, unclosed paren |

Packages via `package.el` + `use-package` (`use-package-always-ensure t`); archives are GNU ELPA + MELPA over https. `use-package` is `require`d directly as an Emacs built-in -- only `smartparens` and `request` are installed imperatively before it. Completion is Ivy/Counsel/Swiper + ivy-rich (minibuffer) plus Corfu/Cape (in-buffer, `corfu-auto` with zero delay, one-char prefix; `cape-dabbrev` and `cape-file` added globally). Also Projectile (+counsel-projectile, search path `~/Code/`), Magit, undo-tree, yasnippet, avy, ace-window, which-key, multiple-cursors, crux, golden-ratio, aggressive-indent, deadgrep, restart-emacs, flycheck, rainbow-delimiters/identifiers, highlight-indent-guides, nyan-mode, emojify, and a Mastodon client (instance `https://dog.estate`). Theme: doom-themes with `doom-outrun-electric` active -- solarized-theme is installed but never loaded, and the surrounding prose still claims modus-operandi. Languages: C# via built-in `csharp-mode` + eglot, plus web/json/toml/svelte/yaml/caddyfile/taskpaper/markdown/elisp-format and org (org-journal, ox-hugo, htmlize, org-superstar).

## Key Details

- **Live checkout reached through a symlink chain.** `~/.emacs.d` -> `~/Code/emacs.d/`, and `~/Code` is itself a symlink to `~/Documents/Code`, so Emacs loads this very repo (`~/Documents/Code/emacs.d`). Edits here take effect on next launch.
- `init.el` and `hjertnes.org` hardcode absolute `~/.emacs.d/...` paths (`custom.el`, `personal.el`, `hjertnes.org`, `snippets/`); they resolve through the symlink chain, not the relative directory.
- The repo lives inside iCloud-synced `~/Documents`, which drives several choices: `init.el` deletes `hjertnes.el` before every tangle (a synced mtime would otherwise defeat the tangle cache and make config edits silently do nothing), and all generated state is pushed to unsynced siblings -- backups to `~/.emacs-backups/`, undo-tree history to `~/.emacs-undo-history/`, eln-cache to `~/.emacs-eln-cache/`.
- Requires Emacs 30.2; relies on built-ins assuming Emacs >= 29 (`use-package`, `eglot`, `csharp-mode`) and >= 27 (`early-init.el`, `tab-bar`, `pixel-scroll-precision-mode`).
- **Packages are deliberately not version-pinned** (see the "Version pinning policy" section in `hjertnes.org`). `elpa/` on disk is the de-facto snapshot; a fresh machine installs whatever the archives serve that day. `package-check-signature` is `allow-unsigned`.
- Expects the JetBrains Mono font (height 150 on macOS, 90 on Linux); if it is missing the face silently falls back.
- Lock files and classic `#auto-save#` files are disabled (`create-lockfiles nil`, `auto-save-default nil`), but **backups are on** (`hjertnes.org:60`): `make-backup-files t`, copied, versioned, 6 new / 2 old kept.
- `auto-save-visited-mode` writes the visited file every 10s, but only where `hjertnes/auto-save-visited-safe-p` allows: remote (TRAMP/sudo) files and anything under `~/Documents` or `~/Library/Mobile Documents` are excluded (compared via `file-truename`, so symlinked routes are caught too), so iCloud-synced trees never auto-save into a sync conflict. `global-auto-revert-mode` reloads on external change.
- `electric-pair-mode` is explicitly disabled in favour of global smartparens.
- `markdown-mode` shells out to `multimarkdown` for preview/export -- an external binary this repo does not install.
- Everything user-defined is namespaced `hjertnes/`. Custom keys all live in `hjertnes.org`: `M-p` projectile map, `M-o` ace-window, `<f5>` deadgrep, `C-:` avy, `M-s M-s` yasnippet, `C-c j j` org-journal (yearly files under `~/txt/notes/journal/`).
- Harmless in batch/non-GUI runs: repeated `highlight-indent-guides cannot auto set faces` errors and emojify image-download warnings.
- macOS: `exec-path-from-shell` imports `$PATH`; Command = `super`, right Option/Command disabled, native fullscreen, `ns-appearance` light. `server-mode` is enabled unconditionally (emacsclient).
- Most of the directory is Emacs runtime state (`elpa/`, `emojis/`, `transient/`, `eln-cache/`, `network-security.data`, `smex-items`) and gitignored. Two leftovers remain in the working tree: a stale `eln-cache/` from before the early-init redirect, and `racket-mode/Racket-REPL` even though racket-mode is not configured.
- `README.md` is a short historical intro and `Specification.md` a prose spec of loader/editor behavior -- the latter is stale (it claims backups and auto-save are disabled). Neither drives startup; `hjertnes.org` remains the source of truth.
