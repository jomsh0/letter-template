PUB := _pub

default: pub

pub: $(PUB)/index.html $(PUB)/style.css $(PUB)/fonts.css
conf: confidential.html

index.html: index.sh.html letter.md
	esh $< | sed -E 's/<del>[^<]+<\/del>/------/g' > $@

confidential.html: index.sh.html letter.md
	esh $< | sed -E 's/<\/?del>//g' > $@

fonts.css: fonts.sh.css fonts/*/stylesheet.css
	esh $< > $@

$(PUB)/%: %
	cp -au $< $@
