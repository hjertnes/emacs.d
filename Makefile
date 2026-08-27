# Everything is anchored to this Makefile's own directory, so `make -f` from
# anywhere acts on the repo, never on the caller's working directory.
ROOT := $(dir $(lastword $(MAKEFILE_LIST)))

.PHONY: init test smoke

# There is deliberately no `clean` target. The old one deleted Emacs-managed
# state, not build output: custom.el holds customize settings, and elpa/ is
# the config's only version snapshot ("copy elpa/ from a working machine" is
# the documented recovery in hjertnes.org's pinning policy).
init:
	touch $(ROOT)custom.el
	touch $(ROOT)personal.el

# Fast hermetic check: evaluates only the defuns under test from init.el /
# hjertnes.org and exercises them against failure shapes. No packages, no network.
test:
	emacs --batch -l $(ROOT)tests/load-forms-test.el
	emacs --batch -l $(ROOT)tests/calc-eval-test.el

# Full-startup smoke test: runs the real loader (tangle + form-by-form eval).
# Passes when the output contains the init.el sentinel line; needs the package
# snapshot present (a fresh machine would install packages over the network first).
smoke:
	emacs --batch -l $(ROOT)init.el 2>&1 | grep "hjertnes.org loaded: 0 forms failed"
