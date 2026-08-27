clean:
	rm -rf elpa
	rm -f custom.el
	touch custom.el
	touch personal.el
init:
	touch custom.el
	touch personal.el
# Fast hermetic check: evaluates only hjertnes/load-forms from init.el and
# exercises it against the three read-failure shapes. No packages, no network.
test:
	emacs --batch -l tests/load-forms-test.el
	emacs --batch -l tests/calc-eval-test.el
# Full-startup smoke test: runs the real loader (tangle + form-by-form eval).
# Passes when the output contains the init.el sentinel line; needs elpa/
# present (a fresh machine would install packages over the network first).
smoke:
	emacs --batch -l init.el 2>&1 | grep "hjertnes.org loaded: 0 forms failed"
