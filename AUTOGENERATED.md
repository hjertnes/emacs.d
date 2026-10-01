# emacs.d

Personal GNU Emacs configuration written as a literate Org document.

## Build & Test

```bash
# No build step -- init.el re-tangles and evaluates hjertnes.org at every startup.
# Targets are anchored to the Makefile's own directory, so `make -f` works from anywhere.

make test    # three hermetic batch scripts -- built-ins only, no packages, no network:
             #   tests/load-forms-test.el   stray `)`, bad `#` token, unclosed paren, and a
             #                              failed tangle leaving the old hjertnes.el intact
             #   tests/calc-eval-test.el    hjertnes/calc-eval-region: bad input -> user-error
             #   tests/state-dirs-test.el   early-init.el state paths resolve outside ~/Documents
make smoke   # full startup (early-init.el, then init.el); passes when the output contains
             # "hjertnes.org loaded: 0 forms failed". Offline only while ~/.emacs-packages/ is
             # populated. grep hides the warnings; emacs --batch -l early-init.el -l init.el shows them.
make init    # touch custom.el and personal.el (init.el also creates them when missing)

# No `clean` target, deliberately: the old one deleted custom.el and the package snapshot.
```

## Architecture

Emacs Lisp, literate via Org-babel: `hjertnes.org` holds 71 `emacs-lisp` blocks with 42 `use-package` declarations. Load order: `early-init.el` -> `init.el`. `init.el` loads `custom.el`, tangles `hjertnes.org` into `hjertnes.el` and evaluates that form by form, then loads `personal.el` last for per-machine overrides. Each stage runs inside `hjertnes/with-error-guard` (`init.el:5`), so a failed stage becomes a `*Warnings*` entry and later stages still run.

Two hand-rolled steps replace `org-babel-load-file`:

- `hjertnes/tangle-config` (`init.el:109`) tangles the `emacs-lisp`/`elisp` blocks to a temp file and renames it over `hjertnes.el`. It errors if the source is unreadable or the tangle comes out empty. The previous `hjertnes.el` survives on disk, but the error aborts the whole stage: that session loads nothing from `hjertnes.org` and prints no sentinel.
- `hjertnes/load-forms` (`init.el:28`) reads and evaluates (lexically) one top-level form at a time, so a failing form costs only itself and is logged with its line number. An unreadable token costs the rest of its line. An unclosed paren is caught by checking for non-comment text left after `end-of-file`. The failure count is echoed as the sentinel `hjertnes.org loaded: N forms failed`.

| Path | Role |
| --- | --- |
| `early-init.el` | GC threshold `most-positive-fixnum` until `emacs-startup-hook` (then 16 MB), `package-enable-at-startup nil`, package/state/eln-cache relocation, toolbar and scrollbars off before the first frame |
| `init.el` | Bootstrap: `custom.el`, tangle + evaluate `hjertnes.org`, `personal.el` |
| `hjertnes.org` | Source of truth -- all settings, `hjertnes/` helpers and packages |
| `hjertnes.el` | Tangled output, rewritten every startup (gitignored) |
| `custom.el`, `personal.el` | Customize storage / per-machine overrides, auto-created empty (gitignored) |
| `snippets/` | yasnippet templates: `org-mode` (mostly ox-hugo export properties; dates via `hjertnes/get-datestring` + `get-timestring`), `rjsx-mode`, `sql-mode` |
| `tests/` | The three `make test` scripts |

Packages come from `package.el` + `use-package` (`use-package-always-ensure t`), archives GNU ELPA + MELPA over https. `use-package` is `require`d as a built-in; only `smartparens` and `request` are installed imperatively. Completion is Ivy/Counsel/Swiper + ivy-rich in the minibuffer and Corfu/Cape in-buffer (`corfu-auto`, zero delay, one-char prefix; `cape-dabbrev`, `cape-file`). Also Projectile (+counsel-projectile, search path `~/Code/`), Magit, undo-tree, yasnippet, avy, ace-window, golden-ratio, global aggressive-indent, which-key, multiple-cursors, crux, deadgrep, restart-emacs, rainbow-delimiters/identifiers, highlight-indent-guides, nyan-mode, emojify, and a Mastodon client (`https://dog.estate`). Theme: doom-themes' `doom-outrun-electric`. Languages: C# via built-in `csharp-mode` + `eglot-ensure`; web, json, toml, svelte, yaml, caddyfile, taskpaper and markdown modes; elisp-format; org with org-journal, ox-hugo, htmlize, org-superstar.

## Key Details

- **Live checkout via symlink:** `~/.emacs.d` -> `~/Code/emacs.d/`, so edits take effect on next launch. `~/Code` is a plain directory holding independent git repositories; there is no parent build.
- `init.el` and `hjertnes.org` hardcode `~/.emacs.d/...` paths (`custom.el`, `personal.el`, `hjertnes.org`, `hjertnes.el`, `snippets/`). So in another clone or worktree, `make smoke` runs that clone's `init.el` but still tangles and loads `~/.emacs.d/hjertnes.org`. `make test` reads its inputs relative to `tests/` and finds each subject by its `defun` name -- renaming `hjertnes/load-forms`, `hjertnes/tangle-config` or `hjertnes/calc-eval-region` breaks it.
- **Top-level `setq` of a buffer-local variable does nothing in `hjertnes.org`:** `hjertnes/load-forms` evaluates with its temp buffer current, and that buffer is then discarded. The Settings section's `default-directory`, `tab-width` and `indent-tabs-mode` setqs have no effect -- defaults stay `indent-tabs-mode t`, `tab-width 8`. The same form's `js-indent-level 2` does apply. Only `setq-default` sets a default.
- **`make smoke` passes with broken packages:** `use-package`'s default `:catch` turns an error inside a declaration into an `Error (use-package): <pkg>/:<keyword>` warning without signalling, so it never counts toward the sentinel. A batch startup on this machine currently logs:
  - doom-themes: `Face inheritance results in inheritance cycle: gnus-group-news-low`. This aborts `load-theme`, so `custom-enabled-themes` stays nil and the visual-bell/org configs after it never run.
  - emojify, mastodon, magit and multiple-cursors: not loaded, because native-comp trampolines fail to compile (`clang: error: invalid version number in '-mmacosx-version-min=18.0'`).
  - `highlight-indent-guides cannot auto set faces`: batch-only noise.
- **yasnippet is off at startup:** its `:bind` makes `use-package` defer it. `yas-global-mode 1` in `:config` runs -- and snippet keys start expanding on TAB -- only once `M-s M-s`, `C-c y`, `C-c p` or `C-c n` loads it. org-journal (`:bind`), deadgrep (`:bind`), markdown-mode (`:mode`) and ox-hugo (`:after ox`) are deferred as well.
- Generated state is redirected out of the repo. `early-init.el` sends packages to `~/.emacs-packages/` (`package-user-dir`), transient files and emojify images to `~/.emacs-state/`, and the eln-cache to `~/.emacs-eln-cache/`. `hjertnes.org` sends backups to `~/.emacs-backups/`, `#file#` auto-saves to `~/.emacs-autosave/` and undo-tree history to `~/.emacs-undo-history/`. Anything else still defaults into `~/.emacs.d/`, i.e. this repo (`auto-save-list/`, `network-security.data`, `smex-items`), and is gitignored.
- The repo lived in iCloud-synced `~/Documents` until 2026-09-01. Comments in `early-init.el`, `init.el`, `Makefile` (which still calls the snapshot `elpa/`), `tests/` and `hjertnes.org` (backups, pinning policy, undo) still describe it as synced. `early-init.el` also says `package-initialize` runs in `init.el`; it runs in `hjertnes.org`. `tests/state-dirs-test.el` checks only the `early-init.el` paths, and only against `~/Documents`, so it would not catch state landing back inside this repo.
- **Packages are deliberately not version-pinned** ("Version pinning policy" in `hjertnes.org`). `~/.emacs-packages/` is the de-facto snapshot. A fresh machine installs whatever the archives serve that day, and the documented recovery is copying that directory from a working machine. `package-check-signature` is `allow-unsigned`.
- Nothing asserts a version, but the floor is Emacs 29: `use-package` is `require`d and never installed, and built-in `eglot`, `csharp-mode`, `pixel-scroll-precision-mode` and `auto-save-visited-predicate` all arrived in 29.1. `which-key` is built in only from 30 (below that, `:ensure` installs it). This machine runs a GNU Emacs 31.1 development build (NS port, `/Applications/Emacs.app`, also the `emacs` that `make` runs).
- Lock files are off; backups (copied, versioned, 6 new / 2 old) and classic `#file#` auto-save are on (`hjertnes.org:64`). `auto-save-visited-mode` also writes visited files every 10s, gated by `hjertnes/auto-save-visited-safe-p` (`hjertnes.org:109`). It skips remote (TRAMP/sudo) files and anything whose `file-truename` is under `~/Documents` or `~/Library/Mobile Documents`. This repo is under neither now, so its files are auto-saved too. `global-auto-revert-mode` picks up external changes. `crux-reopen-as-root-mode` reopens files that are neither writable nor owned by the user as root via TRAMP `sudo`.
- Everything user-defined is namespaced `hjertnes/`. Custom keys live only in `hjertnes.org`:
  - counsel/swiper take `M-x`, `C-s`, `C-x C-f` and `C-x C-b`.
  - `M-p` projectile map, `M-o` ace-window, `<f5>` deadgrep, `C-:`/`C-M-:` avy, `M-s M-s` yasnippet.
  - `C-c j j` org-journal (yearly files in `~/txt/notes/journal/`), `C-c C-c` recompile in C#.
  - `M-p` sits in a global minor-mode map, so it outranks `M-p` history in the minibuffer (ivy's too) and comint.
- `server-mode` is on unconditionally, `make smoke`'s batch process included. `electric-pair-mode` is off in favour of global smartparens. External programs the repo does not install: `rg` (deadgrep), `multimarkdown` (`markdown-command`) and `omnisharp`/`OmniSharp` or `csharp-ls` (eglot in C# buffers). Only `rg` is on PATH on this machine.
- macOS: `exec-path-from-shell` imports `PATH`/`MANPATH` from the user's shell; Command is `super`, right Option/Command are `none`; native fullscreen; light `ns-appearance`. Font: JetBrains Mono, height 150 on macOS, 90 on Linux.
- Drift and dead weight:
  - `ivy-count-format` is `"(%d/d)"` (missing `%`), so ivy prompts show `(COUNT/d)` with no index.
  - `solarized-theme` and `flycheck` are `require`d but never enabled (eglot reports through Flymake). The config never calls `request`, though `hjertnes.org`'s prose says interactive functions do.
  - That prose also calls the theme modus-operandi and claims to install `use-package` and `org-plus-contrib`. Its `** Markdown` heading is empty; the `markdown-mode` block sits under `** Magit`.
  - `snippets/rjsx-mode/` targets a mode nothing installs, and `snippets/org-mode/daily` emits `roam:` links without org-roam.
  - `README.md` is a historical intro (Clojure, Cucumber) and `Specification.md` is stale (it says backups and auto-save are off). Neither drives startup.
