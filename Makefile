PUB := _pub

# FILT_PUB  := sed -E 's/<del>[^<]+<\/del>/------/g'

default: pub
pdf: letter.pdf

letter.pdf: letter.tex
	tectonic $<
letter.tex: template.sh.tex letter.md
	esh $< > $@

pub: $(PUB)/index.html $(PUB)/style.css $(PUB)/fonts.css
conf: confidential.html

index.html: index.sh.html letter.md redact.sh
	esh $< | ./redact.sh > $@

confidential.html: index.sh.html letter.md
	esh $< > $@

fonts.css: fonts.sh.css fonts/*/stylesheet.css
	esh $< > $@

$(PUB)/%: %
	cp -au $< $@
