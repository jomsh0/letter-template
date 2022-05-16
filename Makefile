PUB := _pub

FILT_PUB  := sed -E 's/<del>[^<]+<\/del>/------/g'
FILT_CONF := sed -E 's/<\/?del>//g'

default: pub
pdf: letter.pdf

letter.pdf: letter.tex
	tectonic $<
letter.tex: template.sh.tex letter.md
	$(FILT_CONF) < letter.md | esh $< | sed -E 's/\\linethickness/0.5pt/g'> $@

pub: $(PUB)/index.html $(PUB)/style.css $(PUB)/fonts.css
conf: confidential.html

index.html: index.sh.html letter.md
	esh $< | $(FILT_PUB) > $@

confidential.html: index.sh.html letter.md
	esh $< | $(FILT_CONF) > $@

fonts.css: fonts.sh.css fonts/*/stylesheet.css
	esh $< > $@

$(PUB)/%: %
	cp -au $< $@
