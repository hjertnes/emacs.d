# emacs.d

Personal GNU Emacs configuration written as a literate Org document.

## Build & Test

```bash
# No build step -- Emacs re-tangles and evaluates hjertnes.org at every startup.

make test    # fast hermetic check: reads init.el, evaluates only the
             # hjertnes/load-forms defun, and feeds it the three read-failure
             # shapes against temp files. No packages, no network.
make smoke   # full-startup check (tangle + form-by-form eval); passes only when
             # the output contains "hjertnes.org loaded: 0 forms failed".
             # Needs elpa/ present -- a fresh machine hits the network first.

make clean   # rm -rf elpa/, rm custom.el, then recreate empty custom.el + personal.el
make init    # just recreate empty custom.el + personal.el
```

## Architecture

Emacs Lisp, literate via Org-babel. Load order: `early-init.el` -> `init.el`, which loads `custom.el`, deletes and re-tangles `hjertnes.org` into `hjertnes.el`, evaluates that **form by form** via `hjertnes/load-forms` (`init.el:28`), and finally loads `personal.el`. Every stage is wrapped in `hjertnes/with-error-guard`, so a failed stage logs a warning to `*Warnings*` instead of leaving Emacs silently half-configured.

`hjertnes/load-forms` replaces `org-babel-load-file` because `load` treats a file as one unit: the first form that signals aborts the ~70 blocks after it, silently. Reading and evaluating one form at a time contains the damage and names the offender. An unreadable token (stray `)`, bad `#`) costs one skipped line, not the rest of the file. Truncation is detected separately -- `read` signals `end-of-file` both for a spent buffer and for an unclosed paren, so the loader checks whether anything but whitespace and `;` comments is left over and reports a stray paren as a failure. The failure count is echoed as a startup sentinel.

| Path | Role |
| --- | --- |
| `early-init.el` | Pre-init: GC threshold to `most-positive-fixnum` (16 MB on `emacs-startup-hook`), `package-enable-at-startup nil`, eln-cache redirected to `~/.emacs-eln-cache/`, toolbar/scrollbars off before the first frame |
| `init.el` | Bootstrap: create+load `custom.el`, tangle+evaluate `hjertnes.org`, create+load `personal.el` |
| `hjertnes.org` | Source of truth -- all settings and `use-package` declarations |
| `hjertnes.el` | Tangled output (deleted and regenerated every startup, gitignored) |
| `custom.el`, `personal.el` | Custom-var storage / per-machine overrides (auto-created empty, gitignored) |
| `snippets/` | yasnippet templates (`org-mode`, `rjsx-mode`, `sql-mode`) |
| `tests/load-forms-test.el` | Batch test for `hjertnes/load-forms`: stray `)`, bad `#` token, unclosed paren |

Packages via `package.el` + `use-package` (`use-package-always-ensure t`); archives are GNU ELPA + MELPA over https. `use-package` is `require`d as a built-in -- only `smartparens` and `request` are installed imperatively before it. Completion is Ivy/Counsel/Swiper + ivy-rich (minibuffer) plus Corfu/Cape (in-buffer, `corfu-auto` with zero delay, one-char prefix; `cape-dabbrev` and `cape-file` global). Also Projectile (+counsel-projectile, search path `~/Code/`), Magit, undo-tree, yasnippet, avy, ace-window, which-key, multiple-cursors, crux, golden-ratio, aggressive-indent, deadgrep, restart-emacs, flycheck, rainbow-delimiters/identifiers, highlight-indent-guides, nyan-mode, emojify, and a Mastodon client (instance `https://dog.estate`). Theme is doom-themes with `doom-outrun-electric` loaded -- solarized-theme is installed but never loaded, and the prose above the block still claims modus-operandi. Languages: C# via built-in `csharp-mode` + eglot, plus web/json/toml/svelte/yaml/caddyfile/taskpaper/markdown/elisp-format and org (org-journal, ox-hugo, htmlize, org-superstar).

## Key Details

- **Live checkout reached through a symlink chain.** `~/.emacs.d` -> `~/Code/emacs.d/`, and `~/Code` is itself a symlink to `~/Documents/Code`, so Emacs loads this very repo. Edits here take effect on next launch. The surrounding `~/Documents/Code` is a flat collection of independent git repositories, not a monorepo -- there is no parent build.
- `init.el` and `hjertnes.org` hardcode absolute `~/.emacs.d/...` paths (`custom.el`, `personal.el`, `hjertnes.org`, `snippets/`); they resolve through that symlink chain, not the relative directory.
- The repo lives inside iCloud-synced `~/Documents`, which drives several choices: `hjertnes.el` is deleted before every tangle (a synced mtime would otherwise defeat the tangle cache and make config edits silently do nothing), and generated state is pushed to unsynced siblings -- backups to `~/.emacs-backups/`, undo-tree history to `~/.emacs-undo-history/`, eln-cache to `~/.emacs-eln-cache/`.
- iCloud also drops `" 2"` conflict copies into the tree; `.gitignore` lists `hjertnes.el` by exact name, so a byte-identical `hjertnes 2.el` shows up as untracked noise rather than being ignored.
- Requires Emacs 30.2. Built-ins are relied on rather than installed: `use-package`, `eglot`, `csharp-mode` (>= 29), `which-key` (30, hence absent from `elpa/`), `early-init.el`, `tab-bar`, `pixel-scroll-precision-mode` (>= 27).
- **Packages are deliberately not version-pinned** (see "Version pinning policy" in `hjertnes.org`). `elpa/` on disk is the de-facto snapshot; a fresh machine installs whatever the archives serve that day. `package-check-signature` is `allow-unsigned`. `elpa/indent-guide` is an orphan -- nothing declares it.
- Expects the JetBrains Mono font (height 150 on macOS, 90 on Linux); if missing, the face silently falls back.
- Lock files and classic `#auto-save#` files are off (`create-lockfiles nil`, `auto-save-default nil`), but **backups are on** (`hjertnes.org:60`): `make-backup-files t`, copied, versioned, 6 new / 2 old kept.
- `auto-save-visited-mode` writes the visited file every 10s, gated by `hjertnes/auto-save-visited-safe-p`: remote (TRAMP/sudo) files and anything under `~/Documents` or `~/Library/Mobile Documents` are excluded, compared via `file-truename` so symlinked routes into synced trees are caught too. `global-auto-revert-mode` reloads on external change.
- `electric-pair-mode` is explicitly disabled in favour of global smartparens.
- `markdown-mode` shells out to `multimarkdown` for preview/export -- an external binary this repo does not install.
- Everything user-defined is namespaced `hjertnes/`. Custom keys live only in `hjertnes.org`: `M-p` projectile map, `M-o` ace-window, `<f5>` deadgrep, `C-:` avy, `M-s M-s` yasnippet, `C-c j j` org-journal (yearly files under `~/txt/notes/journal/`).
- `server-mode` is enabled unconditionally, so `make smoke` starts an Emacs server inside the batch process as well.
- Harmless in batch/non-GUI runs: repeated `highlight-indent-guides cannot auto set faces` errors and emojify image-download warnings.
- macOS: `exec-path-from-shell` imports `$PATH`; Command = `super`, right Option/Command disabled, native fullscreen, `ns-appearance` light.
- Most of the directory is gitignored Emacs runtime state (`elpa/`, `emojis/`, `transient/`, `eln-cache/`, `network-security.data`, `smex-items`, `*.~undo-tree~`). Two leftovers linger: a stale `eln-cache/` from before the early-init redirect, and a tracked `racket-mode/Racket-REPL` even though racket-mode is not configured.
- `README.md` is a short historical intro; `Specification.md` is a prose spec of loader/editor behavior and is stale (it claims backups and auto-save are disabled). Neither drives startup -- `hjertnes.org` is the source of truth.
